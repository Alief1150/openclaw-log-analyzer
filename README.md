# OpenClaw Log Analyzer

<p align="center">
  <img src="assets/Logo.png" alt="OpenClaw logo" width="180" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white" alt="Bash badge" />
  <img src="https://img.shields.io/badge/Language-Shell_script-111111?logo=gnubash&logoColor=white" alt="Shell badge" />
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Windows-0A84FF?logo=windows&logoColor=white" alt="Platform badge" />
  <img src="https://img.shields.io/badge/Assignment-Network%20Device%20Programming-7C3AED" alt="Assignment badge" />
</p>

this is just for my network device programming course assignment.

## What this repo is for

This repository contains a simple Bash-based OpenClaw log analyzer that demonstrates the 10 required shell topics from the task sheet.

Important: this repo uses `analyze_openclaw_simple.sh`, not `analyze_openclaw.sh`.

## Files

- `analyze_openclaw_simple.sh` — main Bash script
- `openclaw.log` — sample OpenClaw log input
- `assets/openclaw-logo.svg` — centered logo used in this README

## The 10 required points

The script and report cover these topics:

1. Pipeline used more than once
2. Regular expression with `grep -E`
3. Redirection to output file
4. Filter commands such as `grep`, `awk`, `cut`, `head`, `tail`, and `wc`
5. Environment variables: `LOG_LEVEL` and `OUTPUT_FILE`
6. Positional parameters: `$1`, `$2`, `$3`
7. User-defined variables
8. `echo` and `printf`
9. `history 5` or fallback history handling
10. Job control by showing the script PID and supporting background execution

## Quick start

### Linux distributions

1. Make sure Bash and common text utilities are installed.

   Debian/Ubuntu:
   ```bash
   sudo apt update
   sudo apt install bash coreutils grep gawk
   ```

   Fedora:
   ```bash
   sudo dnf install bash coreutils grep gawk
   ```

   Arch Linux:
   ```bash
   sudo pacman -S bash coreutils grep gawk
   ```

2. Make the script executable:
   ```bash
   chmod +x analyze_openclaw_simple.sh
   ```

3. Run the analyzer:
   ```bash
   export LOG_LEVEL=WARN
   export OUTPUT_FILE=laporan_openclaw.txt
   ./analyze_openclaw_simple.sh openclaw.log 'ERROR|WARN|gateway|telegram' 10
   ```

4. Open the report:
   ```bash
   cat laporan_openclaw.txt
   ```

### Windows

Recommended: use Git Bash or WSL.

1. Install one of these:
   - Git for Windows + Git Bash
   - Windows Subsystem for Linux (WSL)

2. Open Bash, then run:
   ```bash
   chmod +x analyze_openclaw_simple.sh
   export LOG_LEVEL=WARN
   export OUTPUT_FILE=laporan_openclaw.txt
   bash analyze_openclaw_simple.sh openclaw.log 'ERROR|WARN|gateway|telegram' 10
   ```

3. Read the report from the same shell:
   ```bash
   cat laporan_openclaw.txt
   ```

## Simple explanation

The script reads `openclaw.log`, searches for important log patterns, summarizes matches, and writes a report file. It also prints the PID so the task can be demonstrated in the background with `&`.

Example:

```bash
./analyze_openclaw_simple.sh openclaw.log 'ERROR|WARN|gateway|telegram' 10 &
jobs
```

## Hints and warnings

- Use Bash, not PowerShell or CMD, for the actual script execution.
- On Windows, `history` and job control work best inside Git Bash or WSL.
- Keep `openclaw.log` in the same folder as the script so paths stay simple.
- If you change the log file name, update the command accordingly.
- The script writes its report to the file named by `OUTPUT_FILE`.

## Example report command

```bash
export LOG_LEVEL=WARN
export OUTPUT_FILE=laporan_openclaw.txt
./analyze_openclaw_simple.sh openclaw.log 'ERROR|WARN|gateway|telegram' 10
```

## Notes for presentation

When explaining the assignment, mention these points in order:

- what the log analyzer does
- why `openclaw.log` is used
- how `LOG_LEVEL` and `OUTPUT_FILE` work
- how `$1`, `$2`, and `$3` are used
- where the pipelines and regex are used
- where redirection happens
- how the output report is generated
- how history and PID/job control are shown
