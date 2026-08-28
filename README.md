# devops-scripts

A collection of bash scripts I wrote while learning DevOps. Each script is a small practical tool that I use to practice system administration and deployment tasks.

## Scripts

| Script | What it does |
|--------|--------------|
| `system-info.sh` | Shows basic system information (OS, kernel, cpu, memory, disk, uptime) |
| `server-health.sh` | Quick health check: load, memory, disk, cpu, ports |
| `backup.sh` | Creates timestamped backups and keeps only the latest 7 |
| `service-manager.sh` | Start / stop / restart / check a service |
| `install-tools.sh` | Installs common devops tools (git, docker, kubectl, helm) |

## Usage

Most scripts accept no arguments and can be run directly:

```bash
./system-info.sh
./server-health.sh
```

The service manager takes two arguments:

```bash
./service-manager.sh nginx status
./service-manager.sh nginx restart
```

## Notes

- The backup script is configured with simple variables at the top.
- The install script works on Debian/Ubuntu/Kali based systems.
- Make scripts executable first with: `chmod +x script.sh`
