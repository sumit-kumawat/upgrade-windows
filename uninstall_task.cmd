@echo off
schtasks /delete /tn "CX-Win11-Upgrade" /f
echo CX Upgrade Task Removed
