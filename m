From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:37:34 +0200
Message-Id: <1330547854-18889-9-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 11/11] build: initial build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore                  |    7 +-
 _build.bat                  |   49 +++++++
 build.bat                   |   55 ++++++++
 build/MSCV-VSClass3.cer     |   29 ++++
 build/msvc-generate.js      |  118 +++++++++++++++++
 build/unix2dos.js           |   54 ++++++++
 build/vars.amd64.m4         |    2 +
 build/vars.i386.m4          |    2 +
 build/zip.js                |   74 +++++++++++
 config-env.bat.in           |   12 ++
 configure.bat               |   88 +++++++++++++
 installer/StrStr.nsi        |   47 +++++++
 installer/build.bat         |   88 +++++++++++++
 installer/icon.ico          |  Bin 0 -> 22486 bytes
 installer/install-whirl.bmp |  Bin 0 -> 25820 bytes
 installer/tap-windows.nsi   |  296 +++++++++++++++++++++++++++++++++++++++++++
 src/OemWin2k.inf.in         |  187 +++++++++++++++++++++++++++
 src/SOURCES.in              |    7 +-
 src/config.h.in             |    9 ++
 src/error.c                 |    4 +-
 src/i386/OemWin2k.inf.in    |  195 ----------------------------
 src/resource.rc             |    8 +-
 src/tapdrvr.c               |    9 +-
 version.m4                  |   11 ++
 24 files changed, 1144 insertions(+), 207 deletions(-)
 create mode 100644 _build.bat
 create mode 100644 build.bat
 create mode 100644 build/MSCV-VSClass3.cer
 create mode 100644 build/msvc-generate.js
 create mode 100644 build/unix2dos.js
 create mode 100644 build/vars.amd64.m4
 create mode 100644 build/vars.i386.m4
 create mode 100644 build/zip.js
 create mode 100644 config-env.bat.in
 create mode 100644 configure.bat
 create mode 100755 installer/StrStr.nsi
 create mode 100644 installer/build.bat
 create mode 100755 installer/icon.ico
 create mode 100755 installer/install-whirl.bmp
 create mode 100755 installer/tap-windows.nsi
 create mode 100755 src/OemWin2k.inf.in
 create mode 100644 src/config.h.in
 delete mode 100755 src/i386/OemWin2k.inf.in
 create mode 100644 version.m4

diff --git a/.gitignore b/.gitignore
index 230ee15..f10f92d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,10 +1,15 @@
 *.pdb
 *.sys
 *.map
+*.cat
 *.cod
+*.exe
+*.zip
+tmp
+config-local.m4
+config-env.bat
 src/obj*
 src/amd64
 src/i386
 src/SOURCES
-src/i386/OemWin2k.inf
 src/config.h
