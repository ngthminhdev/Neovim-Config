-- configs/dap.lua

local dap = require('dap')

-- Dart
dap.adapters.dart = {
  type = 'executable',
  command = '/home/ngthminhdev/fvm/versions/2.8.1/bin/dart',
  -- command = '${workspaceFolder}/.fvm/flutter_sdk',
  args = {'debug_adapter'}
}

-- Flutter
dap.adapters.flutter = {
  type = 'executable',
  -- command = '/home/ngthminhdev/fvm/versions/2.8.1/bin/flutter',
  command = '/home/ngthminhdev/fvm/versions/3.19.0/bin/flutter',
  args = {'debug_adapter'}
}


dap.configurations.dart = {
  {
    type = "flutter",
    request = "launch",
    name = "[Local] KPOS",
    args = {
      "--flavor", "local",
    },
    dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
    flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
    platform = "android",  -- Chỉ định platform (android hoặc ios)
    autoReload = {
      enable = true,
    },
  },
  {
    type = "flutter",
    request = "launch",
    name = "[Staging] KPOS",
    args = {
      "--flavor", "local",
    },
    dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
    flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
    program = "${workspaceFolder}/lib/main_staging.dart",
    cwd = "${workspaceFolder}",
    platform = "android",  -- Chỉ định platform (android hoặc ios)
  },
  {
    type = "flutter",
    request = "launch",
    name = "[Production] KPOS",
    args = {
      "--flavor", "local",
    },
    dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
    flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
    program = "${workspaceFolder}/lib/main_production.dart",
    cwd = "${workspaceFolder}",
    platform = "android",  -- Chỉ định platform (android hoặc ios)
  },
  {
    type = "dart",
    request = "launch",
    name = "Launch dart",
    dartSdkPath = "/snap/bin/dart",
    flutterSdkPath = "/snap/bin/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  },
  {
    type = "flutter",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = "/snap/bin/dart",
    flutterSdkPath = "/snap/bin/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  },
}

