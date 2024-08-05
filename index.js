const core = require('@actions/core');
const { exec } = require('child_process');

async function run() {
  try {
    const input1 = core.getInput('branch');
    const input2 = core.getInput('versionfile');

    const command = `./entrypoint.sh ${input1} ${input2}`;
    exec(command, (error, stdout, stderr) => {
      if (error) {
        core.setFailed(`Error executing script: ${error.message}`);
        return;
      }
      if (stderr) {
        core.setFailed(`Script stderr: ${stderr}`);
        return;
      }
      console.log(`Script output: ${stdout}`);
    });
  } catch (error) {
    core.setFailed(`Action failed with error: ${error.message}`);
  }
}

run();