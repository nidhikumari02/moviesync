const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 5000;

app.use(cors());
app.use(bodyParser.json());

let tasks = [];

app.get('/tasks', (req, res) => {
  res.json(tasks);
});

app.post('/tasks', (req, res) => {
  const { title } = req.body;
  if (!title.trim()) {
    return res.status(400).json({ error: 'Task title cannot be empty' });
  }
  const newTask = {
    id: Date.now().toString(),
    title,
    completed: false,
  };
  tasks.push(newTask);
  res.status(201).json(newTask);
});

app.delete('/tasks/:id', (req, res) => {
  const taskId = req.params.id;
  tasks = tasks.filter((task) => task.id !== taskId);
  res.sendStatus(204);
});

app.put('/tasks/:id', (req, res) => {
  const taskId = req.params.id;
  const { completed } = req.body;
  tasks = tasks.map((task) =>
    task.id === taskId ? { ...task, completed } : task
  );
  res.sendStatus(204);
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
