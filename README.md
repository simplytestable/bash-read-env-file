# bash-read-env-file
Read an env file and output key/value pairs, optionally into a template.

## Basic Usage

Use environment variable `ENV_FILE_PATH` to specify the path to the file to be read and then execute the script.

The following example works when executed from the root of this project:

```bash
ENV_FILE_PATH=tests/fixtures/multiple.env ./src/read-env-file.sh
```

```bash
KEY1=string
KEY2=12
KEY3=2.34
```

## Output Templates

By default, the env file is echo'd out as-is. You probably won't get much use from this. 

The keys and values defined in the env file can be output into a template. This I find useful.

Use environment variable `OUTPUT_TEMPLATE`, along with placeholders `{{ key }}` and `{{ value }}` to define how each
key/value pair is to be output.

The following example outputs the env file contents in the [Github Actions output parameter-setting format](https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-output-parameter):

```bash
ENV_FILE_PATH=tests/fixtures/multiple.env \
OUTPUT_TEMPLATE="::set-output name={{ key }}::{{ value }}" \
./src/read-env-file.sh
```

```bash
::set-output name=KEY1::string
::set-output name=KEY2::12
::set-output name=KEY3::2.34
```
