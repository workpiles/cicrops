import os
import json

def makeTrialOutputPath(output_path):
	env = json.loads(os.environ.get('TF_CONFIG', '{}'))

	taskInfo = env.get('task')

	if taskInfo:
		trial = taskInfo.get('trial', '')
		if trial:
			return os.path.join(output_path, trial)

	return output_path
