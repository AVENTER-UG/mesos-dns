# CHANGELOG

## 2026‑02‑11 : v0.10.1 
- CHANGE: [dns] "Subnet first" is disabled by default. Enable it with "ResolvSubnetFirst: true" in the config.json.

## 2026‑02‑10 : v0.10.0 
- ADD: [dns] If there are multiple IP addresses, output the IP address that is in the same subnet as the requesting IP address first.

## 2024‑12‑12 : v0.9.3 
- UPDATE: all Go modules

## 2024‑08‑08 : v0.9.2 
- UPDATE: all Go modules

## 2024‑01‑21 : v0.9.1 
- UPDATE: all Go modules

## 2023‑08‑01 : v0.9.0 
- UPDATE: all Go modules
- CHANGE: Migrate from jwt‑go to golang‑jwt
- ADD: support for reverse lookup (thanks to @christian‑marie)

## 2021‑08‑05 : v0.8.1 
- UPDATE: jwt‑go to the current version and fix the code to support the new library

## 2021‑06‑21 : v0.8.0 
- ADD: [dns] Generate additional Slave **SRV** records if **DiscoveryInfo** port name is specified

