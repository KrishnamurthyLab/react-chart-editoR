import { reactShinyInput } from 'reactR';
import Plotly from 'plotly.js/dist/plotly';
import PlotlyEditor from 'react-chart-editor';
import 'react-chart-editor/lib/react-chart-editor.css';
import React, { useState, useEffect } from 'react';

function Editor({ configuration, value, setValue }) {
  const [data, setData] = useState([]);
  const [layout, setLayout] = useState({});
  const [frames, setFrames] = useState([]);
  // const [isModalOpen, setIsModalOpen] = useState(false);

  useEffect(() => {
    const plot = document.getElementById(configuration.plotId);
    if (plot && plot.data && plot.layout) {
      setData(plot.data);
      setLayout(plot.layout);
      setFrames(plot.frames || []);
    }
  }, [configuration.plotId]);

  const config = { editable: true };

  const handleUpdate = (newData, newLayout, newFrames) => {
    setData(newData);
    setLayout(newLayout);
    setFrames(newFrames);

    // Update the existing plot
    Plotly.react(configuration.plotId, newData, newLayout, config);
  };

  return (
    <PlotlyEditor
      data={data}
      layout={layout}
      config={config}
      frames={frames}
      plotly={Plotly}
      onUpdate={handleUpdate}
      useResizeHandler
      debug
      advancedTraceTypeSelector
    />
  );
}

reactShinyInput(
  '.plotly_editor',
  'reactChartEditorTest.plotly_editor',
  Editor
);