diff --git a/_build.bat b/_build.bat
new file mode 100644
index 0000000..718feb2
--- /dev/null
+++ b/_build.bat
@@ -0,0 +1,49 @@
+@echo off
+rem TAP-Windows -- A kernel driver to provide virtual tap
+rem                 device functionality on Windows.
+rem
+rem  Copyright (C) 2012      Alon Bar-Lev <alon.barlev@...277...>
+rem
+rem  This program is free software; you can redistribute it and/or modify
+rem  it under the terms of the GNU General Public License as published by
+rem  the Free Software Foundation; either version 2 of the License, or
+rem  (at your option) any later version.
+rem
+rem  This program is distributed in the hope that it will be useful,
+rem  but WITHOUT ANY WARRANTY; without even the implied warranty of
+rem  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+rem  GNU General Public License for more details.
+rem
+rem  You should have received a copy of the GNU General Public License
+rem  along with this program (see the file COPYING included with this
+rem  distribution); if not, write to the Free Software Foundation, Inc.,
+rem  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+setlocal enableextensions enabledelayedexpansion
+
+set root=%cd%
+set myos=%1
+set myprofile=%2
+set mymode=fre
+
+echo Building %myos%-%myprofile%-%mymode%
+
+call "%DDK%\bin\setenv" %DDK% %mymode% %myprofile% %myos% no_oacr
+if errorlevel 1 goto error
+
+cd /d %root%
+cd src
+nmake
+if errorlevel 1 goto error
+
+set rc=0
+goto end
+
+:error
+echo FAIL %myos%-%myprofile%-%mymode%
+set rc=1
+goto end
+
+:end
+
+endlocal
diff --git a/build.bat b/build.bat
new file mode 100644
index 0000000..839be8c
--- /dev/null
+++ b/build.bat
@@ -0,0 +1,55 @@
+@echo off
+rem TAP-Windows -- A kernel driver to provide virtual tap
+rem                 device functionality on Windows.
+rem
+rem  Copyright (C) 2012      Alon Bar-Lev <alon.barlev@...277...>
+rem
+rem  This program is free software; you can redistribute it and/or modify
+rem  it under the terms of the GNU General Public License as published by
+rem  the Free Software Foundation; either version 2 of the License, or
+rem  (at your option) any later version.
+rem
+rem  This program is distributed in the hope that it will be useful,
+rem  but WITHOUT ANY WARRANTY; without even the implied warranty of
+rem  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+rem  GNU General Public License for more details.
+rem
+rem  You should have received a copy of the GNU General Public License
+rem  along with this program (see the file COPYING included with this
+rem  distribution); if not, write to the Free Software Foundation, Inc.,
+rem  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+cd %0\..
+
+if not exist config-env.bat (
+	echo please run configure
+	exit /b 1
+)
+
+setlocal
+
+call config-env.bat
+
+for /d %%d in (src\obj*) do rmdir /q /s %%d > nul 2>&1
+for %%f in (src\amd64\*.sys src\i386\*.sys) do del /s %%f > nul 2>&1
+
+cmd /c _build WXP x86
+if errorlevel 1 goto error
+cmd /c _build WIN7 x64
+if errorlevel 1 goto error
+
+call installer\build
+
+set rc=0
+goto end
+
+:error
+echo FAIL
+set rc=1
+goto end
+
+:end
+
+endlocal
+
+exit /b %rc%
diff --git a/build/MSCV-VSClass3.cer b/build/MSCV-VSClass3.cer
new file mode 100644
index 0000000..78eae54
--- /dev/null
+++ b/build/MSCV-VSClass3.cer
@@ -0,0 +1,29 @@
+-----BEGIN CERTIFICATE-----
+MIIFAzCCAuugAwIBAgIKYQwSBgAAAAAAGzANBgkqhkiG9w0BAQUFADB/MQswCQYD
+VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEe
+MBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSkwJwYDVQQDEyBNaWNyb3Nv
+ZnQgQ29kZSBWZXJpZmljYXRpb24gUm9vdDAeFw0wNjA1MjMxNzAxMjlaFw0xNjA1
+MjMxNzExMjlaMF8xCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5j
+LjE3MDUGA1UECxMuQ2xhc3MgMyBQdWJsaWMgUHJpbWFyeSBDZXJ0aWZpY2F0aW9u
+IEF1dGhvcml0eTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAyVxZnvIbigEU
+tBDfBEDb41evakVAj4QMC9Ez2dkRz+4CWB8l9yqoRAWq7AMfeH+ek7maAKojfdas
+haJjRcdyJ8z0TMZ1cdI5709C8HXfCpDGjiBvmA/4rCNfcCk2pMmG57GaIMtTpYXn
+Pb59mv4kRTPcdhXtD6JxZExlLoFoRacCAwEAAaOCASMwggEfMBEGA1UdIAQKMAgw
+BgYEVR0gADA2BgkrBgEEAYI3FQcEKTAnBh8rBgEEAYI3FQiN4NGJToTXnMMHhqaG
++xyP07+mFQEZAgFuAgEAMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB0G
+A1UdDgQWBBTif3vYd9Xfngo/nrTLDi6p79tpdzAdBgkrBgEEAYI3FAIEEB4OAEMA
+cgBvAHMAcwBDAEEwHwYDVR0jBBgwFoAUYvsKIVt/Q24R2glUUGv10pZx8Z4wVQYD
+VR0fBE4wTDBKoEigRoZEaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwv
+cHJvZHVjdHMvTWljcm9zb2Z0Q29kZVZlcmlmUm9vdC5jcmwwDQYJKoZIhvcNAQEF
+BQADggIBAAHkRrM7RX91E4d+X0PeRo7Lir22R0G8zMx0kdjOOVGVpKa1R8Dv0tp7
+j1cR9DKMfM0/7kLaBCFK98hDiEpvXMoU/EvRn0y91FVuzAK+DaaIj4YJuqQlveiw
+8PqLcU5nsMuCqNeOVfc36/A+iO/k4Ir9HG4uYUFIdbSwLB0o2EkP1xXwJHMlPMyI
+DN4oTGVU/l6ujOoZrSxRsps6R/U8gDUBF+JJh9ZUSvtLqwe8v315z781AFy7ns/8
+gokbOaBRl7bewLMH/0SWRMA0Khlcq+7wO+wpTrUTxTeFfnXVtNYNBm610mwjcWfq
+8XGOr050qgz57L9MWPpekJttOcuGiD+LHKgWMtX+bbnx+LPq15H2Nkd4wCcqFcdo
+1vTF/E9OyGc/EC1An/EeyWFI56cD/DFzDPBGiP5W2kkple8J2qPlvu9g7NlUoFmc
+KL1U72YVf4dMhNumDpVnLlF7NDm2QcKMhGgm3CQCCeeBjgqXLe/up7mYpg+BjccQ
+teHtmC9Ib1OFSWR4m+xdrJcLVSbD77qNyNGlL1p/k2thGjObGLiiYhDeJOp24S9D
+6+zdfBI0JInaKFWu5XVOMStnY7ao16tzCgPOxepZP8frKkWuqGJbLwCZOau0X3PD
+COyAEY9HDo8qE0PhkQZiVbv/uj2pqT0mD67KfWKLFVWJ1pQ0TdZl
+-----END CERTIFICATE-----
diff --git a/build/msvc-generate.js b/build/msvc-generate.js
new file mode 100644
index 0000000..d9564cf
--- /dev/null
+++ b/build/msvc-generate.js
@@ -0,0 +1,118 @@
+/*
+ * msvc-generate.js  - string transformation
+ *
+ * Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+ *
+ * BSD License
+ * ============
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *     o Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *     o Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     o Neither the name of the Alon Bar-Lev nor the names of its
+ *       contributors may be used to endorse or promote products derived from
+ *       this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+var ForReading = 1;
+var fso = new ActiveXObject("Scripting.FileSystemObject");
+var input = "nul";
+var output = "nul";
+var files = new Array();
+var env = new Array();
+
+function initialize() {
+	for (var i=0;i<WScript.Arguments.length;i++) {
+		var arg = WScript.Arguments(i);
+		if (arg.match(/^--input=(.*)$/)) {
+			input=RegExp.$1;
+		}
+		else if (arg.match(/^--output=(.*)$/)) {
+			output=RegExp.$1;
+		}
+		else if (arg.match(/^--config=(.*)$/)) {
+			files.push(RegExp.$1);
+		}
+		else if (arg.match(/^--var=([^=]*)=(.*)$/)) {
+			env[RegExp.$1] = RegExp.$2;
+		}
+	}
+}
+
+function process_config(vars, file) {
+	try {
+		var fin = fso.OpenTextFile(file, ForReading);
+
+		while (!fin.AtEndOfStream) {
+			var content = fin.ReadLine();
+			if (content.match(/^[ \t]*define\(\[(.*)\],[ \t]*\[(.*)\]\)[ \t]*/)) {
+				vars[RegExp.$1] = RegExp.$2;
+			}
+		}
+	}
+	catch(e) {
+		throw new Error(1, "Cannot process '" + file + "'.");
+	}
+}
+
+function process_file(vars, input, output) {
+	var fin = fso.OpenTextFile(input, ForReading);
+	var fout = fso.CreateTextFile(output);
+	var content = fin.ReadAll();
+
+	for (var i in vars) {
+		content = content.replace(new RegExp("@"+i+"@", "g"), vars[i]);
+	}
+
+	fout.Write(content);
+}
+
+function build_vars() {
+	var vars = new Array();
+	for (var f in files) {
+		process_config(vars, files[f]);
+	}
+	for (var e in env) {
+		vars[e] = env[e];
+	}
+	return vars;
+}
+
+function main() {
+	try {
+		initialize();
+
+		var vars = build_vars();
+
+		process_file(
+			vars,
+			input,
+			output
+		);
+
+		WScript.Quit(0);
+	}
+	catch(e) {
+		WScript.Echo("ERROR: when procssing " + output + ": " + e.description);
+		WScript.Quit(1);
+	}
+}
+
+main();
diff --git a/build/unix2dos.js b/build/unix2dos.js
new file mode 100644
index 0000000..51ee7c9
--- /dev/null
+++ b/build/unix2dos.js
@@ -0,0 +1,54 @@
+/*
+ * unix2dos.js  - a simple unix2dos implementation in jscript.
+ *
+ * Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+ *
+ * BSD License
+ * ============
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *     o Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *     o Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     o Neither the name of the Alon Bar-Lev nor the names of its
+ *       contributors may be used to endorse or promote products derived from
+ *       this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+var ForReading = 1;
+
+try {
+	var fso = new ActiveXObject("Scripting.FileSystemObject");
+	for (var i=0;i<WScript.Arguments.length;i++) {
+		var file = WScript.Arguments(i);
+		var tmp = file+".tmp";
+		var fin = fso.OpenTextFile(file, ForReading);
+		var fout = fso.CreateTextFile(tmp);
+		fout.Write(fin.ReadAll().replace(/\n/g, "\r\n"));
+		fin.Close();
+		fout.Close();
+		fso.DeleteFile(file);
+		fso.MoveFile(tmp, file);
+	}
+	WScript.Quit(0);
+}
+catch(e) {
+	WScript.Echo("ERROR: " + e.description);
+	WScript.Quit(1);
+}
diff --git a/build/vars.amd64.m4 b/build/vars.amd64.m4
new file mode 100644
index 0000000..2613250
--- /dev/null
+++ b/build/vars.amd64.m4
@@ -0,0 +1,2 @@
+define([INF_PROVIDER_SUFFIX], [, NTamd64])
+define([INF_SECTION_SUFFIX], [.NTamd64])
diff --git a/build/vars.i386.m4 b/build/vars.i386.m4
new file mode 100644
index 0000000..9bd4d31
--- /dev/null
+++ b/build/vars.i386.m4
@@ -0,0 +1,2 @@
+define([INF_PROVIDER_SUFFIX], [])
+define([INF_SECTION_SUFFIX], [])
diff --git a/build/zip.js b/build/zip.js
new file mode 100644
index 0000000..6550d8a
--- /dev/null
+++ b/build/zip.js
@@ -0,0 +1,74 @@
+/*
+ * zip.js  - a simple zip implementation in jscript.
+ *
+ * Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+ *
+ * BSD License
+ * ============
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *     o Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *     o Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     o Neither the name of the Alon Bar-Lev nor the names of its
+ *       contributors may be used to endorse or promote products derived from
+ *       this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+var ForReading = 0;
+var ForWriting = 1;
+var fso = new ActiveXObject("Scripting.FileSystemObject");
+
+function zip(source, destination) {
+	try {
+		var f = OpenTextFile(destination, ForReading);
+		f.Close();
+	}
+	catch(e) {
+		var f = fso.CreateTextFile(destination, ForWriting);
+		var zipheader = "PK" + String.fromCharCode(5) + String.fromCharCode(6);
+		for (var i=0;i<18;i++) {
+			zipheader += String.fromCharCode(0);
+		}
+		f.Write(zipheader);
+		f.Close();
+	}
+
+	var shell = new ActiveXObject("Shell.Application");
+	var source = shell.NameSpace(fso.GetAbsolutePathName(source));
+	var destination = shell.NameSpace(fso.GetAbsolutePathName(destination));
+	
+	destination.CopyHere(source.Items(), 4);
+	while(source.Items().Count != destination.Items().Count) {
+		WScript.Sleep(1000);
+	}
+}
+
+var index = 0;
+var source = WScript.Arguments(index++);
+var destination = WScript.Arguments(index++);
+try {
+	zip(source, destination);
+	WScript.Quit(0);
+}
+catch(e) {
+	WScript.Echo("ERROR: Cannot zip '" + destination + "'.");
+	WScript.Quit(1);
+}
+
diff --git a/config-env.bat.in b/config-env.bat.in
new file mode 100644
index 0000000..ed38c15
--- /dev/null
+++ b/config-env.bat.in
@@ -0,0 +1,12 @@
+set DDK=@DDK@
+set DEVCON32=@DEVCON32@
+set DEVCON64=@DEVCON64@
+set DEVCON_BASENAME=@DEVCON_BASENAME@
+set SIGNTOOL=@SIGNTOOL@
+set MAKENSIS=@MAKENSIS@
+set CODESIGN_PKCS12=@CODESIGN_PKCS12@
+set CODESIGN_PASS=@CODESIGN_PASS@
+set PRODUCT_TAP_WIN_COMPONENT_ID=@PRODUCT_TAP_WIN_COMPONENT_ID@
+set PRODUCT_NAME=@PRODUCT_NAME@
+set PRODUCT_VERSION=@PRODUCT_VERSION@
+set OUTDIR=@OUTDIR@
diff --git a/configure.bat b/configure.bat
new file mode 100644
index 0000000..8673d5a
--- /dev/null
+++ b/configure.bat
@@ -0,0 +1,88 @@
+@echo off
+rem TAP-Windows -- A kernel driver to provide virtual tap
+rem                 device functionality on Windows.
+rem
+rem  Copyright (C) 2012      Alon Bar-Lev <alon.barlev@...277...>
+rem
+rem  This program is free software; you can redistribute it and/or modify
+rem  it under the terms of the GNU General Public License as published by
+rem  the Free Software Foundation; either version 2 of the License, or
+rem  (at your option) any later version.
+rem
+rem  This program is distributed in the hope that it will be useful,
+rem  but WITHOUT ANY WARRANTY; without even the implied warranty of
+rem  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+rem  GNU General Public License for more details.
+rem
+rem  You should have received a copy of the GNU General Public License
+rem  along with this program (see the file COPYING included with this
+rem  distribution); if not, write to the Free Software Foundation, Inc.,
+rem  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+cd %0\..
+
+if "%1"=="--help" (
+	echo %0
+	echo Environment:
+	echo     DDK               DDK home
+	echo     SIGNTOOL          signtool, default from DDK
+	echo     DEVCON32          devcon, default from DDK
+	echo     DEVCON64          devcon, default from DDK
+	echo     MAKENSIS          nullsoft installer
+	echo     CODESIGN_PKCS12   Code sign PKCS#12 optional
+	echo     CODESIGN_PASS     Code sign password
+	echo     OUTDIR            Output directory
+	exit /b 1
+)
+
+setlocal
+
+if "%DDK%"=="" for /d %%f in (c:\WINDDK\*) do set DDK=%%f
+
+if "%DDK%"=="" (
+	echo cannot find ddk
+	goto error
+)
+
+if "%SIGNTOOL%"=="" set SIGNTOOL=%DDK%\bin\x86\signtool.exe
+if "%DEVCON32%"=="" set DEVCON32=%DDK%\tools\devcon\i386\devcon.exe
+if "%DEVCON64%"=="" set DEVCON64=%DDK%\tools\devcon\amd64\devcon.exe
+for /f %%f in ("%DEVCON32%") do set DEVCON_BASENAME=%%~nf%%~xf
+
+if "%MAKENSIS%"=="" for /d %%f in ("%ProgramFiles%\NSIS" "%ProgramFiles(x86)%\NSIS") do if exist "%%f" set MAKENSIS=%%~f
+
+if "%MAKENSIS%"=="" (
+	echo cannot find nsis
+	goto error
+)
+
+if "%OUTDIR%"=="" set OUTDIR=%cd%
+
+set msvcg_args=cscript //nologo build/msvc-generate.js --config=version.m4
+if exist config-local.m4 set msvcg_args=%msvcg_args% --config=config-local.m4
+set msvcg_args=%msvcg_args% --var=DDK="%DDK%" --var=MAKENSIS="%MAKENSIS%" --var=SIGNTOOL="%SIGNTOOL%" --var=DEVCON32="%DEVCON32%" --var=DEVCON64="%DEVCON64%" --var=DEVCON_BASENAME="%DEVCON_BASENAME%" --var=EXTRA_C_DEFINES="%EXTRA_C_DEFINES%" --var=CODESIGN_PKCS12="%CODESIGN_PKCS12%" --var=CODESIGN_PASS="%CODESIGN_PASS%" --var=OUTDIR="%OUTDIR%"
+
+for %%f in (config-env.bat src\SOURCES src\config.h) do (
+	%msvcg_args% --input=%%f.in --output=%%f
+	if errorlevel 1 goto error
+)
+
+for %%a in (i386 amd64) do (
+	mkdir src\%%a > nul 2>&1
+	%msvcg_args% --config=build\vars.%%a.m4 --input=src\OemWin2k.inf.in --output=src\%%a\OemWin2k.inf
+	if errorlevel 1 goto error
+)
+
+set rc=0
+goto end
+
+:error
+echo FAILED
+set rc=1
+goto end
+
+:end
+
+endlocal
+
+exit /b %rc%
diff --git a/installer/StrStr.nsi b/installer/StrStr.nsi
new file mode 100755
index 0000000..0bad0f2
--- /dev/null
+++ b/installer/StrStr.nsi
@@ -0,0 +1,47 @@
+;====================================================
+; StrStr - Finds a given string in another given string.
+;               Returns -1 if not found and the pos if found.
+;          Input: head of the stack - string to find
+;                      second in the stack - string to find in
+;          Output: head of the stack
+;====================================================
+!macro StrStr un
+Function ${un}StrStr
+  Push $0
+  Exch
+  Pop $0 ; $0 now have the string to find
+  Push $1
+  Exch 2
+  Pop $1 ; $1 now have the string to find in
+  Exch
+  Push $2
+  Push $3
+  Push $4
+  Push $5
+
+  StrCpy $2 -1
+  StrLen $3 $0
+  StrLen $4 $1
+  IntOp $4 $4 - $3
+
+  StrStr_loop:
+    IntOp $2 $2 + 1
+    IntCmp $2 $4 0 0 StrStrReturn_notFound
+    StrCpy $5 $1 $3 $2
+    StrCmp $5 $0 StrStr_done StrStr_loop
+
+  StrStrReturn_notFound:
+    StrCpy $2 -1
+
+  StrStr_done:
+    Pop $5
+    Pop $4
+    Pop $3
+    Exch $2
+    Exch 2
+    Pop $0
+    Pop $1
+FunctionEnd
+!macroend
+!insertmacro StrStr ""
+;!insertmacro StrStr "un."
diff --git a/installer/build.bat b/installer/build.bat
new file mode 100644
index 0000000..79405b5
--- /dev/null
+++ b/installer/build.bat
@@ -0,0 +1,88 @@
+@echo off
+rem TAP-Windows -- A kernel driver to provide virtual tap
+rem                 device functionality on Windows.
+rem
+rem  Copyright (C) 2012      Alon Bar-Lev <alon.barlev@...277...>
+rem
+rem  This program is free software; you can redistribute it and/or modify
+rem  it under the terms of the GNU General Public License as published by
+rem  the Free Software Foundation; either version 2 of the License, or
+rem  (at your option) any later version.
+rem
+rem  This program is distributed in the hope that it will be useful,
+rem  but WITHOUT ANY WARRANTY; without even the implied warranty of
+rem  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+rem  GNU General Public License for more details.
+rem
+rem  You should have received a copy of the GNU General Public License
+rem  along with this program (see the file COPYING included with this
+rem  distribution); if not, write to the Free Software Foundation, Inc.,
+rem  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+setlocal
+
+set wd=%cd%
+cd %0\..
+
+if "%MAKENSIS%"=="" call ..\config-env.bat
+
+if "%OUTDIR%"=="" set OUTDIR=.
+set OUTPUT=%OUTDIR%\tap-windows-%PRODUCT_VERSION%
+set TAP_ROOT=tmp\image\tap-windows-%PRODUCT_VERSION%
+
+del "%OUTPUT%.*" > nul 2>&1
+rmdir /q /s tmp > nul 2>&1
+
+mkdir %TAP_ROOT%\include
+copy ..\src\tap-windows.h %TAP_ROOT%\include
+if errorlevel 1 goto error
+mkdir %TAP_ROOT%\i386
+copy ..\src\i386\*  %TAP_ROOT%\i386
+if errorlevel 1 goto error
+mkdir %TAP_ROOT%\amd64
+copy ..\src\amd64\* %TAP_ROOT%\amd64
+if errorlevel 1 goto error
+
+type ..\COPYING > %TAP_ROOT%\license.txt
+type ..\COPYRIGHT.GPL >> %TAP_ROOT%\license.txt
+cscript //nologo ..\build\unix2dos.js %TAP_ROOT%\license.txt
+if errorlevel 1 goto error
+
+"%DDK%\bin\selfsign\inf2cat" /driver:%TAP_ROOT%\i386 /os:XP_X86,Vista_X86,7_X86,Server2003_X86,Server2008_X86
+"%DDK%\bin\selfsign\inf2cat" /driver:%TAP_ROOT%\amd64 /os:XP_X64,Vista_X64,7_X64,Server2003_X64,Server2008_X64,Server2008R2_X64
+
+if not "%CODESIGN_PKCS12%"=="" (
+	for %%a in (i386 amd64) do (
+		"%SIGNTOOL%" sign /v /p "%CODESIGN_PASS%" /f "%CODESIGN_PKCS12%" /ac ..\build\MSCV-VSClass3.cer /t http://timestamp.verisign.com/scripts/timestamp.dll "%TAP_ROOT%\%%a\%PRODUCT_TAP_WIN_COMPONENT_ID%.sys"
+		"%SIGNTOOL%" sign /v /p "%CODESIGN_PASS%" /f "%CODESIGN_PKCS12%" /ac ..\build\MSCV-VSClass3.cer /t http://timestamp.verisign.com/scripts/timestamp.dll "%TAP_ROOT%\%%a\%PRODUCT_TAP_WIN_COMPONENT_ID%.cat"
+		if errorlevel 1 goto error
+	)
+)
+
+cscript //nologo ..\build\zip.js tmp\image "%OUTPUT%.zip"
+if errorlevel 1 goto error
+
+"%MAKENSIS%\makensis" -DDEVCON32="%DEVCON32%" -DDEVCON64="%DEVCON64%" -DDEVCON_BASENAME="%DEVCON_BASENAME%" -DPRODUCT_TAP_WIN_COMPONENT_ID="%PRODUCT_TAP_WIN_COMPONENT_ID%" -DPRODUCT_NAME="%PRODUCT_NAME%" -DPRODUCT_VERSION="%PRODUCT_VERSION%" -DOUTPUT="%OUTPUT%.exe" -DIMAGE="%TAP_ROOT%" tap-windows.nsi
+if errorlevel 1 goto error
+
+if not "%CODESIGN_PKCS12%"=="" (
+	"%SIGNTOOL%" sign /v /p "%CODESIGN_PASS%" /f "%CODESIGN_PKCS12%" /t http://timestamp.verisign.com/scripts/timestamp.dll "%OUTPUT%.exe"
+		if errorlevel 1 goto error
+	)
+)
+
+set rc=0
+goto end
+
+:error
+echo FATAL
+set rc=1
+goto end
+
+:end
+
+cd %wd%
+
+endlocal
+
+exit /b %rc%
diff --git a/installer/icon.ico b/installer/icon.ico
new file mode 100755
index 0000000000000000000000000000000000000000..03ea0b1dccf355d4f5ac877c0918b374c7b7c4ee
GIT binary patch
literal 22486
zcmeHP2Xs`$*PoC;=v7f_5_*>+QUvK$P!N@...1554...&#s6adn3Cc*gzDOq9}-B14RTxYJh<B
zrUHT@...1555...?Io$vRX_vY=(vRO8Wp6`E-?|3uq&b@...1556...?z?67p%7uBm?&Rf;3+Of
z6cu7PYSGa~dscBFwxh3kbF*Dmh-U!?ezX`7Aw<m@...1557...(OsOg=p4Nhz6KW
z7SVt(@KH~gQP}?;I-4gqtY0hJy`3&&5<K#Q^;z=UpR(nKb!+7-i!)_rW|r*xUWRP+
zx<__+H(mChnjxoc%$6T-&X!+o&z1+0_sQAYvgI}7(xunym2nF)WnNyMd}no*+_-+7
zOixdjhYuZ;w@...1558...)s6^o$I-c6E~6x_OhFkd!6YtXe4>zUGl_C#1_)mt@...1559...
zhY!h|JSo4}k}aS6E>k*ZdF4y<y)y0mdAakapXAfuc)=@E=Hz6{O&iwBT4Ox&NNS#Z
zVV)N}*UGk7OM_QEaysO^?+dSt{n9HB>`#_W$EM4PYqI1mA7;oufZq@...1560...+H*WtF4~nX
z&!0OdQ%>i}XCeQtojc_7pjGb`k91)VP8>fjm+a1wlYhvPA8g2yxsdJ9!4$b*N47ln
zSDswGYK0u~Q3lqUA#-zc<=vlq<>7+|WmZ<U{Qb9I<zsWbvc>pxITd?*{9K;A{o@...1561...|
z`<Gqv{dHM#%GxaX3D%jkB2h+T|MBSKVdX#gZx8-a9dPowwMVgHO|DT@{JFQYvu12;
z*p=eOdhF`%sP7yS8+*62uVZL`r!&IgXzJ_}8(Y^I>2Oqbwk+vzbaD<F7~9o(i^I{Y
z+Z_%^cv0uoHKH3kyR>jPqHc3IN;{if6&rhPb!SzF<E~l`#}&?Mv3SZmYdajRi#QyO
zoHw!Eo&<}ubvQ~mi#G@...1562...;Uy~A-`1<F+voMVLZ
zJ|H+s^lVj{<vr-{&5H3fAfB`AFr!s5LN%Sv0c{$VD%Gyv4Q%R{?NUqH*=Rs#fMsW4
zqy3*<JARfw|F~Ty|CuX~9yuaw!)8sv`@il$jvT!-Q+^9u^4p$0^3Kn^GTq}*w(<5)
zGUVfPGiCQF8Ok1>_vXoAGre-}$y|97Hfa%T(t=$%@*db5+UL)<X3H6yU=v|?X%Bxp
zkt_Sd*6oLl{vm0VvSou{r)cYGqnGT-ky$xX=HyD54cKusSFT>ULivG{=kw%1*z6y-
zZI$C!X31BUWy$SZx5!zr`8$64QQ6du@...1563...+0!ZN&9kST4tVnc#c;#
ze<NL{oXJx*@%6+kWh?1#{ycR`-uOX=?D>9%^kz$C<41m*DIfUCE4LobmD$<Z^33Ve
z@?O~PHt-9yrSu68e(jaJVXse~JR#5h^_NUJuwVHN`hYLsgI4U#QGTn{o9S}?&K%`~
zGO@...1564...`n>NYcuxI=B?v=^=ewW>_pSRA)P(FgbXziNSa@`MW<a$8Y$r-TQhRt7-oFo5C
z%agzE{zdLPl`EJ1nj^peB}bk;b4HH(K2ttDKNGlFa^B8t$eblTSyFD_vRNKGdPL6r
z&!+#Qb_?&<{}g?<@2L}BBCJJ=u*V0q^Yz(lb*jawr_saqUZY;QA<7cQcr#SH6u0Bt
z{j{qn+AkU7v8dK{m91c5Twl`VYJ=9T#`qPemUg+CK4v1+yUOKqUDv?vZucM&8kIsn
zyP95aAjF{ViYS6cGmf|J<aSrMgMDSyczae|t}D^FkK?USX=wCO$a+1DdL-(DIDQ){
zql~`VknuUA>gs^*QjIX)50&O-XH~bmj8VP4E4tl-<Km)kMA^h)^!8|QLxfSQ%;85y
zU_6|)VrF;4%EoYacE*x@...1565...(u_b(}nw+?O-HhS5I8tb7j6c)IDBGedOpo7F$L+q?
zU{JE68t3kG8m7mGKMM)3Rs*#RJ{+&pT8}^Qyfy9|XwWYP`mOZ%i)h@^SPfj&*%&X4
zuBY_)AT-P!>{ZtoFIOLZHya31sJd$z{X?qXZ&uj(l&Ds%RX5hmX^m^BlLku1k?eNY
z!P4+_scp=vS>FAGQFC2aLyf3EU2B@...1566...#2<&P0f18D)kJE^2Kj5yB_L^p1$T$xLiH1
zd9>2VVs~{nM_sO=Y65i8_ZZ7I+A#(_cUj-Cz1H94=Wfv3-mUA`zF<yAQQDG0kGdkc
zW7gBwR5LwXv%NKBR_b1BoG38vFL`Ia$tFhiy4SQRS+YatCvULL^^XVs?Ka~Srj+*r
ztT?3v8h%e>#1X@...1567...*!fCy~^j)r!(H5Zyk;NY#`!?>4-6yb1|M70iV4ec@...1568...
z$aBsim&!yg$b9iA@+12E7vV1%TWs6BS$=}tkvZS-qetZ)<Ut3LlT}VdU(ML02l6uJ
zP0almTWn0pRWZdm#6KCxCx1SYE1#T~DZfMPlMVmtNlTNASAIE`EAK<D$Jm4M&Y5(?
z8t~t(-%3~U5c4j^MvR*n|Im-$JS{`+MBK9taR+0UImmr~*|9^#J&c_g6V!Rxqv8t2
z3XDr8ArE9OS|2%PC&WLDZ5VIt`+cv9>lj-wwqpFln1C_PG30%x|NK+MXk8|!%Qp~H
zF@...1569...?!u*mk*pWXDs~B*@+8<P`wt3?QnSp$nxiRzJ-Me<m)U#(*yuo-$$3@...1570...)xe
z&B#-6OlD@...1571...^?EQ6*Jagu>?2WvA+zRBc$Uzy;F{geTIr?Pepa12a|68#HUfF*v
z_OY2PquSot`;nWgcj;2S*29AvTwo0^KzFxyX!jHs*Rtt_;}`Ul^5Kt+xM0-QaSffb
z+g-zl&j<znk}=T*Pt86z8ixNFAO4*Rt5c82au=Z2d(q{hzlBHcWliX<I^bf9GuE;{
zS9XK_uN0-auGaW1pHS^E3=O@;j_tl;C>_cGV*yWV{HqmCR3(m;w@)ZnoLw$gV}(#w
z<5ySBGDaZP&nA-goV67~1&x1?YCdStauv50UBc{f#ndE5M0az75h*s(qbh*H_!Wb6
zPgRDDZg*D$|EVTy)O<{j_UOpA+iekWxfsq^@ra7t+}GWx@...1564...&ap@...1572...|-Fm^wudhRml
z*HVpJEOeKv9ee87Iv!OhO|McDs;P!OaA4eddsQEPi@...1573...{L{H*h)mJs#;l6PfR`8^+
zSxI|$rJ~(U<*eDkhcV3UhTiDMI4-yIftHH?aFf9e12lrGTg_X|I1F9J?z=0fXqhv5
z4K^eyV&UI-T~Xie^iiWvDB+22y<a-a!n97l?J8+#)V&6(@z;1^nhA?R2}>7T_bdId
zX+Nf1WxT+?6-P!|Q;pN>Z6_ZWXQTpV)Ckl@...1574...?lS}5@?Wj5v+!KCj9O8cfV)OEYf
zTu5`d0N*#2nT^|x$lv}LI^omEJE~anmsh82DZiR^l~WOU)<Oy|W>sBAI9J0?-gqNz
zDqY2VJ2|Vrq7`A8hq$<&6;;;|AI-YP+pjt*F(Y!jD_RrUnhIoE10acJcJ;5K@...1575...
zluC53WtbngP2_=Yw@...1576...<)8Luzi_z~5rU9a9=P`I_9PaLRNE9-4{xdvJ$!{DU;w(z0%
zpg}V;E7jXvhvF7~P2YjKT+P{C#%BPKjxt@...1577...=bberpVP*BfcX>XZaE~7Ezs*?bHGp
z8s>gHT6d_jQg~gaqVD<)Us4&YH7GRic2<{JDPO#F={BwXdy%b~kMAY$$Fa2y{WWIL
zC0yj`V4S{zU%$;ouw60wEX@...1578...|_U*#SZEiP3w~C-^sACt#oYL5)C;1taHx<#MZB$zI
zx0znwi~*JNi*B1$G`74C&!~w;0lmAP)T;4A{S1Ey^Z}JhcP@~&p5cxv(`m@...1579...%9Z<9
zDONOqdi$kA|26;R9mxN?WwgOPz<oM?D-#yDJfiQr$HcN_iN#i}SpF6AnL{QlOkBRK
z%;5J9i|DvCAHIDq>!Ur-N5^}b&G>Fp*ox&#*E1g?puT7J;`QOR#-zmn=LPT!w|M$!
zOh=!L9+ftH^z2_m;?l)q_58$TOQwyV^D}u5R5%HqFHjb-(RkYI=lmJ>eQ-cv&aJlj
zBOdv9pTO973opUrGUwMsdEV-GdA4;Ne@...1580...*0ci$OMhNm5Ixm_kQ~r`LD9@...1481...<Fhi
z>j0jy_2q%box`W^7t5C|jmF$F054=|{FuRi5O8yC`0=POvD$9WmbT+giG@...1581...
zwfvAHdGWH9Q60yh6wxlv8Vf(cvl{h3toEq1$q&ug&%GO|=jsxDFDV&bN*ib4CwLB{
ze#mN%N_%g_M{53~dY&#Z|M^ER+(XX&-kR_B{CM5iKPmr}IP;(NT%JGVuiE~NQ<Q(b
zg`eQzem-GqOYHG|L#G@...1582...^A@...1583...<y49+|&*<rQ~NJ;?nZ0^B?s{wUO|0#a>#>A;I^
zJ@&L1J}p^1Fg;mtPtkWLaD3;S;PIdx1E4-X3{bxtTP4<lv-|)sHQMdjYW4f@...1576...<*Pi
zU6>dECqGT!+z<WcYC4ai|5Ok<XD~)x*Z6_T>KGphm=8E$!gna20z?7w&GAMFkrFP%
zT73KPG9Ut`f>0bEJ=lSL;YmWo<J*TM;HN|iky_69J_1AL?{=)=;Rh3bk3ZiF+N09M
zgt<RacLnq&0^kHp11tfo1JIr<1<U|E1}Fo)5}z*INV{Wz-`XzV5o{c`um8lOV(HT5
z<R1=51}OU#pv*=ebzBUeet^1_Z%+%w*N};N-3q!UCeQnkwu>@M4Zv5+vxdB9Em|*P
zMuYcg56}FLOW+%cIa2`C)90dJN)u0gx>uh;Y!LoqDdX6$chIJC?b<GXj(S-@...1584...<c
zcuN8L9r=>`IB4=8f@=fs)<O6Wrk*I94w*q?w2jUN)GGsm$xsaAi*0i#!(RBVqRn4F
zBNi=NC17*QfdBCTGVtsh!aj>W?;NK+BOjj)H`YTLxW0m92xKdAaE|q<%QK<V<{qpL
zz&{1NBj+z&BO1Jt%Cj#AJ|_TrA9YC|8Hj)H0JwV2AfD%Ib9QMRcq;(^MU?Hs1zYsm
zuMI-aUnjZmJA>fAL;j8rmH(y=3<|(Mj%WYE=f7&*dngD!`X{?S4hw?IJ($h&?E2OT
zo<I551!Vcj(1W^v$NPsge|t=!_t9R`7V{j!07(G*n7vLv9uxgyn$m0222h6IZ2Zro
zUY=v_S-S;sG3RQ)o*;C&-$enn0a-!t2J`*v^5zM#V2RRy@*V;>VdL*XeK_}K(b7b5
z6YQn={&xjkdt75*7wfG6v~m9Zy1kuxUq2yLeE$6gZU0`g@...1585...)ums6pGVc#tNK{R{i
ztiXHAeMk&KpMEviIlaJjJo0g}SZ?^An}YDxGB}9)>}S8}J#Yl!KLcZP3mhNq=}5i%
zVEz{U-Y15@|3~aW5!wpw9iTDj7jy=+vnvYVpNqNmViMBC?8WN@...1586...)dilJ{SW3v%sx5
zcgYW;&X~W*pL%$%03PemU(orGfBk6ipS4KwFAClVLg0TI{3}og>Wn$3`JXR<|625a
zUBDQ1uq*ff{rTIp?kx;~|3>QI#|t+b`ZwBh4d~coQ?1)9>1$pG*!%4D(bT{D5lfi*
z*Cho0w-R^cOqJJA|1XSTef*|j{FWg6cjF8q>Wn@...1587...<@4=HnWO$i2Xx8HOqTv|4
zf7HK(d~v;fZLB{4V4jr$@E_Cd;XH%3<Ng%iEMBc;=mr_S1^f=!2lyV)pS+P{h#nK*
ze~s8n#~+%Oz2uoR1yDwRpKr%Ijq!%0*M96N@!@>z1NN7^pl1<)qO5bzXMVRqbcc^H
zc{BE69%ZLxuW!LvIDq_b4uZ!ydjU<j54CU>&T0F_q;I#0FTY=>-i`O>Z50oFlq~A;
zeKXe0{AJrkXgV=Y-UQ0Q*u*ZMf1Ud<0%uxG*>=bhJ%)4PYgmV#Vyp;o?gAXS2(4c+
zUL2tLvuqD2$WGa1*#*3p0X@...1588...}8`>_wc7PqXpn5;x*?H@...1589...?Kt-O
zqyl(T2F3!6mF@...1590...%Uzl8EfhF1}Yg7eD)8>@EvHDx(IK(Jn_KIxlD3Q0G)_J@...1591...
z#GEyMLk7O%jH@...1592...$=~xPJxtF}seW18*5%DBx1o98AV2(4;JU|Goq;eju;e0Q#}p
z0JQ<ZXyhA{DUp(pH?pkTJF;w4>d3O?Qks{IOley>GO2C#@c6dX!w8~7bs?UwiOU6C
zFz}LrmlM2jP?rwo#luKkJOC&DhEXCu${Q9RnG%+S>xmR0A_=KNl*<t!Do+Tvj2DV;
z{_l38g?j23h5c_~)}(L|dp3FPtnx=@&cL|22%rX_JAii;Zvtil<^a9{d<J+MKp)!&
z5Ch<y2j{97aNy)4+Q#SG$3n|@u``12uH`<5*k`Nuxs-u1;BJ79buU(?0k<K5zEaFv
zvRbrw?X<wX**`10UK{*UXZYjA$VqHxz<Z;M$*sqk<CLcS^zppE<z2{S-)k+euWSw;
zjT9gF)i=NS*?tCN3L*ar%Fex?jTpLCf{KSJe<eU`Mc>Esa;%H~|3v`fIob#n7jWOW
zf0PBl*iG;6#md(?hjVRrN|ci}H4E?-pd{dO$X*6?<^!}XU7+YfhkCw!T<xJLe?^pM
zLR>=+B|l=rhi4?~e2}ufVB@...1593...^(u<jrLQ9z^XY4}>?{ueBAEj>dNoxnSi0K2hD{;J
ze-1cTQ-11CpLg&(2je_L#&7+2{f2f6b4=reTGqfk&bQ0XI(>gb#CD4BlzCPTMjd)D
z1o^iCCycVsMJ}jfV<R7l1l|1s_?<)_-@...1499...!dCLVQ<Ijq0zx;<FY<NfJO>;9DTJ3^5E
zW8f&8KV{x_``*_B&Flhr{*Hd;+o7z1v1Y+{55}6ND_XEYw)<Dg-x82_ku^L>`I##{
z^C|8^e0FmfXzKk5R5A|<<(+=)B6LXm7eEpEn^ySU2fsCGKTrm;1-iqv+oLv=pLd#E
zyO~#UUuTBE_f6mgI|J(cnGopkx2PI?2Y8>)J21*axd5vHc6sgf(-^BrpT{+G?WWJA
zecllQU)t7|fP&WWNeDFb+4fa*phIKl?6CWR@...1594...>KYi!rs<&v1_wGy1%~OQ;E2jBhpV
zVC72SQOEt)a2@(`L!?3auPPdl|3Tw7RK5R0gUCOL^3!j<`t?q`-Dm6^OlJSFL5g?&
zHOwj`jd(5pZBwk@...1595...`HN1fSdx>aF3E7?=FA$vAw&&?rQyIXPdUseg@...1596...=A)
zaE%-WciOz$rahr-fJndrfL-rd=bD-U)c*7CPTfrydq`RMZU*8NsE@...1597...*@|<SfM8
z1Hdh(=HgC<zkkog{T2NYWiuhreeN-gac#<0En1Rj_+IFrDF^RrHUk358>sIUa~|j0
z<C{RZ_CCXR!FDztb4Gl&(7J!8>`{O(0KE72-~TN1@...1598...#zj0qxbCMXN<y+@0CthxU*q
z)ZBg>aA~)AcW?w?m$9Ha?}&=1*a3S#9`Unze@...1599...{V<@Rr<0;dl^>D))S|BQ*Z
z>=5^IX^65g7N*^50tnUaya-&Sw*w{}vD<vcV~0YJU9W{PTqC^($FvmtyD$_y3fe#a
z{$9Wh)pl`>&6UqWylA^S=iUeV?OMz1Uou})dqDrk`%iVQMw}DMeF)d`gbDuZ3e^4s
zxFzW?jo*B&nBfY@...1600...?_%v-%xTCqtV~Q4o!(O4>gacQ6L<xZ!M~69SIl+%`vbKT
zfv4h?0h5l}?M=^1kX^6se#%dOc9-w>O|D^Dh%zx|nh_!{?~;_Bl9w%Sbp8$bUsm$N
zcknwXn?D#AqD*suH$6n$ueJPlPR%F(eSbs#1T8<m!?MZ$Mj>Ph6?cu2A9l0fyZQ8|
z)8CN)E+s$oX9&L)^!c(-<4EexBO$K!B=E{I?``txS@...1601...{77fTHo!Z7qUk)mR`1e
zg=lAdt47^tEb()QGEvX?n?s=YHBetW?Yky?V}1KX`#I(k&frtM_xuen+HLu;D9A(K
z6o|in-^0MG4=5<_^vCC2u(CnD@...1602...|X+<;(OL@...1603...|w)#>Z1YWaue*PRg|%1+t3
z0GRh52yspd@...1604...(SL7puktbxBv8gVG>&P05_rQ#ps4ubl#F+^GD<8)5{
zMTm2_X1*`VSMvAU4;E~-ub~uVqfI#&U>(ehCju%1RP6Kl!gZqQ%lJJPK2gz3@...1605...)
z9Ba)voLiWf<23NAtGS3H8sqom_wgMB<2c)0F7x;f0NR&(09^qU0en}K?4K@...1606...
zw#A;MK$G_*{yJMw+la-umkFLL0F<jBT>t(bfLjuv`12e_eF0rswp__(TZfXDGP939
zk8$(3uYVFvUOr>Ld!WssfAr^5P@...1499...#tL&e{apKExp5c5fQA)qwCh`V6B`%E|{#?Sdl
z%wLkE;tR^FWnPGHgeK12CT^Kz-kJDxhB17o@...1607...%6tf3MU!r^~wN3-t~_(^-u<(H1S<
zW5U1DKlH`DCcoLb<Nbr`yCwDeggI{E8{Z9ngSMs@...1608...=@lZ}R!pJk}N*v{t^<~<H5
zW6|XIO_Y`Xlz=sv-#lqv#ejPcAO&Ej6-xapi_e8;Pyu6yE`cWb?g!8xb_DQu2ra8F
znKSc_#tmQ|7mBR@...1609...)pwC%ijChGybN2Pu+b~*;I<6KJpY0wBHvwz<^
zmx0%%$QNu5_kniGU)F-!-~K;Z1M{&Gg^-<VqQ26;1lyB;V{A8Mr~xQwpM&*t4TZID
zmvc?4z@...1610...!DI|&>}}AvoN|Ri>r3!7V#U8NKi9~6x8#3e9Vfu!AwVemT3DQlp!+%?
z4G_v676vB=G^YYCRo4r%7RF8!0o<#?$QTGW6*N8pv<4JLhRcC_C3sS=J_RuLWn36Y
zMtdLkIR)@F;9h_ci~sww`>&rd4P(GQfDr)RZ!@NSA3&XB-g6V65uhZ%fBq%4rHl{b
z|2ouHCK>HxN#V!X|5{S`L6(t8;VCHd!c)Ri+(P7_OzI?rH#{XWDGHx2vBYOesbNN$
z5|$bn&(E2{Qp?5jb0&L<e^V9DHp_5txg?g6DUm4x5BT7FCVbHZjC>_{u?=29OUjUM
zo=L}~8&5t4-zdcwtBprH2|FMtr*P-7Oc7CDLHYTwz)%`AP2S*v@...1611...!+9s>D9v+bev1
hg?)-gDe+$tKG0&Bf+ewp&`~VaM_MRlQaJbh{{ZxLA(a3C

literal 0
HcmV?d00001

diff --git a/installer/install-whirl.bmp b/installer/install-whirl.bmp
new file mode 100755
index 0000000000000000000000000000000000000000..03f33fce96789420beb692679093506ca0685469
GIT binary patch
literal 25820
zcmeI5`EOlE701he!EbZ{T4*T<XrZ81P$-)~qNt^aMS#>oS~jU5#3q&`ZPG$R>5}eg
zplg~^pbJam=j=|L#QTzXiPzYPcRR_u?>#@;m(R?Zd+xmZ{G5kXRknCfH`BRu&ur&A
z=gc{0#_F|S=)U<p`@53#68>%G-&Op3%Xx1lJ@...1612...{`F{T8^3N8Kgq7ba=RgI+RSqD-
zuV7fgaP@...1613...=L-3@...1614...!Ep6+VD-<SB8L?WS3d_<{|qW}Si$gr;6Nq_
z=H}-73fW91m&@j|S-<einKP$P&-f*p&t|iUPeUgLdyaQgt~6xmWqN8dm&<8kKA(ps
zlgTX1&ugJ((&@8j&z{j&GPAR}nVD(7WPX00aRos@...1615...#~xb?Ch+*nu@...1616...%=ENRL*ew)
z6kYganrA$;sjre@...1617...~vy?M>=0*GY!XEkbCdy%RQ^V<*0&tGCxApb*0D?{eZZ<X4
zofsU@...1618...+4=4<5~!1{gK1XjrDL{3%k2IJC7ZO<ytaw>SS-v@...1619...
z42>K*cz~|8q_g8#ecfSdY02coc-`Sz3V~Y-k9T+ZgQ1)mH8(Z@...1620...$nDnoN8%m93LCi
z5<fFGHoABBPC)Yu+gn>E#>e~;@*T(8>8r7!jw*>yZz6{DpTMxKwYj^i1D5NcCMPE#
z>*?;Ao6BpVWLWX7%}vL<ItK^(_0vFqA1%P7bULkttu0OPa(pai189IM-31<*($glZ
zgC(vdbky6^4MbXETIe|1*3yiU(88{cV?D<iYOGuu>+7bbCVjoo-`CsH+~|*4tCQ*K
z?AX6|_vpwezmQ&72*X1se0ioXrm%Zws(3lPSr~!<ix`Of!7@@NJv=m|g_%qM`+JXf
z`@`3-Fs!Ai!RO-G=m`97Z)^1#iGpowX_}sng<)!Pf)ap2scLJQVG$vvevgCweT;2#
zA|5Sy&;VFpTu%)2qXHPSHf0cNYCL-;*38Hxn4BCQRvOJPn5Kq$v;YKJNQPI&gKF?K
z{L%K-+5`KU!pNxtz@...1621...>Lv%3X8fOWNoMJ_?#CctmAO2YUJZt*Mp<3qW&ltFhH;RRY
z1;1h<zw}onE|W~@=ZdiPAyu++GQ}1B_2sv~mfLacD7yfl`OG}t-PzjQi01b<TjUU>
zGc-8h>lbOQJPcWXdv;dus;=6V+Og9<2sOIJAJNiz<{>|y%pap){(q8RSa9YMnFR7a
zr03*DX$;#&!n4s1fo}EzH2LZ(<XxK2&xalH-gC|_D+F&a2TEXgXVu)LcLhC@...1598...~cyu
zKobc>6nCWzhH5*Foei(pl=<C%^7Bh+!8dr|mFAQKMHnJ`w{4$&+uHQ`YlBzXov`Ds
z)a=`1#LuEf28%cdoGG}sH#~n`K$Tm!&z?>CHKr#7wQn-)nFxDHC&Qrv2SbNakeLb$
zef-$!=GC^4C?AeY#fh{fuw*A=yP}}w6VtZYNi&%2A{I^oF>{os*iQE8a9Q-{Z}>h<
zB9Hruk!%|`RhQnt4TT{#|MC4^X|o7J06gCSm<E%zug7!5fJ6>uKLo?WwFh)i5AL5A
zdeU2-pDmWgku%|yn=%(~2;{kGYk^Cy?f98LADLJBb7VFK-+0<7{rmPxt@...1622...(%;>-
z$Z}$Xc;D}Xi#M8)Ty|H$>k_}Q(NWf|JXorwD6xkQ9jw7#5K27QQj~r<MxHi~c=+b7
zPevX?)KS_lik;^|4DZ@...1623...}?^VPpZ8)6t@...1624...#ae0t^{_eLb@>(BQG?k&V-lV
z9U$03^M%LGjo}lA=7rcSsCCpe%gSa<Bk`;Kbi)?c;2(C*xle1;-+Cq<ybksIFWMDq
zYhAcLXpWtDC5bcmbxhf;-0G_OBZuM-g*j}sgEjk<67#$8`{HkShE^ubuC%+lsuYHp
zeYg}({n?QeyP6(`btl4$)*Egq^AMitD1vZuc!=KINK-p>HRR^PPdu2_DpZFz2VyVW
z%;41N@...1625...&b7Q#Wu#s&UjGqdCHg&*~ziF$3YtwF7gQg-HA;CQ+c;PyoUGVlh
zg4U#~71tnkf_Nx0NJ1j|rliQBVRM8w;T-+6M5ep5LzzkAzANb0B4Q+DB0A)8N__(I
z9)@3kDkp4Ho{_1IqF#iqP#3Z&X=x_%ppTA(7p{*4!{SdZUx4WZIed@...1626...@pasL%YYS
z^g3x=hcw#mY<hu}sIL@...1627...+hm`2qrGTJ3^B!(Z6Yv)a}vyxSLD!%ij|YP
z(h}=eH+n5)g*>$bM{Q9I2~+S%Z4enxu~v^T+}{_%E&G_2Dw%g}jI|983|e3IL+l&f
zS@...1478...~cU~Lu08<Ss`-qRBssa6g%+IYDbMsi4l*vSpUVZ)GpB%|qY*ck;-kwaO4R7vcI
zHT?@Bgb>Jbxaf{_Yw7)vIE`DdkxR_<6JDId(8{3@...1628...?!oU7e<ig&m-Zbtx_)O$p9!
zBvucW(52|ZpTC+nlQWO#D3d;2AIIn!uS|>f2s8Uj>bVB=o}q_x`uyY{@vi9WQV7b#
z5K7yuX?g3Bf|2;W`}uozISi@...1629...#zYW5W9y$|G8*=x|A+OD$sAJ8}o>?*gP>izdOl0
zT`Cs4!La1c>DP7kg=yc)p%<PLGQxHW9T}6iX$cHjj-PlCIWY^=a?U_;<CF2OMLd|W
zq><~WPoidiWEbVB?2#6(xi1q$8<Of$5rFHTh+Foj<>$9}HVq9vURxH1n+%3-3Tw8-
z81Cy0FAxnJ=^93|gf1QE>vaIy`3f&d33&N~l)Tt9LPM=`<<Rbj%1=MUO0$S1-kW@...1630...
zBZ<~X2@...1631...&cE|cU85q0>1P|9GQ@...1632...*rf@...1633...#{)cUI0UwEf0BC`LQT?qZkUj
zpMNw<SYR>;PiI3^z@...1634...<gk1Lu=E>7;b$b#*htDx|TsoiY{#_Vbh>!n5ItIak0AU
z!2Z3(@j>4%rOFZ(tUps@(?nXjSeL@...1635...;@)K#B{1BOaxR79@...1636...*tDUxXE
zLC-<(mvPA~pQ62SU6AT>t3WYy%v+zvNqhf2nJYI1AA2Bk<C8fwc~wL#6GaYHDNyUF
zx^m@...1637...%o+Z~2GIu{hccitH=HS=oZaB&Pd7ZHskQ|3IASD7zq;+%-lIt(K@...1638...+Je
zZhl^D8i6H&A*TwmPf99-5eP_2*rn`UOj;N$Jow-}!9;YTLR{3$AR42Or<!U=)Q9iQ
zD66EYzqQ5~;#)|e_Cm(X8@^&U5@?a%lh(J8!I0uo{@}$~ygT!3=gBeV(fBmh)l%Pr
zD&O1gR5{+G_QhiP$h~gYC}q=ddg&OJ+956l;zx-Tati4>i~b{asQ^xj4#dspAu56w
zjo2jgq|~z*8qX8Pf|4FBvqRCHWw<+Dz>{Pc(mwPh<nZ>t#jzP?&y4X5CnI(eQ4p!u
zdB|)?X<kM|gzhSfp>mzfOD#zZg_kZZ@...1639...+KP<~jJnbVUIoIR_*uKu
zEf&z`>&tBmvI&!Z=#QE1i4gghM$CR#WS3e%YILR&bO8#PGK}QNR&8?WUF6VkJ#rDX
zx(E`ea(tVp1%_G$r%mlrPNTFh2#&V5as5ODh*zEx7_NOisY@@}5D?*%->H+sQd_n`
z8K9&%{z5|t6c593%d#9kp~PGZv5#*Uj7)y}nH+JH>z~M7ez%ccd4#pwn~d5ty3|?7
z244AOVKl(<ynAENA0P5cKcUJY^gnvZV94Gpbx9xCH^%}IPnE_O_3@`BCz-679eO9V
zgCjc{866pMv$lmgYw1<x(C4&iMB1?eOm%D>?!>r(YTV0oB>tgMD)bJeaGR7M1NV)H
zEl7!sVQ?TB^|Sur*2D9dAdZodY5J-c@...1640...&<rXXj$|m*wFO)-$vw6O?7*hz>{|Cj
z>EcVCT{<`&{`6&aYs?tFW&?a%4#g1{3Izw7VHKE#z@...560...{786&=hB?wTP)!lAXR78am
zM;}ic45j*_z6F-2G7J?bcLtcI3HcjXj7H^RkoHIhN3OPJzt%F0vb>5p7MVvJ`l}U)
zO=BqyVnz<rXBXz@...1641...%XZG;O6w9n-Sp_ET0<nYj7_|ZQ(4HNOn975<wnTm1nqb0&r
zh)nob%zpUSf)EIeT(K$8IGy;1hI1C)FFp}ljAo2M_}<?;>4FAbm&=F5ylKP^#=!OE
zt+`*kmjBr+vmnFsvsd!J`F9>b5<m41sfZljumz9DV9qOx0^$=h;bjqq#d2tmXX35T
z_Yyd2cbKFK&TMGY$YG6%wV5YXMeGzo<-v|Pf|G8`sVmjFA|+!M45b_lkvC+X>W0h`
zb4^1ixu6qszT|$0Me;of274=>Democ%8<rbi*&+Nc*yw9VNHK1#-7LZ;1<utMh?-L
zvieDjef&>9Y|RdfFu@...1642...!4Ne7Mtf%YcBvpnT_bNUDi>URU*?SUNezbRd^^ozyL5DP
zL^y33S;d_@;UX!R2)_j=kr4Ts*blijq_vPbE~!bIf(+Ms<SXW&!pnxqEf*wR`X!}A
z@...1643...|v?mXJeQW$#x6Btv@...1594...{TX!K(m!^>k3ZlHKX{{!s6j(@(WO=-j8GM0c&&|^
zOLZ_r={XD|hyAhI5`JXi;3U?j9mx`4Nb2hjOowcwGRR^dAAZY<C*570@)ZrYQ%wlm
zN(ek|td9?vk{A}oOF8!g5C>y5`m08c3XNUrMAulqHjZh9&?-BEG&(ccB#j!kQd%0r
zbT0hlW~WY-2h8=8o3n=oV`<ceCBsR;ryh!p65);1%EX~IgQ1>V@...1644...)?WZ-;FYw@...1645...
zHCmmo=u&}H(x>Z7j=^s#!jP3>8Wapa{ZK|D2?J9uy35yuZ-Hj1*}Dg33%`9uDqY}r
zTX`^?)~%9Hf}vA`#&#))wSgG>j%zkmrJ-i7R0@...1646...$#iOWQ3~l=uiDVQ!!Xjxr7?u|
z)uVB&1<ol8Veqg2m9HNP!C8I;(Fi}YBXN={WQu_7c)k!)MKH8&n%(Jhk7hZJ?;Z~c
zV?Wz4f9-?uDuCw4e>dpkTS%J*inRf!OTYSO{+F-iCDqKYY>8eB5Dc}VWL|2C;{%vM
z$RQ2#By1YdmS(wIZgCCF%{KZE_PKmAX{xF(x=tkVQUQT95vL(ci94bd@%`k!lbk(K
zt{9pYkpG=2|B5l46Qq^u(#4V(LLS}1Z~$8VnLIPb&SY01rh?0S&HY&p3B9k*_z<40
zc_B82Wd5Q{<tr(!9h>dj??6uCj^r!N9=2k?lwBHalCpeATcV>};-$2s<>ZlhZi46!
z4Buteof&+>roo0Vtg_w%8UK2!RCgzemH>9@...1647...#KnV&T36yh*qRE!G~18YOGBKSb)MC
z*U?JG?S~QCrO%#(9An~hkFdEh%b2@...1648...`(HsBpy3N^Qb5YNp4828wjIA3r
z5;-(nrjU^kr->T3l#aj+Ou7~VU~h}Uo;Kzkj|zg<BOg_oJw6fQ`btIiLj|8*OJX6y
zZ)|*_Po$jO2+IW%ITdyoTIr=aw^T6WPtQzarf|VtD4m{6?NErEZxPiJ0MWYsb#v(*
zyHu9|nRCe@...1649...+vq@...1650...~ZihRj>09%W!>gg^wybq{5!Ui?E2*?cU$U&~dO1~F?m!_vBs
z9E?wqq+eY=ZU9aiO@...1651...`zN>mpl)0@...1652...;9F>elIa@...1653...!dDMf2G0G=U^8W<HZvk`E
zVPbhNVJa}RXTWwt6Xzg8CT`P~uuRn2^y4(La3JQdI{fY=uNWGf%fgU)h|M>jac4<B
z|Acu`Vp30{c;y;^?n{Y*-~qDB;c%Mg1^aBDC7yZv-)DdO@...1654...&=QuFd%~tBBx<d{g
z46#;uVRj8A?o~2|fOa%sgLUm{*@`uNNlS<uaJaHE27+<@Q7o#VE;^{N`ypmTVhZxg
z{WWJ~TGI#U*xYa+%zc{37&0PfkpvTcM9lmUi`b<~K!#iIi*{;sX=LuuP8o8j%^(T*
z=@zkg>r?1h$M%z1&>y%b*j!VV?XQimsEpj66*iLs2%=SLgal~}Wh8Gf7|KEnU3458
zOX>VN{#e9sQ!#`F0BIrdH+)KrO#^{x%2INZiB*I0SCNkHVrUINbMka}-`=^;KAbU{
z(C$cr8z~PLs6O*>_TD{nrNqx~Y9;3}L4`y3gqVf=xx*5pg@...1655...!586ry`HE
zBPp75-|k(=D)-}x|42f73scK>iqTuDQ;E}P%M1YYNF|m_ttBy(R_7MNrjy~eriBev
zd19MCeI?I%BYRilaLE(gQo~u9<-{tnLEJMltwG>LN6TelOd0+NPw3@...1656...{gEeFF
zGc%MSE#gTOH-(jJ8nKT`R52MPoI1N6XZTGcuGFPvwSLOLaM6Y<g)4^x6%1Dn7Rwz;
z1;gcXZspXgV7PLySnfzF7%rD{E2mxs!<B=@az|3ZaJigYIrS<St{g0uJCX{9%jMk4
hsaL^p<zTVgkyJ2TF6UNGy$Xga2aDy7#QdL1{tGA-a#jEU

literal 0
HcmV?d00001

diff --git a/installer/tap-windows.nsi b/installer/tap-windows.nsi
new file mode 100755
index 0000000..26e060b
--- /dev/null
+++ b/installer/tap-windows.nsi
@@ -0,0 +1,296 @@
+; ****************************************************************************
+; * Copyright (C) 2002-2010 OpenVPN Technologies, Inc.                       *
+; * Copyright (C)      2012 Alon Bar-Lev <alon.barlev@...277...>             *
+; *  This program is free software; you can redistribute it and/or modify    *
+; *  it under the terms of the GNU General Public License version 2          *
+; *  as published by the Free Software Foundation.                           *
+; ****************************************************************************
+
+; TAP-Windows install script for Windows, using NSIS
+
+SetCompressor lzma
+
+!include "MUI.nsh"
+
+!include "StrStr.nsi"
+
+;--------------------------------
+;Configuration
+
+;General
+
+OutFile "${OUTPUT}"
+
+ShowInstDetails show
+ShowUninstDetails show
+
+;Folder selection page
+InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
+
+;Remember install folder
+InstallDirRegKey HKCU "Software\${PRODUCT_NAME}" ""
+
+;--------------------------------
+;Modern UI Configuration
+
+Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
+
+!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of ${PRODUCT_NAME}, an Open Source VPN package by James Yonan.\r\n\r\nNote that the Windows version of ${PRODUCT_NAME} will only run on Win 2000, XP, or higher.\r\n\r\n\r\n"
+
+!define MUI_COMPONENTSPAGE_TEXT_TOP "Select the components to install/upgrade.  Stop any ${PRODUCT_NAME} processes or the ${PRODUCT_NAME} service if it is running.  All DLLs are installed locally."
+
+!define MUI_COMPONENTSPAGE_SMALLDESC
+!define MUI_FINISHPAGE_NOAUTOCLOSE
+!define MUI_ABORTWARNING
+!define MUI_ICON "icon.ico"
+!define MUI_UNICON "icon.ico"
+!define MUI_HEADERIMAGE
+!define MUI_HEADERIMAGE_BITMAP "install-whirl.bmp"
+!define MUI_UNFINISHPAGE_NOAUTOCLOSE
+
+!insertmacro MUI_PAGE_WELCOME
+!insertmacro MUI_PAGE_LICENSE "${IMAGE}\license.txt"
+!insertmacro MUI_PAGE_COMPONENTS
+!insertmacro MUI_PAGE_DIRECTORY
+!insertmacro MUI_PAGE_INSTFILES
+!insertmacro MUI_PAGE_FINISH
+
+!insertmacro MUI_UNPAGE_CONFIRM
+!insertmacro MUI_UNPAGE_INSTFILES  
+!insertmacro MUI_UNPAGE_FINISH
+
+;--------------------------------
+;Languages
+
+!insertmacro MUI_LANGUAGE "English"
+
+;--------------------------------
+;Language Strings
+
+LangString DESC_SecTAP ${LANG_ENGLISH} "Install/Upgrade the TAP virtual device driver.  Will not interfere with CIPE."
+LangString DESC_SecTAPSDK ${LANG_ENGLISH} "Install the TAP SDK."
+
+;--------------------------------
+;Reserve Files
+
+;Things that need to be extracted on first (keep these lines before any File command!)
+;Only useful for BZIP2 compression
+
+ReserveFile "install-whirl.bmp"
+
+;--------------------------------
+;Macros
+
+!macro IsAdmin
+	UserInfo::GetName
+	${Unless} ${Errors}
+		Pop $R0
+		UserInfo::GetAccountType
+		Pop $R1
+		${If} $R1 != "Admin"
+			Messagebox MB_OK "Administrator privileges required to install/uninstall ${PRODUCT_NAME} [$R0/$R1]"
+			Abort
+		${EndIf}
+	${EndUnlesS}
+!macroend
+
+;------------------------------------------
+;Set reboot flag based on tapinstall return
+
+Function CheckReboot
+	${If} $R0 == ""
+		IntOp $R0 0 & 0
+		SetRebootFlag true
+		DetailPrint "REBOOT flag set"
+	${EndIf}
+FunctionEnd
+
+;--------------------------------
+;Installer Sections
+
+Function .onInit
+	ClearErrors
+	!insertmacro IsAdmin
+
+	# Delete previous start menu
+	RMDir /r $SMPROGRAMS\${PRODUCT_NAME}
+
+FunctionEnd
+
+Section "TAP Virtual Ethernet Adapter" SecTAP
+
+	SetOverwrite on
+
+	FileOpen $R0 "$INSTDIR\bin\addtap.bat" w
+	FileWrite $R0 "rem Add a new TAP virtual ethernet adapter$\r$\n"
+	FileWrite $R0 '"$INSTDIR\bin\${DEVCON_BASENAME}" install "$INSTDIR\driver\OemWin2k.inf" ${PRODUCT_TAP_WIN_COMPONENT_ID}$\r$\n'
+	FileWrite $R0 "pause$\r$\n"
+	FileClose $R0
+
+	FileOpen $R0 "$INSTDIR\bin\deltapall.bat" w
+	FileWrite $R0 "echo WARNING: this script will delete ALL TAP virtual adapters (use the device manager to delete adapters one at a time)$\r$\n"
+	FileWrite $R0 "pause$\r$\n"
+	FileWrite $R0 '"$INSTDIR\bin\${DEVCON_BASENAME}" remove ${PRODUCT_TAP_WIN_COMPONENT_ID}$\r$\n'
+	FileWrite $R0 "pause$\r$\n"
+	FileClose $R0
+
+	; Check if we are running on a 64 bit system.
+	System::Call "kernel32::GetCurrentProcess() i .s"
+	System::Call "kernel32::IsWow64Process(i s, *i .R0)"
+	${If} $R0 != 0
+		; tap-64bit:
+		DetailPrint "We are running on a 64-bit system."
+
+		SetOutPath "$INSTDIR\bin"
+		File "${DEVCON64}"
+
+		SetOutPath "$INSTDIR\driver"
+		File "${IMAGE}\amd64\OemWin2k.inf"
+		File "${IMAGE}\amd64\${PRODUCT_TAP_WIN_COMPONENT_ID}.cat"
+		File "${IMAGE}\amd64\${PRODUCT_TAP_WIN_COMPONENT_ID}.sys"
+	${Else}
+		; tap-32bit
+		DetailPrint "We are running on a 32-bit system."
+
+		SetOutPath "$INSTDIR\bin"
+		File "${DEVCON32}"
+
+		SetOutPath "$INSTDIR\driver"
+		File "${IMAGE}\i386\OemWin2k.inf"
+		File "${IMAGE}\i386\${PRODUCT_TAP_WIN_COMPONENT_ID}.cat"
+		File "${IMAGE}\i386\${PRODUCT_TAP_WIN_COMPONENT_ID}.sys"
+	${EndIf}
+SectionEnd
+
+Section /o "TAP SDK" SecTAPSDK
+	SetOverwrite on
+	SetOutPath "$INSTDIR\include"
+	File "${IMAGE}\include\tap-windows.h"
+SectionEnd
+
+;--------------------
+;Post-install section
+
+Section -post
+
+	SetOverwrite on
+
+	; Store README, license, icon
+	SetOverwrite on
+	SetOutPath $INSTDIR
+	File "${IMAGE}\license.txt"
+	File "icon.ico"
+
+	${If} ${SectionIsSelected} ${SecTAP}
+		;
+		; install/upgrade TAP driver if selected, using devcon
+		;
+		; TAP install/update was selected.
+		; Should we install or update?
+		; If tapinstall error occurred, $R5 will
+		; be nonzero.
+		IntOp $R5 0 & 0
+		nsExec::ExecToStack '"$INSTDIR\bin\${DEVCON_BASENAME}" hwids ${PRODUCT_TAP_WIN_COMPONENT_ID}'
+		Pop $R0 # return value/error/timeout
+		IntOp $R5 $R5 | $R0
+		DetailPrint "${DEVCON_BASENAME} hwids returned: $R0"
+
+		; If tapinstall output string contains "${PRODUCT_TAP_WIN_COMPONENT_ID}" we assume
+		; that TAP device has been previously installed,
+		; therefore we will update, not install.
+		Push "${PRODUCT_TAP_WIN_COMPONENT_ID}"
+		Call StrStr
+		Pop $R0
+
+		${If} $R5 == 0
+			${If} $R0 == -1
+				DetailPrint "TAP INSTALL (${PRODUCT_TAP_WIN_COMPONENT_ID})"
+				nsExec::ExecToLog '"$INSTDIR\bin\${DEVCON_BASENAME}" install "$INSTDIR\driver\OemWin2k.inf" ${PRODUCT_TAP_WIN_COMPONENT_ID}'
+				Pop $R0 # return value/error/timeout
+				Call CheckReboot
+				IntOp $R5 $R5 | $R0
+				DetailPrint "${DEVCON_BASENAME} install returned: $R0"
+			${Else}
+				DetailPrint "TAP UPDATE"
+				nsExec::ExecToLog '"$INSTDIR\bin\${DEVCON_BASENAME}" update "$INSTDIR\driver\OemWin2k.inf" ${PRODUCT_TAP_WIN_COMPONENT_ID}'
+				Pop $R0 # return value/error/timeout
+				Call CheckReboot
+				IntOp $R5 $R5 | $R0
+				DetailPrint "${DEVCON_BASENAME} update returned: $R0"
+			${EndIf}
+		${EndIf}
+
+		DetailPrint "${DEVCON_BASENAME} cumulative status: $R5"
+		${If} $R5 != 0
+			MessageBox MB_OK "An error occurred installing the TAP device driver."
+		${EndIf}
+
+		; Store install folder in registry
+		WriteRegStr HKLM SOFTWARE\${PRODUCT_NAME} "" $INSTDIR
+
+		; Create shortcuts
+		CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Utilities\Add a new TAP virtual ethernet adapter.lnk" "$INSTDIR\bin\addtap.bat" ""
+		CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Utilities\Delete ALL TAP virtual ethernet adapters.lnk" "$INSTDIR\bin\deltapall.bat" ""
+	${EndIf}
+
+	; Create uninstaller
+	WriteUninstaller "$INSTDIR\Uninstall.exe"
+
+	; Show up in Add/Remove programs
+	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME} ${PRODUCT_VERSION}"
+	WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
+	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayIcon" "$INSTDIR\icon.ico"
+	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayVersion" "${PRODUCT_VERSION}"
+
+	; Advise a reboot
+	;Messagebox MB_OK "IMPORTANT: Rebooting the system is advised in order to finalize TAP driver installation/upgrade (this is an informational message only, pressing OK will not reboot)."
+
+SectionEnd
+
+;--------------------------------
+;Descriptions
+
+!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
+!insertmacro MUI_DESCRIPTION_TEXT ${SecTAP} $(DESC_SecTAP)
+!insertmacro MUI_DESCRIPTION_TEXT ${SecTAPSDK} $(DESC_SecTAPSDK)
+!insertmacro MUI_FUNCTION_DESCRIPTION_END
+
+;--------------------------------
+;Uninstaller Section
+
+Function un.onInit
+	ClearErrors
+	!insertmacro IsAdmin
+FunctionEnd
+
+Section "Uninstall"
+	DetailPrint "TAP REMOVE"
+	nsExec::ExecToLog '"$INSTDIR\bin\${DEVCON_BASENAME}" remove ${PRODUCT_TAP_WIN_COMPONENT_ID}'
+	Pop $R0 # return value/error/timeout
+	DetailPrint "${DEVCON_BASENAME} remove returned: $R0"
+
+	Delete "$INSTDIR\bin\${DEVCON_BASENAME}"
+	Delete "$INSTDIR\bin\addtap.bat"
+	Delete "$INSTDIR\bin\deltapall.bat"
+
+	Delete "$INSTDIR\driver\OemWin2k.inf"
+	Delete "$INSTDIR\driver\${PRODUCT_TAP_WIN_COMPONENT_ID}.cat"
+	Delete "$INSTDIR\driver\${PRODUCT_TAP_WIN_COMPONENT_ID}.sys"
+
+	Delete "$INSTDIR\include\tap-windows.h"
+
+	Delete "$INSTDIR\icon.ico"
+	Delete "$INSTDIR\license.txt"
+	Delete "$INSTDIR\Uninstall.exe"
+
+	RMDir "$INSTDIR\bin"
+	RMDir "$INSTDIR\driver"
+	RMDir "$INSTDIR\include"
+	RMDir "$INSTDIR"
+
+	DeleteRegKey HKCR "${PRODUCT_NAME}File"
+	DeleteRegKey HKLM "SOFTWARE\${PRODUCT_NAME}"
+	DeleteRegKey HKCU "Software\${PRODUCT_NAME}"
+	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
+
+SectionEnd
diff --git a/src/OemWin2k.inf.in b/src/OemWin2k.inf.in
new file mode 100755
index 0000000..ef73600
--- /dev/null
+++ b/src/OemWin2k.inf.in
@@ -0,0 +1,187 @@
+; ****************************************************************************
+; * Copyright (C) 2002-2010 OpenVPN Technologies, Inc.                            *
+; *  This program is free software; you can redistribute it and/or modify    *
+; *  it under the terms of the GNU General Public License version 2          *
+; *  as published by the Free Software Foundation.                           *
+; ****************************************************************************
+
+; SYNTAX CHECKER
+; cd \WINDDK\3790\tools\chkinf
+; chkinf c:\src\openvpn\tap-win32\i386\oemwin2k.inf
+; OUTPUT -> file:///c:/WINDDK/3790/tools/chkinf/htm/c%23+src+openvpn+tap-win32+i386+__OemWin2k.htm
+
+; INSTALL/REMOVE DRIVER
+;   tapinstall install OemWin2k.inf TAP0901
+;   tapinstall update OemWin2k.inf TAP0901
+;   tapinstall remove TAP0901
+
+;*********************************************************
+; Note to Developers:
+;
+; If you are bundling the TAP-Windows driver with your app,
+; you should try to rename it in such a way that it will
+; not collide with other instances of TAP-Windows defined
+; by other apps.  Multiple versions of the TAP-Windows
+; driver, each installed by different apps, can coexist
+; on the same machine if you follow these guidelines.
+; NOTE: these instructions assume you are editing the
+; generated OemWin2k.inf file, not the source
+; OemWin2k.inf.in file which is preprocessed by winconfig
+; and uses macro definitions from settings.in.
+;
+; (1) Rename all tapXXXX instances in this file to
+;     something different (use at least 5 characters
+;     for this name!)
+; (2) Change the "!define TAP" definition in openvpn.nsi
+;     to match what you changed tapXXXX to.
+; (3) Change TARGETNAME in SOURCES to match what you
+;     changed tapXXXX to.
+; (4) Change TAP_COMPONENT_ID in common.h to match what
+;     you changed tapXXXX to.
+; (5) Change SZDEPENDENCIES in service.h to match what
+;     you changed tapXXXX to.
+; (6) Change DeviceDescription and Provider strings.
+; (7) Change PRODUCT_TAP_WIN_DEVICE_DESCRIPTION in constants.h to what you
+;     set DeviceDescription to.
+;
+;*********************************************************
+
+[Version]
+   Signature = "$Windows NT$"
+   CatalogFile = @PRODUCT_TAP_WIN_COMPONENT_ID@...1677...
+   ClassGUID = {4d36e972-e325-11ce-bfc1-08002be10318}
+   Provider = %Provider%
+   Class = Net
+
+; This version number should match the version
+; number given in SOURCES.
+   DriverVer=@PRODUCT_TAP_WIN_RELDATE@,@PRODUCT_TAP_WIN_MAJOR@...1678...@PRODUCT_TAP_WIN_MINOR@
+
+[Strings]
+   DeviceDescription = "@PRODUCT_TAP_WIN_DEVICE_DESCRIPTION@"
+   Provider = "@PRODUCT_TAP_WIN_PROVIDER@"
+
+;----------------------------------------------------------------
+;                      Manufacturer + Product Section (Done)
+;----------------------------------------------------------------
+[Manufacturer]
+   %Provider% = @PRODUCT_TAP_WIN_COMPONENT_ID@@INF_PROVIDER_SUFFIX@
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@@INF_SECTION_SUFFIX@]
+   %DeviceDescription% = @PRODUCT_TAP_WIN_COMPONENT_ID@...1679..., @PRODUCT_TAP_WIN_COMPONENT_ID@
+
+;---------------------------------------------------------------
+;                             Driver Section (Done)
+;---------------------------------------------------------------
+
+;----------------- Characteristics ------------
+;    NCF_PHYSICAL = 0x04
+;    NCF_VIRTUAL = 0x01
+;    NCF_SOFTWARE_ENUMERATED = 0x02
+;    NCF_HIDDEN = 0x08
+;    NCF_NO_SERVICE = 0x10
+;    NCF_HAS_UI = 0x80
+;----------------- Characteristics ------------
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@...1679...]
+   CopyFiles       = @PRODUCT_TAP_WIN_COMPONENT_ID@...1680..., @PRODUCT_TAP_WIN_COMPONENT_ID@...1681...
+   AddReg          = @PRODUCT_TAP_WIN_COMPONENT_ID@...1682...
+   AddReg          = @PRODUCT_TAP_WIN_COMPONENT_ID@...1683...
+   Characteristics = @PRODUCT_TAP_WIN_CHARACTERISTICS@
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@...1684...]
+   AddService = @PRODUCT_TAP_WIN_COMPONENT_ID@,        2, @PRODUCT_TAP_WIN_COMPONENT_ID@...1685...
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@...1682...]
+   HKR, Ndi,            Service,      0, "@PRODUCT_TAP_WIN_COMPONENT_ID@"
+   HKR, Ndi\Interfaces, UpperRange,   0, "ndis5"
+   HKR, Ndi\Interfaces, LowerRange,   0, "ethernet"
+   HKR, ,               Manufacturer, 0, "%Provider%"
+   HKR, ,               ProductName,  0, "%DeviceDescription%"
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@...1683...]
+   HKR, Ndi\params\MTU,                  ParamDesc, 0, "MTU"
+   HKR, Ndi\params\MTU,                  Type,      0, "int"
+   HKR, Ndi\params\MTU,                  Default,   0, "1500"
+   HKR, Ndi\params\MTU,                  Optional,  0, "0"
+   HKR, Ndi\params\MTU,                  Min,       0, "100"
+   HKR, Ndi\params\MTU,                  Max,       0, "1500"
+   HKR, Ndi\params\MTU,                  Step,      0, "1"
+   HKR, Ndi\params\MediaStatus,          ParamDesc, 0, "Media Status"
+   HKR, Ndi\params\MediaStatus,          Type,      0, "enum"
+   HKR, Ndi\params\MediaStatus,          Default,   0, "0"
+   HKR, Ndi\params\MediaStatus,          Optional,  0, "0"
+   HKR, Ndi\params\MediaStatus\enum,     "0",       0, "Application Controlled"
+   HKR, Ndi\params\MediaStatus\enum,     "1",       0, "Always Connected"
+   HKR, Ndi\params\MAC,                  ParamDesc, 0, "MAC Address"
+   HKR, Ndi\params\MAC,                  Type,      0, "edit"
+   HKR, Ndi\params\MAC,                  Optional,  0, "1"
+   HKR, Ndi\params\AllowNonAdmin,        ParamDesc, 0, "Non-Admin Access"
+   HKR, Ndi\params\AllowNonAdmin,        Type,      0, "enum"
+   HKR, Ndi\params\AllowNonAdmin,        Default,   0, "1"
+   HKR, Ndi\params\AllowNonAdmin,        Optional,  0, "0"
+   HKR, Ndi\params\AllowNonAdmin\enum,   "0",       0, "Not Allowed"
+   HKR, Ndi\params\AllowNonAdmin\enum,   "1",       0, "Allowed"
+
+;----------------------------------------------------------------
+;                             Service Section
+;----------------------------------------------------------------
+
+;---------- Service Type -------------
+;    SERVICE_KERNEL_DRIVER     = 0x01
+;    SERVICE_WIN32_OWN_PROCESS = 0x10
+;---------- Service Type -------------
+
+;---------- Start Mode ---------------
+;    SERVICE_BOOT_START   = 0x0
+;    SERVICE_SYSTEM_START = 0x1
+;    SERVICE_AUTO_START   = 0x2
+;    SERVICE_DEMAND_START = 0x3
+;    SERVICE_DISABLED     = 0x4
+;---------- Start Mode ---------------
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@...1685...]
+   DisplayName = %DeviceDescription%
+   ServiceType = 1
+   StartType = 3
+   ErrorControl = 1
+   LoadOrderGroup = NDIS
+   ServiceBinary = %12%\@PRODUCT_TAP_WIN_COMPONENT_ID@...1686...
+
+;-----------------------------------------------------------------
+;                                File Installation
+;-----------------------------------------------------------------
+
+;----------------- Copy Flags ------------
+;    COPYFLG_NOSKIP = 0x02
+;    COPYFLG_NOVERSIONCHECK = 0x04
+;----------------- Copy Flags ------------
+
+; SourceDisksNames
+; diskid = description[, [tagfile] [, <unused>, subdir]]
+; 1 = "Intel Driver Disk 1",e100bex.sys,,
+
+[SourceDisksNames]
+   1 = %DeviceDescription%, @PRODUCT_TAP_WIN_COMPONENT_ID@...1686...
+
+; SourceDisksFiles
+; filename_on_source = diskID[, [subdir][, size]]
+; e100bex.sys = 1,, ; on distribution disk 1
+
+[SourceDisksFiles]
+@PRODUCT_TAP_WIN_COMPONENT_ID@...1686... = 1
+
+[DestinationDirs]
+   @PRODUCT_TAP_WIN_COMPONENT_ID@...1681...  = 11
+   @PRODUCT_TAP_WIN_COMPONENT_ID@...1680... = 12
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@...1681...]
+;   TapPanel.cpl,,,6   ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
+;   cipsrvr.exe,,,6     ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
+
+[@PRODUCT_TAP_WIN_COMPONENT_ID@...1680...]
+   @PRODUCT_TAP_WIN_COMPONENT_ID@...1686...,,,6     ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
+
+;---------------------------------------------------------------
+;                                      End
+;---------------------------------------------------------------
diff --git a/src/SOURCES.in b/src/SOURCES.in
index 2f77365..3e1ee81 100755
--- a/src/SOURCES.in
+++ b/src/SOURCES.in
@@ -4,7 +4,7 @@
 MAJORCOMP=ntos
 MINORCOMP=ndis
 
-TARGETNAME=@@PRODUCT_TAP_ID@@
+TARGETNAME=@PRODUCT_TAP_WIN_COMPONENT_ID@
 TARGETTYPE=DRIVER
 TARGETPATH=.
 TARGETLIBS=$(DDK_LIB_PATH)\ndis.lib $(DDK_LIB_PATH)\ntstrsafe.lib
@@ -13,8 +13,9 @@ INCLUDES=$(DDK_INCLUDE_PATH) ..
 # The TAP version numbers here must be >=
 # PRODUCT_TAP_WIN32_MIN_x values defined in version.m4
 C_DEFINES=
-C_DEFINES=$(C_DEFINES) -DTAP_DRIVER_MAJOR_VERSION=@@PRODUCT_TAP_MAJOR_VER@@
-C_DEFINES=$(C_DEFINES) -DTAP_DRIVER_MINOR_VERSION=@@PRODUCT_TAP_MINOR_VER@@
+C_DEFINES=$(C_DEFINES) @EXTRA_C_DEFINES@
+C_DEFINES=$(C_DEFINES) -DTAP_DRIVER_MAJOR_VERSION=@PRODUCT_TAP_WIN_MAJOR@
+C_DEFINES=$(C_DEFINES) -DTAP_DRIVER_MINOR_VERSION=@PRODUCT_TAP_WIN_MINOR@
 
 # Produce the same symbolic information for both free & checked builds.
 # This will allow us to perform full source-level debugging on both
diff --git a/src/config.h.in b/src/config.h.in
new file mode 100644
index 0000000..322afa8
--- /dev/null
+++ b/src/config.h.in
@@ -0,0 +1,9 @@
+#define PRODUCT_NAME			"@PRODUCT_NAME@"
+#define PRODUCT_VERSION			"@PRODUCT_VERSION@"
+#define PRODUCT_VERSION_RESOURCE	@PRODUCT_VERSION_RESOURCE@
+#define PRODUCT_TAP_WIN_COMPONENT_ID	"@PRODUCT_TAP_WIN_COMPONENT_ID@"
+#define PRODUCT_TAP_WIN_MAJOR		@PRODUCT_TAP_WIN_MAJOR@
+#define PRODUCT_TAP_WIN_MINOR		@PRODUCT_TAP_WIN_MINOR@
+#define PRODUCT_TAP_WIN_PROVIDER		"@PRODUCT_TAP_WIN_PROVIDER@"
+#define PRODUCT_TAP_WIN_DEVICE_DESCRIPTION	"@PRODUCT_TAP_WIN_DEVICE_DESCRIPTION@"
+#define PRODUCT_TAP_WIN_RELDATE		"@PRODUCT_TAP_WIN_RELDATE@"
diff --git a/src/error.c b/src/error.c
index 271dafc..69e9ec6 100755
--- a/src/error.c
+++ b/src/error.c
@@ -95,7 +95,9 @@ MyDebugPrint (const unsigned char* format, ...)
 					       format,
 					       args);
 	      va_end (args);
-
+va_start (args, format);
+vDbgPrintEx(DPFLTR_IHVDRIVER_ID , 1, format, args);
+va_end (args);
 	      if (status == STATUS_SUCCESS)
 		g_Debug.out = (unsigned int) (end - g_Debug.text);
 	      else
diff --git a/src/i386/OemWin2k.inf.in b/src/i386/OemWin2k.inf.in
deleted file mode 100755
index 34888f2..0000000
--- a/src/i386/OemWin2k.inf.in
+++ /dev/null
@@ -1,195 +0,0 @@
-; ****************************************************************************
-; * Copyright (C) 2002-2010 OpenVPN Technologies, Inc.                            *
-; *  This program is free software; you can redistribute it and/or modify    *
-; *  it under the terms of the GNU General Public License version 2          *
-; *  as published by the Free Software Foundation.                           *
-; ****************************************************************************
-
-; SYNTAX CHECKER
-; cd \WINDDK\3790\tools\chkinf
-; chkinf c:\src\openvpn\tap-win32\i386\oemwin2k.inf
-; OUTPUT -> file:///c:/WINDDK/3790/tools/chkinf/htm/c%23+src+openvpn+tap-win32+i386+__OemWin2k.htm
-
-; INSTALL/REMOVE DRIVER
-;   tapinstall install OemWin2k.inf TAP0901
-;   tapinstall update OemWin2k.inf TAP0901
-;   tapinstall remove TAP0901
-
-;*********************************************************
-; Note to Developers:
-;
-; If you are bundling the TAP-Windows driver with your app,
-; you should try to rename it in such a way that it will
-; not collide with other instances of TAP-Windows defined
-; by other apps.  Multiple versions of the TAP-Windows
-; driver, each installed by different apps, can coexist
-; on the same machine if you follow these guidelines.
-; NOTE: these instructions assume you are editing the
-; generated OemWin2k.inf file, not the source
-; OemWin2k.inf.in file which is preprocessed by winconfig
-; and uses macro definitions from settings.in.
-;
-; (1) Rename all tapXXXX instances in this file to
-;     something different (use at least 5 characters
-;     for this name!)
-; (2) Change the "!define TAP" definition in openvpn.nsi
-;     to match what you changed tapXXXX to.
-; (3) Change TARGETNAME in SOURCES to match what you
-;     changed tapXXXX to.
-; (4) Change TAP_COMPONENT_ID in common.h to match what
-;     you changed tapXXXX to.
-; (5) Change SZDEPENDENCIES in service.h to match what
-;     you changed tapXXXX to.
-; (6) Change DeviceDescription and Provider strings.
-; (7) Change PRODUCT_STRING in constants.h to what you
-;     set DeviceDescription to.
-;
-;*********************************************************
-
-[Version]
-   Signature = "$Windows NT$"
-   CatalogFile = @@PRODUCT_TAP_ID@@.cat
-   ClassGUID = {4d36e972-e325-11ce-bfc1-08002be10318}
-   Provider = %Provider%
-   Class = Net
-
-; This version number should match the version
-; number given in SOURCES.
-   DriverVer=@@PRODUCT_TAP_RELDATE@@,@@PRODUCT_TAP_MAJOR_VER@@.00.00.@@PRODUCT_TAP_MINOR_VER@@
-
-[Strings]
-   DeviceDescription = "@@PRODUCT_TAP_DEVICE_DESCRIPTION@@"
-   Provider = "@@PRODUCT_TAP_PROVIDER@@"
-
-;----------------------------------------------------------------
-;                      Manufacturer + Product Section (Done)
-;----------------------------------------------------------------
-[Manufacturer]
-!ifdef AMD64
-   %Provider% = @@PRODUCT_TAP_ID@@, NTamd64
-!else
-   %Provider% = @@PRODUCT_TAP_ID@@
-!endif
-
-!ifdef AMD64
-[@@PRODUCT_TAP_ID@@.NTamd64]
-!else
-[@@PRODUCT_TAP_ID@@]
-!endif
-   %DeviceDescription% = @@PRODUCT_TAP_ID@@.ndi, @@PRODUCT_TAP_ID@@
-
-;---------------------------------------------------------------
-;                             Driver Section (Done)
-;---------------------------------------------------------------
-
-;----------------- Characteristics ------------
-;    NCF_PHYSICAL = 0x04
-;    NCF_VIRTUAL = 0x01
-;    NCF_SOFTWARE_ENUMERATED = 0x02
-;    NCF_HIDDEN = 0x08
-;    NCF_NO_SERVICE = 0x10
-;    NCF_HAS_UI = 0x80
-;----------------- Characteristics ------------
-
-[@@PRODUCT_TAP_ID@@.ndi]
-   CopyFiles       = @@PRODUCT_TAP_ID@@.driver, @@PRODUCT_TAP_ID@@.files
-   AddReg          = @@PRODUCT_TAP_ID@@.reg
-   AddReg          = @@PRODUCT_TAP_ID@@.params.reg
-   Characteristics = @@PRODUCT_TAP_CHARACTERISTICS@@
-
-[@@PRODUCT_TAP_ID@@.ndi.Services]
-   AddService = @@PRODUCT_TAP_ID@@,        2, @@PRODUCT_TAP_ID@@.service
-
-[@@PRODUCT_TAP_ID@@.reg]
-   HKR, Ndi,            Service,      0, "@@PRODUCT_TAP_ID@@"
-   HKR, Ndi\Interfaces, UpperRange,   0, "ndis5"
-   HKR, Ndi\Interfaces, LowerRange,   0, "ethernet"
-   HKR, ,               Manufacturer, 0, "%Provider%"
-   HKR, ,               ProductName,  0, "%DeviceDescription%"
-
-[@@PRODUCT_TAP_ID@@.params.reg]
-   HKR, Ndi\params\MTU,                  ParamDesc, 0, "MTU"
-   HKR, Ndi\params\MTU,                  Type,      0, "int"
-   HKR, Ndi\params\MTU,                  Default,   0, "1500"
-   HKR, Ndi\params\MTU,                  Optional,  0, "0"
-   HKR, Ndi\params\MTU,                  Min,       0, "100"
-   HKR, Ndi\params\MTU,                  Max,       0, "1500"
-   HKR, Ndi\params\MTU,                  Step,      0, "1"
-   HKR, Ndi\params\MediaStatus,          ParamDesc, 0, "Media Status"
-   HKR, Ndi\params\MediaStatus,          Type,      0, "enum"
-   HKR, Ndi\params\MediaStatus,          Default,   0, "0"
-   HKR, Ndi\params\MediaStatus,          Optional,  0, "0"
-   HKR, Ndi\params\MediaStatus\enum,     "0",       0, "Application Controlled"
-   HKR, Ndi\params\MediaStatus\enum,     "1",       0, "Always Connected"
-   HKR, Ndi\params\MAC,                  ParamDesc, 0, "MAC Address"
-   HKR, Ndi\params\MAC,                  Type,      0, "edit"
-   HKR, Ndi\params\MAC,                  Optional,  0, "1"
-   HKR, Ndi\params\AllowNonAdmin,        ParamDesc, 0, "Non-Admin Access"
-   HKR, Ndi\params\AllowNonAdmin,        Type,      0, "enum"
-   HKR, Ndi\params\AllowNonAdmin,        Default,   0, "1"
-   HKR, Ndi\params\AllowNonAdmin,        Optional,  0, "0"
-   HKR, Ndi\params\AllowNonAdmin\enum,   "0",       0, "Not Allowed"
-   HKR, Ndi\params\AllowNonAdmin\enum,   "1",       0, "Allowed"
-
-;----------------------------------------------------------------
-;                             Service Section
-;----------------------------------------------------------------
-
-;---------- Service Type -------------
-;    SERVICE_KERNEL_DRIVER     = 0x01
-;    SERVICE_WIN32_OWN_PROCESS = 0x10
-;---------- Service Type -------------
-
-;---------- Start Mode ---------------
-;    SERVICE_BOOT_START   = 0x0
-;    SERVICE_SYSTEM_START = 0x1
-;    SERVICE_AUTO_START   = 0x2
-;    SERVICE_DEMAND_START = 0x3
-;    SERVICE_DISABLED     = 0x4
-;---------- Start Mode ---------------
-
-[@@PRODUCT_TAP_ID@@.service]
-   DisplayName = %DeviceDescription%
-   ServiceType = 1
-   StartType = 3
-   ErrorControl = 1
-   LoadOrderGroup = NDIS
-   ServiceBinary = %12%\@@PRODUCT_TAP_ID@@.sys
-
-;-----------------------------------------------------------------
-;                                File Installation
-;-----------------------------------------------------------------
-
-;----------------- Copy Flags ------------
-;    COPYFLG_NOSKIP = 0x02
-;    COPYFLG_NOVERSIONCHECK = 0x04
-;----------------- Copy Flags ------------
-
-; SourceDisksNames
-; diskid = description[, [tagfile] [, <unused>, subdir]]
-; 1 = "Intel Driver Disk 1",e100bex.sys,,
-
-[SourceDisksNames]
-   1 = %DeviceDescription%, @@PRODUCT_TAP_ID@@.sys
-
-; SourceDisksFiles
-; filename_on_source = diskID[, [subdir][, size]]
-; e100bex.sys = 1,, ; on distribution disk 1
-
-[SourceDisksFiles]
-@@PRODUCT_TAP_ID@@.sys = 1
-
-[DestinationDirs]
-   @@PRODUCT_TAP_ID@@.files  = 11
-   @@PRODUCT_TAP_ID@@.driver = 12
-
-[@@PRODUCT_TAP_ID@@.files]
-;   TapPanel.cpl,,,6   ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
-;   cipsrvr.exe,,,6     ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
-
-[@@PRODUCT_TAP_ID@@.driver]
-   @@PRODUCT_TAP_ID@@.sys,,,6     ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
-
-;---------------------------------------------------------------
-;                                      End
-;---------------------------------------------------------------
diff --git a/src/resource.rc b/src/resource.rc
index ed7cf20..b669c34 100755
--- a/src/resource.rc
+++ b/src/resource.rc
@@ -1,6 +1,8 @@
 #include <windows.h>
 #include <ntverp.h>
 
+#include "config.h"
+
 #undef VER_PRODUCTVERSION
 #undef VER_PRODUCTVERSION_STR
 #undef VER_COMPANYNAME_STR
@@ -36,18 +38,18 @@
 
 #define VER_COMPANYNAME_STR         "The OpenVPN Project"
 #define VER_FILEDESCRIPTION_STR     "TAP-Windows Virtual Network Driver"
-#define VER_ORIGINALFILENAME_STR    PRODUCT_TAP_ID ".sys"
+#define VER_ORIGINALFILENAME_STR    PRODUCT_TAP_WIN_COMPONENT_ID ".sys"
 #define VER_LEGALCOPYRIGHT_YEARS    "2003-2010"
 #define VER_LEGALCOPYRIGHT_STR      "OpenVPN Technologies, Inc."
 
 
 #define VER_PRODUCTNAME_STR         VER_FILEDESCRIPTION_STR
-#define VER_PRODUCTVERSION	    TAP_DRIVER_MAJOR_VERSION,00,00,TAP_DRIVER_MINOR_VERSION
+#define VER_PRODUCTVERSION	    PRODUCT_TAP_WIN_MAJOR,00,00,PRODUCT_TAP_WIN_MINOR
 
 #define XSTR(s) STR(s)
 #define STR(s) #s
 
-#define VSTRING PACKAGE_VERSION " " XSTR(TAP_DRIVER_MAJOR_VERSION) "/" XSTR(TAP_DRIVER_MINOR_VERSION)
+#define VSTRING PRODUCT_VERSION " " XSTR(PRODUCT_TAP_WIN_MAJOR) "/" XSTR(PRODUCT_TAP_WIN_MINOR)
 
 #ifdef DBG
 #define VER_PRODUCTVERSION_STR      VSTRING " (DEBUG)"
diff --git a/src/tapdrvr.c b/src/tapdrvr.c
index d183902..43eca58 100755
--- a/src/tapdrvr.c
+++ b/src/tapdrvr.c
@@ -36,6 +36,7 @@
 //======================================================
 
 #include "tap-windows.h"
+#include "config.h"
 
 #define NDIS_MINIPORT_DRIVER
 #define BINARY_COMPATIBLE 0
@@ -1028,8 +1029,8 @@ NDIS_STATUS AdapterQuery
       //                       Vendor & Driver version Info
       //===================================================================
     case OID_GEN_VENDOR_DESCRIPTION:
-      l_QueryPtr = (TapAdapterQueryPointer) PRODUCT_STRING;
-      l_QueryLength = strlen (PRODUCT_STRING) + 1;
+      l_QueryPtr = (TapAdapterQueryPointer) PRODUCT_TAP_WIN_DEVICE_DESCRIPTION;
+      l_QueryLength = strlen (PRODUCT_TAP_WIN_DEVICE_DESCRIPTION) + 1;
       break;
 
     case OID_GEN_VENDOR_ID:
@@ -1045,8 +1046,8 @@ NDIS_STATUS AdapterQuery
 
     case OID_GEN_VENDOR_DRIVER_VERSION:
       l_Query.m_Long =
-	(((USHORT) TAP_DRIVER_MAJOR_VERSION) << 8 | (USHORT)
-	 TAP_DRIVER_MINOR_VERSION);
+	(((USHORT) PRODUCT_TAP_WIN_MAJOR) << 8 | (USHORT)
+	 PRODUCT_TAP_WIN_MINOR);
       break;
 
       //=================================================================
diff --git a/version.m4 b/version.m4
new file mode 100644
index 0000000..95fe9e0
--- /dev/null
+++ b/version.m4
@@ -0,0 +1,11 @@
+dnl define the TAP version
+define([PRODUCT_NAME], [TAP-Windows])
+define([PRODUCT_VERSION], [9.9])
+define([PRODUCT_VERSION_RESOURCE], [9,0,0,9])
+define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
+define([PRODUCT_TAP_WIN_MAJOR], [9])
+define([PRODUCT_TAP_WIN_MINOR], [9])
+define([PRODUCT_TAP_WIN_PROVIDER], [TAP-Windows Provider V9])
+define([PRODUCT_TAP_WIN_CHARACTERISTICS], [0x81])
+define([PRODUCT_TAP_WIN_DEVICE_DESCRIPTION], [TAP-Windows Adapter V9])
+define([PRODUCT_TAP_WIN_RELDATE], [04/19/2010])
-- 
1.7.3.4


