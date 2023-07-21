From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 21 Jul 2023 13:55:48 +0000
References: <gerrit.1689947729000.I807cffa40f18faa1adec4e15e84c032877a2b92e@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <81bc6fc4b46a1473a071b48ba71de9ccf6594e4a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DNHVEW2nt3Y="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.6]: Remove all
 traces of the previous MSVC build system
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DNHVEW2nt3Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/316?usp=3Demail )


Change subject: Remove all traces of the previous MSVC build system
......................................................................

Remove all traces of the previous MSVC build system

Completely replaced by the CMake build system now.

v2:
 - rebase on top of my dist fixes

Change-Id: I807cffa40f18faa1adec4e15e84c032877a2b92e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .gitignore
M Makefile.am
M build/Makefile.am
D build/msvc/Makefile.am
D build/msvc/msvc-generate/Makefile.am
D build/msvc/msvc-generate/Makefile.mak
D build/msvc/msvc-generate/git-version.py
D build/msvc/msvc-generate/msvc-generate.js
D build/msvc/msvc-generate/msvc-generate.vcxproj
D build/msvc/msvc-generate/version.m4.in
D config-msvc-version.h.in
D config-msvc.h
M configure.ac
D openvpn.sln
D src/compat/Debug.props
M src/compat/Makefile.am
D src/compat/PropertySheet.props
D src/compat/Release.props
M src/compat/compat-basename.c
M src/compat/compat-daemon.c
M src/compat/compat-dirname.c
M src/compat/compat-gettimeofday.c
M src/compat/compat-strsep.c
D src/compat/compat.vcxproj
M src/openvpn/Makefile.am
M src/openvpn/argv.c
M src/openvpn/auth_token.c
M src/openvpn/base64.c
M src/openvpn/block_dns.c
M src/openvpn/buffer.c
M src/openvpn/clinat.c
M src/openvpn/comp-lz4.c
M src/openvpn/comp.c
M src/openvpn/compstub.c
M src/openvpn/console.c
M src/openvpn/console_builtin.c
M src/openvpn/crypto.c
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/cryptoapi.c
M src/openvpn/dco.c
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/dhcp.c
M src/openvpn/dns.c
M src/openvpn/env_set.c
M src/openvpn/error.c
M src/openvpn/event.c
M src/openvpn/fdmisc.c
M src/openvpn/forward.c
M src/openvpn/fragment.c
M src/openvpn/gremlin.c
M src/openvpn/helper.c
M src/openvpn/httpdigest.c
M src/openvpn/init.c
M src/openvpn/interval.c
M src/openvpn/list.c
M src/openvpn/lladdr.c
M src/openvpn/lzo.c
M src/openvpn/manage.c
M src/openvpn/mbuf.c
M src/openvpn/misc.c
M src/openvpn/mroute.c
M src/openvpn/mss.c
M src/openvpn/mstats.c
M src/openvpn/mtcp.c
M src/openvpn/mtu.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/networking_freebsd.c
M src/openvpn/networking_iproute2.c
M src/openvpn/networking_sitnl.c
M src/openvpn/ntlm.c
M src/openvpn/occ.c
M src/openvpn/openssl_compat.h
M src/openvpn/openvpn.c
D src/openvpn/openvpn.vcxproj
M src/openvpn/openvpn_win32_resources.rc
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/otime.c
M src/openvpn/packet_id.c
M src/openvpn/perf.c
M src/openvpn/ping.c
M src/openvpn/pkcs11.c
M src/openvpn/pkcs11_mbedtls.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/platform.c
M src/openvpn/plugin.c
M src/openvpn/pool.c
M src/openvpn/proto.c
M src/openvpn/proxy.c
M src/openvpn/ps.c
M src/openvpn/push.c
M src/openvpn/reflect_filter.c
M src/openvpn/reliable.c
M src/openvpn/route.c
M src/openvpn/run_command.c
M src/openvpn/schedule.c
M src/openvpn/session_id.c
M src/openvpn/shaper.c
M src/openvpn/sig.c
M src/openvpn/socket.c
M src/openvpn/socks.c
M src/openvpn/ssl.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_util.c
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/status.c
M src/openvpn/tls_crypt.c
M src/openvpn/tun.c
D src/openvpn/vcpkg.json
M src/openvpn/vlan.c
M src/openvpn/win32-util.c
M src/openvpn/win32.c
M src/openvpn/xkey_helper.c
M src/openvpn/xkey_provider.c
M src/openvpnmsica/Makefile.am
M src/openvpnmsica/dllmain.c
M src/openvpnmsica/msica_arg.c
M src/openvpnmsica/msiex.c
D src/openvpnmsica/openvpnmsica-Debug.props
D src/openvpnmsica/openvpnmsica-Release.props
M src/openvpnmsica/openvpnmsica.c
D src/openvpnmsica/openvpnmsica.props
D src/openvpnmsica/openvpnmsica.vcxproj
M src/openvpnmsica/openvpnmsica_resources.rc
M src/openvpnserv/Makefile.am
D src/openvpnserv/openvpnserv.vcxproj
M src/openvpnserv/openvpnserv_resources.rc
M src/openvpnserv/service.h
M src/tapctl/Makefile.am
M src/tapctl/main.c
M src/tapctl/tap.c
D src/tapctl/tapctl.props
D src/tapctl/tapctl.vcxproj
M src/tapctl/tapctl_resources.rc
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_ncp.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_tls_crypt.c
154 files changed, 2 insertions(+), 2,403 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/316/1

diff --git a/.gitignore b/.gitignore
index f44b924..70fc5f9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,13 +10,7 @@
 *.idb
 *.suo
 *.ncb
-*.vcproj.*
-*.vcxproj.user
-*.sln.cache
 *.log
-Release
-Debug
-Win32-Output
 out
 .vs
 .deps
@@ -45,12 +39,8 @@
 m4/ltsugar.m4
 m4/ltversion.m4
 m4/lt~obsolete.m4
-vcpkg_installed

 version.sh
-msvc-env-local.bat
-config-msvc-local.h
-config-msvc-version.h
 doc/openvpn-examples.5
 doc/openvpn-examples.5.html
 doc/openvpn.8
@@ -62,7 +52,6 @@
 sample/sample-keys/sample-ca/
 vendor/cmocka_build
 vendor/dist
-build/msvc/msvc-generate/version.m4

 tests/t_client.sh
 tests/t_client-*-20??????-??????/
diff --git a/Makefile.am b/Makefile.am
index f4ac7be..7478cc5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -71,11 +71,7 @@
 	README.dco.md \
 	README.ec \
 	README.wolfssl \
-	openvpn.sln
-
-dist_noinst_HEADERS =3D \
-	config-msvc.h \
-	config-msvc-version.h.in
+	README.mbedtls

 if WIN32
 rootdir=3D$(prefix)
diff --git a/build/Makefile.am b/build/Makefile.am
index a914d57..e7cc4d8 100644
--- a/build/Makefile.am
+++ b/build/Makefile.am
@@ -13,5 +13,3 @@

 EXTRA_DIST =3D \
 	ltrc.inc
-
-SUBDIRS =3D msvc
diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
deleted file mode 100644
index df3b41f..0000000
--- a/build/msvc/Makefile.am
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
-#
-
-MAINTAINERCLEANFILES =3D \
-	$(srcdir)/Makefile.in
-
-SUBDIRS =3D msvc-generate
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generat=
e/Makefile.am
deleted file mode 100644
index fe13b37..0000000
--- a/build/msvc/msvc-generate/Makefile.am
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
-#
-
-MAINTAINERCLEANFILES =3D \
-	$(srcdir)/Makefile.in
-
-dist_noinst_DATA =3D \
-	git-version.py \
-	msvc-generate.vcxproj \
-	Makefile.mak \
-	msvc-generate.js \
-	version.m4.in
diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-genera=
te/Makefile.mak
deleted file mode 100644
index 9190742..0000000
--- a/build/msvc/msvc-generate/Makefile.mak
+++ /dev/null
@@ -1,67 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
-#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License version 2
-#  as published by the Free Software Foundation.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-
-CONFIG=3D$(SOLUTIONDIR)/version.m4
-
-INPUT_MSVC_VER=3D$(SOLUTIONDIR)/config-msvc-version.h.in
-OUTPUT_MSVC_VER=3D$(SOLUTIONDIR)/config-msvc-version.h
-
-INPUT_PLUGIN=3D$(SOLUTIONDIR)/include/openvpn-plugin.h.in
-OUTPUT_PLUGIN=3D$(SOLUTIONDIR)/include/openvpn-plugin.h
-
-INPUT_PLUGIN_CONFIG=3Dversion.m4.in
-OUTPUT_PLUGIN_CONFIG=3Dversion.m4
-
-INPUT_MAN=3D$(SOLUTIONDIR)/doc/openvpn.8.rst
-OUTPUT_MAN=3D$(SOLUTIONDIR)/doc/openvpn.8.html
-
-OUTPUT_MSVC_GIT_CONFIG=3D$(SOLUTIONDIR)/config-version.h
-
-all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN) $(OUTPUT_MSVC_GIT_C=
ONFIG)
-
-$(OUTPUT_MSVC_VER): $(INPUT_MSVC_VER) $(CONFIG)
-	cscript //nologo msvc-generate.js --config=3D"$(CONFIG)" --input=3D"$(INP=
UT_MSVC_VER)" --output=3D"$(OUTPUT_MSVC_VER)"
-
-$(OUTPUT_PLUGIN_CONFIG): $(INPUT_PLUGIN_CONFIG)
-	cscript //nologo msvc-generate.js --config=3D"$(CONFIG)" --input=3D"$(INP=
UT_PLUGIN_CONFIG)" --output=3D"$(OUTPUT_PLUGIN_CONFIG)"
-
-$(OUTPUT_PLUGIN): $(INPUT_PLUGIN) $(OUTPUT_PLUGIN_CONFIG)
-	cscript //nologo msvc-generate.js --config=3D"$(OUTPUT_PLUGIN_CONFIG)" --=
input=3D"$(INPUT_PLUGIN)" --output=3D"$(OUTPUT_PLUGIN)"
-
-$(OUTPUT_MAN): $(INPUT_MAN)
-	-FOR /F %i IN ('where rst2html.py') DO python %i "$(INPUT_MAN)" "$(OUTPUT=
_MAN)"
-
-# Force regeneration because we can't detect whether it is outdated
-$(OUTPUT_MSVC_GIT_CONFIG): FORCE
-	python git-version.py $(SOLUTIONDIR)
-
-FORCE:
-
-clean:
-	-del "$(OUTPUT_MSVC_VER)"
-	-del "$(OUTPUT_PLUGIN)"
-	-del "$(OUTPUT_PLUGIN_CONFIG)"
-	-del "$(OUTPUT_MAN)"
-	-del "$(OUTPUT_MSVC_GIT_CONFIG)"
diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-gene=
rate/git-version.py
deleted file mode 100644
index c2b4452..0000000
--- a/build/msvc/msvc-generate/git-version.py
+++ /dev/null
@@ -1,75 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License version 2
-#  as published by the Free Software Foundation.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-
-import os
-import sys
-import subprocess
-
-def run_command(args):
-    sp =3D subprocess.Popen(args, stdout=3Dsubprocess.PIPE, stderr=3Dsubpr=
ocess.DEVNULL)
-    o, _ =3D sp.communicate()
-    return o.decode("utf-8")[:-1]
-
-def get_branch_commit_id():
-    commit_id =3D run_command(["git", "rev-parse", "--short=3D16", "HEAD"])
-    if not commit_id:
-        raise
-    branch =3D run_command(["git", "describe", "--exact-match"])
-    if not branch:
-        # this returns an array like ["master"] or ["release", "2.6"]
-        branch =3D run_command(["git", "rev-parse", "--symbolic-full-name"=
, "HEAD"]).split("/")[2:]
-        if not branch:
-            branch =3D ["none"]
-        branch =3D "/" .join(branch) # handle cases like release/2.6
-
-    return branch, commit_id
-
-def main():
-    try:
-        branch, commit_id =3D get_branch_commit_id()
-    except:
-        branch, commit_id =3D "unknown", "unknown"
-
-    prev_content =3D ""
-
-    name =3D os.path.join("%s" %  (sys.argv[1] if len(sys.argv) > 1 else "=
."), "config-version.h")
-    try:
-        with open(name, "r") as f:
-            prev_content =3D f.read()
-    except:
-        # file doesn't exist
-        pass
-
-    content =3D "#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch, co=
mmit_id)
-    content +=3D "#define CONFIGURE_GIT_FLAGS \"\"\n"
-
-    if prev_content !=3D content:
-        print("Writing %s" % name)
-        with open(name, "w") as f:
-            f.write(content)
-    else:
-        print("Content of %s hasn't changed" % name)
-
-if __name__ =3D=3D "__main__":
-    main()
diff --git a/build/msvc/msvc-generate/msvc-generate.js b/build/msvc/msvc-ge=
nerate/msvc-generate.js
deleted file mode 100644
index d9564cf..0000000
--- a/build/msvc/msvc-generate/msvc-generate.js
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * msvc-generate.js  - string transformation
- *
- * Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
- *
- * BSD License
- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are =
met:
- *
- *     o Redistributions of source code must retain the above copyright no=
tice,
- *       this list of conditions and the following disclaimer.
- *     o Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in t=
he
- *       documentation and/or other materials provided with the distributi=
on.
- *     o Neither the name of the Alon Bar-Lev nor the names of its
- *       contributors may be used to endorse or promote products derived f=
rom
- *       this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS=
 IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, T=
HE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF =
THE
- * POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-var ForReading =3D 1;
-var fso =3D new ActiveXObject("Scripting.FileSystemObject");
-var input =3D "nul";
-var output =3D "nul";
-var files =3D new Array();
-var env =3D new Array();
-
-function initialize() {
-	for (var i=3D0;i<WScript.Arguments.length;i++) {
-		var arg =3D WScript.Arguments(i);
-		if (arg.match(/^--input=3D(.*)$/)) {
-			input=3DRegExp.$1;
-		}
-		else if (arg.match(/^--output=3D(.*)$/)) {
-			output=3DRegExp.$1;
-		}
-		else if (arg.match(/^--config=3D(.*)$/)) {
-			files.push(RegExp.$1);
-		}
-		else if (arg.match(/^--var=3D([^=3D]*)=3D(.*)$/)) {
-			env[RegExp.$1] =3D RegExp.$2;
-		}
-	}
-}
-
-function process_config(vars, file) {
-	try {
-		var fin =3D fso.OpenTextFile(file, ForReading);
-
-		while (!fin.AtEndOfStream) {
-			var content =3D fin.ReadLine();
-			if (content.match(/^[ \t]*define\(\[(.*)\],[ \t]*\[(.*)\]\)[ \t]*/)) {
-				vars[RegExp.$1] =3D RegExp.$2;
-			}
-		}
-	}
-	catch(e) {
-		throw new Error(1, "Cannot process '" + file + "'.");
-	}
-}
-
-function process_file(vars, input, output) {
-	var fin =3D fso.OpenTextFile(input, ForReading);
-	var fout =3D fso.CreateTextFile(output);
-	var content =3D fin.ReadAll();
-
-	for (var i in vars) {
-		content =3D content.replace(new RegExp("@"+i+"@", "g"), vars[i]);
-	}
-
-	fout.Write(content);
-}
-
-function build_vars() {
-	var vars =3D new Array();
-	for (var f in files) {
-		process_config(vars, files[f]);
-	}
-	for (var e in env) {
-		vars[e] =3D env[e];
-	}
-	return vars;
-}
-
-function main() {
-	try {
-		initialize();
-
-		var vars =3D build_vars();
-
-		process_file(
-			vars,
-			input,
-			output
-		);
-
-		WScript.Quit(0);
-	}
-	catch(e) {
-		WScript.Echo("ERROR: when procssing " + output + ": " + e.description);
-		WScript.Quit(1);
-	}
-}
-
-main();
diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/ms=
vc-generate/msvc-generate.vcxproj
deleted file mode 100644
index 70d411e..0000000
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ /dev/null
@@ -1,158 +0,0 @@
-=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"15.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label=3D"ProjectConfigurations">
-    <ProjectConfiguration Include=3D"Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label=3D"Globals">
-    <ProjectGuid>{8598C2C8-34C4-47A1-99B0-7C295A890615}</ProjectGuid>
-    <RootNamespace>msvc-generate</RootNamespace>
-    <Keyword>MakeFileProj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'" Label=3D"Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'" Label=3D"Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'" Label=3D"Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'" Label=3D"Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label=3D"ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|W=
in32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|A=
RM64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win=
32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64=
'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'=
">$(Configuration)\</OutDir>
-    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'=
">$(Configuration)\</IntDir>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|ARM64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLi=
ne>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|ARM64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLi=
ne>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|ARM64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'">config-msvc-version.h</NMakeOutput>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Debug|Win32'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMake=
PreprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Debug|x64'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePr=
eprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Debug|ARM64'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMake=
PreprocessorDefinitions>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|ARM64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Debug|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Debug|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Debug|ARM64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|ARM64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Debug|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemb=
lies>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Debug|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssembli=
es>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Debug|ARM64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemb=
lies>
-    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(Configuration)\</OutDir>
-    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(Configuration)\</IntDir>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|ARM64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommand=
Line>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLi=
ne>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|ARM64'">nmake -f Makefile.mak clean all</NMakeReBuildCommand=
Line>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|ARM64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'">config-msvc-version.h</NMakeOutput>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Release|Win32'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMa=
kePreprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Release|x64'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMake=
PreprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Release|ARM64'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMa=
kePreprocessorDefinitions>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|ARM64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Release|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Release|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Release|ARM64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|ARM64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Release|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAsse=
mblies>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Release|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemb=
lies>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Release|ARM64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAsse=
mblies>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <None Include=3D"Makefile.mak" />
-    <None Include=3D"msvc-generate.js" />
-  </ItemGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label=3D"ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/build/msvc/msvc-generate/version.m4.in b/build/msvc/msvc-gener=
ate/version.m4.in
deleted file mode 100644
index cbb4fef..0000000
--- a/build/msvc/msvc-generate/version.m4.in
+++ /dev/null
@@ -1,3 +0,0 @@
-define([OPENVPN_VERSION_MAJOR], [@PRODUCT_VERSION_MAJOR@])
-define([OPENVPN_VERSION_MINOR], [@PRODUCT_VERSION_MINOR@])
-define([OPENVPN_VERSION_PATCH], [@PRODUCT_VERSION_PATCH@])
diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
deleted file mode 100644
index 59ca654..0000000
--- a/config-msvc-version.h.in
+++ /dev/null
@@ -1,14 +0,0 @@
-#define PACKAGE_NAME "@PRODUCT_NAME@"
-#define PACKAGE_STRING "@PRODUCT_NAME@ @PRODUCT_VERSION_MAJOR@...220...@PR=
ODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
-#define PACKAGE_TARNAME "@PRODUCT_TARNAME@"
-#define PACKAGE "@PRODUCT_TARNAME@"
-#define PRODUCT_VERSION_MAJOR "@PRODUCT_VERSION_MAJOR@"
-#define PRODUCT_VERSION_MINOR "@PRODUCT_VERSION_MINOR@"
-#define PRODUCT_VERSION_PATCH "@PRODUCT_VERSION_PATCH@"
-#define PACKAGE_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_=
MINOR@@PRODUCT_VERSION_PATCH@"
-#define PRODUCT_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_=
MINOR@@PRODUCT_VERSION_PATCH@"
-#define PRODUCT_BUGREPORT "@PRODUCT_BUGREPORT@"
-#define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@
-#define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
-#define TAP_WIN_MIN_MAJOR @PRODUCT_TAP_WIN_MIN_MAJOR@
-#define TAP_WIN_MIN_MINOR @PRODUCT_TAP_WIN_MIN_MINOR@
diff --git a/config-msvc.h b/config-msvc.h
deleted file mode 100644
index a3c687e..0000000
--- a/config-msvc.h
+++ /dev/null
@@ -1,93 +0,0 @@
-#include <config-msvc-version.h>
-
-#define CONFIGURE_DEFINES "N/A"
-
-#define ENABLE_PF 1
-#define ENABLE_CRYPTO_OPENSSL 1
-#define ENABLE_FRAGMENT 1
-#define ENABLE_HTTP_PROXY 1
-#define ENABLE_LZO 1
-#define ENABLE_LZ4 1
-#define ENABLE_MANAGEMENT 1
-#define ENABLE_PKCS11 1
-#define ENABLE_PLUGIN 1
-#define ENABLE_PORT_SHARE 1
-#define ENABLE_SOCKS 1
-
-#define HAVE_FCNTL_H 1
-#define HAVE_STDIO_H 1
-#define HAVE_STDLIB_H 1
-#define HAVE_STRERROR 1
-#define HAVE_STRINGS_H 1
-#define HAVE_STRING_H 1
-#define HAVE_LIMITS_H 1
-#define HAVE_SYSTEM 1
-#define HAVE_TIME 1
-#define HAVE_TIME_H 1
-#define HAVE_WINDOWS_H 1
-#define HAVE_WINSOCK2_H 1
-#define HAVE_WS2TCPIP_H 1
-#define HAVE_IO_H 1
-#define HAVE_SYS_TYPES_H 1
-#define HAVE_SYS_STAT_H 1
-#define HAVE_LZO_LZO1X_H 1
-#define HAVE_LZO_LZOUTIL_H 1
-#define HAVE_VERSIONHELPERS_H 1
-
-#define HAVE_ACCESS 1
-#define HAVE_CHDIR 1
-#define HAVE_CHSIZE 1
-#define HAVE_IN_PKTINFO 1
-
-#define HAVE_OPENSSL_ENGINE 1
-#define HAVE_EXPORT_KEYING_MATERIAL 1
-
-#define HAVE_DIINSTALLDEVICE 1
-
-#ifndef __cplusplus
-#define inline __inline
-#endif
-
-#define TARGET_WIN32 1
-#define TARGET_ALIAS "Windows-MSVC"
-
-#define HAVE_DECL_SO_MARK 0
-
-#define strncasecmp strnicmp
-#define strcasecmp _stricmp
-
-#if _MSC_VER<1900
-#define snprintf _snprintf
-#endif
-
-#if _MSC_VER < 1800
-#define strtoull strtoul
-#endif
-
-#define in_addr_t uint32_t
-#define ssize_t SSIZE_T
-
-#define S_IRUSR _S_IREAD
-#define S_IWUSR _S_IWRITE
-#define S_IRGRP (S_IRUSR >> 3)
-#define R_OK 4
-#define W_OK 2
-#define X_OK 1
-#define F_OK 0
-
-#define SIGHUP    1
-#define SIGINT    2
-#define SIGUSR1   10
-#define SIGUSR2   12
-#define SIGTERM   15
-
-#include <inttypes.h>
-typedef uint16_t in_port_t;
-
-#ifdef HAVE_CONFIG_MSVC_LOCAL_H
-#include <config-msvc-local.h>
-#endif
-
-#define ENABLE_DCO 1
-
-#define HAVE_CONFIG_VERSION_H 1
diff --git a/configure.ac b/configure.ac
index 67f680b..7313308 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1492,8 +1492,6 @@
 	version.sh
 	Makefile
 	build/Makefile
-	build/msvc/Makefile
-	build/msvc/msvc-generate/Makefile
 	distro/Makefile
 	distro/systemd/Makefile
 	doc/Makefile
diff --git a/openvpn.sln b/openvpn.sln
deleted file mode 100644
index 3485bc9..0000000
--- a/openvpn.sln
+++ /dev/null
@@ -1,107 +0,0 @@
-=EF=BB=BF
-Microsoft Visual Studio Solution File, Format Version 12.00
-# Visual Studio Version 16
-VisualStudioVersion =3D 16.0.31205.134
-MinimumVisualStudioVersion =3D 10.0.40219.1
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpnserv", "src\=
openvpnserv\openvpnserv.vcxproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpn", "src\open=
vpn\openvpn.vcxproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "msvc-generate", "bu=
ild\msvc\msvc-generate\msvc-generate.vcxproj", "{8598C2C8-34C4-47A1-99B0-7C=
295A890615}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "compat", "src\compa=
t\compat.vcxproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "tapctl", "src\tapct=
l\tapctl.vcxproj", "{A06436E7-D576-490D-8BA0-0751D920334A}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpnmsica", "src=
\openvpnmsica\openvpnmsica.vcxproj", "{D41AA9D6-B818-476E-992E-0E16EB86BEE2=
}"
-EndProject
-Global
-	GlobalSection(SolutionConfigurationPlatforms) =3D preSolution
-		Debug|ARM64 =3D Debug|ARM64
-		Debug|Win32 =3D Debug|Win32
-		Debug|x64 =3D Debug|x64
-		Release|ARM64 =3D Release|ARM64
-		Release|Win32 =3D Release|Win32
-		Release|x64 =3D Release|x64
-	EndGlobalSection
-	GlobalSection(ProjectConfigurationPlatforms) =3D postSolution
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|ARM64.ActiveCfg =3D Debug|A=
RM64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|ARM64.Build.0 =3D Debug|ARM=
64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.ActiveCfg =3D Debug|W=
in32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.0 =3D Debug|Win=
32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.ActiveCfg =3D Debug|x64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.Build.0 =3D Debug|x64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM64.ActiveCfg =3D Relea=
se|ARM64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM64.Build.0 =3D Release=
|ARM64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg =3D Relea=
se|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 =3D Release=
|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.ActiveCfg =3D Release=
|x64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.Build.0 =3D Release|x=
64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|ARM64.ActiveCfg =3D Debug|A=
RM64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|ARM64.Build.0 =3D Debug|ARM=
64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.ActiveCfg =3D Debug|W=
in32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.0 =3D Debug|Win=
32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.ActiveCfg =3D Debug|x64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.Build.0 =3D Debug|x64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|ARM64.ActiveCfg =3D Relea=
se|ARM64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|ARM64.Build.0 =3D Release=
|ARM64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg =3D Relea=
se|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 =3D Release=
|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.ActiveCfg =3D Release=
|x64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.Build.0 =3D Release|x=
64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|ARM64.ActiveCfg =3D Debug|A=
RM64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|ARM64.Build.0 =3D Debug|ARM=
64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.ActiveCfg =3D Debug|W=
in32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.0 =3D Debug|Win=
32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.ActiveCfg =3D Debug|x64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.Build.0 =3D Debug|x64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|ARM64.ActiveCfg =3D Relea=
se|ARM64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|ARM64.Build.0 =3D Release=
|ARM64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg =3D Relea=
se|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Build.0 =3D Release=
|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.ActiveCfg =3D Release=
|x64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.Build.0 =3D Release|x=
64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.ActiveCfg =3D Debug|A=
RM64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.Build.0 =3D Debug|ARM=
64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.ActiveCfg =3D Debug|W=
in32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.0 =3D Debug|Win=
32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.ActiveCfg =3D Debug|x64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.Build.0 =3D Debug|x64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|ARM64.ActiveCfg =3D Relea=
se|ARM64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|ARM64.Build.0 =3D Release=
|ARM64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.ActiveCfg =3D Relea=
se|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 =3D Release=
|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.ActiveCfg =3D Release=
|x64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.Build.0 =3D Release|x=
64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.ActiveCfg =3D Debug|A=
RM64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.Build.0 =3D Debug|ARM=
64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.ActiveCfg =3D Debug|W=
in32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.Build.0 =3D Debug|Win=
32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.ActiveCfg =3D Debug|x64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.Build.0 =3D Debug|x64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|ARM64.ActiveCfg =3D Relea=
se|ARM64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|ARM64.Build.0 =3D Release=
|ARM64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.ActiveCfg =3D Relea=
se|Win32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.Build.0 =3D Release=
|Win32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.ActiveCfg =3D Release=
|x64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.Build.0 =3D Release|x=
64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM64.ActiveCfg =3D Debug|A=
RM64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM64.Build.0 =3D Debug|ARM=
64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.ActiveCfg =3D Debug|W=
in32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.Build.0 =3D Debug|Win=
32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.ActiveCfg =3D Debug|x64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.Build.0 =3D Debug|x64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|ARM64.ActiveCfg =3D Relea=
se|ARM64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|ARM64.Build.0 =3D Release=
|ARM64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.ActiveCfg =3D Relea=
se|Win32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.Build.0 =3D Release=
|Win32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.ActiveCfg =3D Release=
|x64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.Build.0 =3D Release|x=
64
-	EndGlobalSection
-	GlobalSection(SolutionProperties) =3D preSolution
-		HideSolutionNode =3D FALSE
-	EndGlobalSection
-	GlobalSection(ExtensibilityGlobals) =3D postSolution
-		SolutionGuid =3D {EB3CE5D3-415C-46F0-96AB-E1CDA287AB6D}
-	EndGlobalSection
-EndGlobal
diff --git a/src/compat/Debug.props b/src/compat/Debug.props
deleted file mode 100644
index 31bb9d9..0000000
--- a/src/compat/Debug.props
+++ /dev/null
@@ -1,21 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
-  <ImportGroup Label=3D"PropertySheets">
-    <Import Project=3D"PropertySheet.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_PropertySheetDisplayName>compat-Debug</_PropertySheetDisplayName>
-    <LinkIncremental>true</LinkIncremental>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <Optimization>Disabled</Optimization>
-      <PreprocessorDefinitions>_DEBUG;%(PreprocessorDefinitions)</Preproce=
ssorDefinitions>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index a42ec39..f5de451 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -12,12 +12,6 @@
 MAINTAINERCLEANFILES =3D \
 	$(srcdir)/Makefile.in

-EXTRA_DIST =3D \
-	compat.vcxproj \
-	PropertySheet.props \
-	Debug.props \
-	Release.props
-
 noinst_LTLIBRARIES =3D libcompat.la

 libcompat_la_SOURCES =3D \
diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.props
deleted file mode 100644
index 57f6995..0000000
--- a/src/compat/PropertySheet.props
+++ /dev/null
@@ -1,29 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
-  <ImportGroup Label=3D"PropertySheets" />
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <_PropertySheetDisplayName>compat</_PropertySheetDisplayName>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <WarningLevel>Level3</WarningLevel>
-      <PreprocessorDefinitions>WIN32;$(CPPFLAGS);%(PreprocessorDefinitions=
)</PreprocessorDefinitions>
-      <AdditionalIncludeDirectories>$(SolutionDir);$(SolutionDir)include;%=
(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ClCompile>
-    <Link>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
-    </Link>
-    <ResourceCompile />
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOLUTIONDIR)</AdditionalIncludeDirec=
tories>
-    </ResourceCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <BuildMacro Include=3D"SOLUTIONDIR">
-      <Value>$(SOLUTIONDIR)</Value>
-      <EnvironmentVariable>true</EnvironmentVariable>
-    </BuildMacro>
-  </ItemGroup>
-</Project>
\ No newline at end of file
diff --git a/src/compat/Release.props b/src/compat/Release.props
deleted file mode 100644
index 50eaa8d..0000000
--- a/src/compat/Release.props
+++ /dev/null
@@ -1,26 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
-  <ImportGroup Label=3D"PropertySheets">
-    <Import Project=3D"PropertySheet.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_PropertySheetDisplayName>compat-Release</_PropertySheetDisplayName>
-    <LinkIncremental>false</LinkIncremental>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
-      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
-      <PreprocessorDefinitions>NDEBUG;%(PreprocessorDefinitions)</Preproce=
ssorDefinitions>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-    </ClCompile>
-    <Link>
-      <EnableCOMDATFolding>true</EnableCOMDATFolding>
-      <OptimizeReferences>true</OptimizeReferences>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/compat/compat-basename.c b/src/compat/compat-basename.c
index e66e225..abb4f49 100644
--- a/src/compat/compat-basename.c
+++ b/src/compat/compat-basename.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #ifndef HAVE_BASENAME
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index 460b9e9..aebb8f4 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #ifndef HAVE_DAEMON
diff --git a/src/compat/compat-dirname.c b/src/compat/compat-dirname.c
index c1523d9..c131dee 100644
--- a/src/compat/compat-dirname.c
+++ b/src/compat/compat-dirname.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif


diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeof=
day.c
index 0dc7460..69843fb 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #ifndef HAVE_GETTIMEOFDAY
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index 6db013f..fbad98d 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #ifndef HAVE_STRSEP
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
deleted file mode 100644
index 9fcfd6c..0000000
--- a/src/compat/compat.vcxproj
+++ /dev/null
@@ -1,179 +0,0 @@
-=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"15.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label=3D"ProjectConfigurations">
-    <ProjectConfiguration Include=3D"Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label=3D"Globals">
-    <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
-    <RootNamespace>compat</RootNamespace>
-    <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'" Label=3D"Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'" Label=3D"Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'" Label=3D"Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'" Label=3D"Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label=3D"ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|W=
in32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|A=
RM64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win=
32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64=
'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"Debug.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDire=
ctories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDire=
ctories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDire=
ctories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDire=
ctories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDire=
ctories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDire=
ctories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include=3D"compat-basename.c" />
-    <ClCompile Include=3D"compat-dirname.c" />
-    <ClCompile Include=3D"compat-gettimeofday.c" />
-    <ClCompile Include=3D"compat-daemon.c" />
-    <ClCompile Include=3D"compat-strsep.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include=3D"compat.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include=3D"..\..\build\msvc\msvc-generate\msvc-gener=
ate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label=3D"ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 2f97991..52deef8 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -15,9 +15,7 @@
 	$(srcdir)/Makefile.in

 EXTRA_DIST =3D \
-	openvpn.vcxproj \
-	openvpn.manifest \
-	vcpkg.json
+	openvpn.manifest

 AM_CPPFLAGS =3D \
 	-I$(top_srcdir)/include \
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index cef0da9..50083ba 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -29,8 +29,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index e4486eb..6787ea7 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -1,7 +1,5 @@
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index 0ac65e9..a9c2f4c 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -33,8 +33,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index 4af429b..05b2599 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -25,8 +25,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 7725438..24f1ef2 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 514bd43..2b91f7b 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index e544a8d..33a480c 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 27b640c..6e30369 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index 496e60e..adb1f28 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index bbdd59c..5b367f2 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -25,8 +25,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 4101feb..b5264d8 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -30,8 +30,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index b5ae17e..b5268f1 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index cd43ee5..98cac60 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index f5372f8..b043bb9 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 20b7d98..3b92e48 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -31,8 +31,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 308578b..7c7eaac 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -26,8 +26,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #if defined(ENABLE_DCO)
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index af7776b..3ba1c81 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #if defined(ENABLE_DCO) && defined(TARGET_FREEBSD)
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0cf36ba..b033f85 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #if defined(ENABLE_DCO) && defined(TARGET_LINUX)
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 4b414ef..53f1523 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -21,8 +21,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #if defined(_WIN32)
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index b9cd3c6..ac7f538 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index b7808db..530e6d5 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 7905914..97b011f 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -26,8 +26,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 9a234e6..56addff 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index fa5aee2..6b6f951 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 3f74171..3570ed4 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5bffe07..d8ad0d1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 50391de..974ebda 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index c77fc40..501d70c 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 7c219fd..fa011ff 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 6714ef9..5c255b2 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d358ad0..6fb6900 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 8308df4..bde9dd9 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index f65d8a8..480f39d 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index ee67718..cc677b4 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -4,8 +4,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 848cb06..1901780 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -27,8 +27,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2eaf2f1..739ed40 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index a44f8c3..318b9ed 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 774ea06..ce6e4fd 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -25,8 +25,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 2683b40..91af2b6 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 98d5406..816e65b 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 1e92b41..04be449 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -27,8 +27,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 6c56a26..62eb14b 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 2925b7f..132f93c 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 8698aef..81625ea 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6fb9cff..aad11b1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #ifdef HAVE_SYS_INOTIFY_H
diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_free=
bsd.c
index 0633dce..1c94756 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -1,7 +1,5 @@
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 #include "syshead.h"
 #include "errlevel.h"
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_ipr=
oute2.c
index 0efeed0..9d2351c 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #if defined(TARGET_LINUX) && defined(ENABLE_IPROUTE)
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index cb9a47c..662e0e2 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #ifdef TARGET_LINUX
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 20527d4..0cb0a32 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -22,8 +22,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 94b82e0..8541f6e 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 56b1dcf..ffb64ad 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -36,8 +36,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "buffer.h"
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 1aaddcd..348392e 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
deleted file mode 100644
index 97baf67..0000000
--- a/src/openvpn/openvpn.vcxproj
+++ /dev/null
@@ -1,470 +0,0 @@
-=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"15.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label=3D"ProjectConfigurations">
-    <ProjectConfiguration Include=3D"Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label=3D"Globals">
-    <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
-    <RootNamespace>openvpn</RootNamespace>
-    <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label=3D"ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|W=
in32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|A=
RM64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win=
32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64=
'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=3D$(SolutionDir)cont=
rib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports</Vcp=
kgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=3D$(SolutionDir)cont=
rib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports</Vcp=
kgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=3D$(SolutionDir)cont=
rib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports</Vcp=
kgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=3D$(SolutionDir)cont=
rib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports</Vcp=
kgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=3D$(SolutionDir)cont=
rib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports</Vcp=
kgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=3D$(SolutionDir)cont=
rib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports</Vcp=
kgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg">
-    <VcpkgEnableManifest>true</VcpkgEnableManifest>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WA=
RNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)<=
/PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)<=
/UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectori=
es)</AdditionalIncludeDirectories>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;=
crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Adv=
api32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(=
PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirecto=
ries>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|x64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WA=
RNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)<=
/PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)<=
/UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectori=
es)</AdditionalIncludeDirectories>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;=
crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Adv=
api32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(=
PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirecto=
ries>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|ARM64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WA=
RNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)<=
/PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)<=
/UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectori=
es)</AdditionalIncludeDirectories>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;=
crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Adv=
api32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(=
PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirecto=
ries>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WA=
RNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)<=
/PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)<=
/UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectori=
es)</AdditionalIncludeDirectories>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;=
crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Adv=
api32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(=
PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirecto=
ries>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|x64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WA=
RNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)<=
/PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)<=
/UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectori=
es)</AdditionalIncludeDirectories>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-      <SDLCheck>true</SDLCheck>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;=
crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Adv=
api32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(=
PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirecto=
ries>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|ARM64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WA=
RNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)<=
/PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)<=
/UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectori=
es)</AdditionalIncludeDirectories>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;=
crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Adv=
api32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(=
PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirecto=
ries>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include=3D"argv.c" />
-    <ClCompile Include=3D"auth_token.c" />
-    <ClCompile Include=3D"base64.c" />
-    <ClCompile Include=3D"block_dns.c" />
-    <ClCompile Include=3D"buffer.c" />
-    <ClCompile Include=3D"clinat.c" />
-    <ClCompile Include=3D"comp-lz4.c" />
-    <ClCompile Include=3D"comp.c" />
-    <ClCompile Include=3D"compstub.c" />
-    <ClCompile Include=3D"console.c" />
-    <ClCompile Include=3D"console_builtin.c" />
-    <ClCompile Include=3D"crypto.c" />
-    <ClCompile Include=3D"crypto_openssl.c" />
-    <ClCompile Include=3D"cryptoapi.c" />
-    <ClCompile Include=3D"dco.c" />
-    <ClCompile Include=3D"dco_win.c" />
-    <ClCompile Include=3D"dhcp.c" />
-    <ClCompile Include=3D"dns.c" />
-    <ClCompile Include=3D"env_set.c" />
-    <ClCompile Include=3D"error.c" />
-    <ClCompile Include=3D"event.c" />
-    <ClCompile Include=3D"fdmisc.c" />
-    <ClCompile Include=3D"forward.c" />
-    <ClCompile Include=3D"fragment.c" />
-    <ClCompile Include=3D"gremlin.c" />
-    <ClCompile Include=3D"helper.c" />
-    <ClCompile Include=3D"httpdigest.c" />
-    <ClCompile Include=3D"init.c" />
-    <ClCompile Include=3D"interval.c" />
-    <ClCompile Include=3D"list.c" />
-    <ClCompile Include=3D"lladdr.c" />
-    <ClCompile Include=3D"lzo.c" />
-    <ClCompile Include=3D"manage.c" />
-    <ClCompile Include=3D"mbuf.c" />
-    <ClCompile Include=3D"misc.c" />
-    <ClCompile Include=3D"mroute.c" />
-    <ClCompile Include=3D"mss.c" />
-    <ClCompile Include=3D"mstats.c" />
-    <ClCompile Include=3D"mtcp.c" />
-    <ClCompile Include=3D"mtu.c" />
-    <ClCompile Include=3D"mudp.c" />
-    <ClCompile Include=3D"multi.c" />
-    <ClCompile Include=3D"ntlm.c" />
-    <ClCompile Include=3D"occ.c" />
-    <ClCompile Include=3D"openvpn.c" />
-    <ClCompile Include=3D"options.c" />
-    <ClCompile Include=3D"options_util.c" />
-    <ClCompile Include=3D"otime.c" />
-    <ClCompile Include=3D"packet_id.c" />
-    <ClCompile Include=3D"perf.c" />
-    <ClCompile Include=3D"ping.c" />
-    <ClCompile Include=3D"pkcs11.c" />
-    <ClCompile Include=3D"pkcs11_openssl.c" />
-    <ClCompile Include=3D"platform.c" />
-    <ClCompile Include=3D"plugin.c" />
-    <ClCompile Include=3D"pool.c" />
-    <ClCompile Include=3D"proto.c" />
-    <ClCompile Include=3D"proxy.c" />
-    <ClCompile Include=3D"ps.c" />
-    <ClCompile Include=3D"push.c" />
-    <ClCompile Include=3D"reflect_filter.c" />
-    <ClCompile Include=3D"reliable.c" />
-    <ClCompile Include=3D"route.c" />
-    <ClCompile Include=3D"run_command.c" />
-    <ClCompile Include=3D"schedule.c" />
-    <ClCompile Include=3D"session_id.c" />
-    <ClCompile Include=3D"shaper.c" />
-    <ClCompile Include=3D"sig.c" />
-    <ClCompile Include=3D"socket.c" />
-    <ClCompile Include=3D"socks.c" />
-    <ClCompile Include=3D"ssl.c" />
-    <ClCompile Include=3D"ssl_openssl.c" />
-    <ClCompile Include=3D"ssl_ncp.c" />
-    <ClCompile Include=3D"ssl_pkt.c" />
-    <ClCompile Include=3D"ssl_util.c" />
-    <ClCompile Include=3D"ssl_verify.c" />
-    <ClCompile Include=3D"ssl_verify_openssl.c" />
-    <ClCompile Include=3D"status.c" />
-    <ClCompile Include=3D"tls_crypt.c" />
-    <ClCompile Include=3D"tun.c" />
-    <ClCompile Include=3D"vlan.c" />
-    <ClCompile Include=3D"win32.c" />
-    <ClCompile Include=3D"win32-util.c" />
-    <ClCompile Include=3D"xkey_helper.c" />
-    <ClCompile Include=3D"xkey_provider.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include=3D"argv.h" />
-    <ClInclude Include=3D"auth_token.h" />
-    <ClInclude Include=3D"base64.h" />
-    <ClInclude Include=3D"basic.h" />
-    <ClInclude Include=3D"block_dns.h" />
-    <ClInclude Include=3D"buffer.h" />
-    <ClInclude Include=3D"circ_list.h" />
-    <ClInclude Include=3D"clinat.h" />
-    <ClInclude Include=3D"common.h" />
-    <ClInclude Include=3D"comp-lz4.h" />
-    <ClInclude Include=3D"comp.h" />
-    <ClInclude Include=3D"compstub.h" />
-    <ClInclude Include=3D"console.h" />
-    <ClInclude Include=3D"crypto.h" />
-    <ClInclude Include=3D"crypto_backend.h" />
-    <ClInclude Include=3D"crypto_openssl.h" />
-    <ClInclude Include=3D"cryptoapi.h" />
-    <ClInclude Include=3D"dco.h" />
-    <ClInclude Include=3D"dco_internal.h" />
-    <ClInclude Include=3D"dco_win.h" />
-    <ClInclude Include=3D"dhcp.h" />
-    <ClInclude Include=3D"dns.h" />
-    <ClInclude Include=3D"env_set.h" />
-    <ClInclude Include=3D"errlevel.h" />
-    <ClInclude Include=3D"error.h" />
-    <ClInclude Include=3D"event.h" />
-    <ClInclude Include=3D"fdmisc.h" />
-    <ClInclude Include=3D"forward.h" />
-    <ClInclude Include=3D"fragment.h" />
-    <ClInclude Include=3D"gremlin.h" />
-    <ClInclude Include=3D"helper.h" />
-    <ClInclude Include=3D"httpdigest.h" />
-    <ClInclude Include=3D"init.h" />
-    <ClInclude Include=3D"integer.h" />
-    <ClInclude Include=3D"interval.h" />
-    <ClInclude Include=3D"list.h" />
-    <ClInclude Include=3D"lladdr.h" />
-    <ClInclude Include=3D"lzo.h" />
-    <ClInclude Include=3D"manage.h" />
-    <ClInclude Include=3D"mbuf.h" />
-    <ClInclude Include=3D"memdbg.h" />
-    <ClInclude Include=3D"misc.h" />
-    <ClInclude Include=3D"mroute.h" />
-    <ClInclude Include=3D"mss.h" />
-    <ClInclude Include=3D"mstats.h" />
-    <ClInclude Include=3D"mtcp.h" />
-    <ClInclude Include=3D"mtu.h" />
-    <ClInclude Include=3D"mudp.h" />
-    <ClInclude Include=3D"multi.h" />
-    <ClInclude Include=3D"ntlm.h" />
-    <ClInclude Include=3D"occ.h" />
-    <ClInclude Include=3D"openvpn.h" />
-    <ClInclude Include=3D"options.h" />
-    <ClInclude Include=3D"options_util.h" />
-    <ClInclude Include=3D"otime.h" />
-    <ClInclude Include=3D"ovpn_dco_win.h" />
-    <ClInclude Include=3D"packet_id.h" />
-    <ClInclude Include=3D"perf.h" />
-    <ClInclude Include=3D"ping.h" />
-    <ClInclude Include=3D"pkcs11.h" />
-    <ClInclude Include=3D"pkcs11_backend.h" />
-    <ClInclude Include=3D"platform.h" />
-    <ClInclude Include=3D"plugin.h" />
-    <ClInclude Include=3D"pool.h" />
-    <ClInclude Include=3D"proto.h" />
-    <ClInclude Include=3D"proxy.h" />
-    <ClInclude Include=3D"ps.h" />
-    <ClInclude Include=3D"push.h" />
-    <ClInclude Include=3D"pushlist.h" />
-    <ClInclude Include=3D"reflect_filter.h" />
-    <ClInclude Include=3D"reliable.h" />
-    <ClInclude Include=3D"ring_buffer.h" />
-    <ClInclude Include=3D"route.h" />
-    <ClInclude Include=3D"run_command.h" />
-    <ClInclude Include=3D"schedule.h" />
-    <ClInclude Include=3D"session_id.h" />
-    <ClInclude Include=3D"shaper.h" />
-    <ClInclude Include=3D"sig.h" />
-    <ClInclude Include=3D"socket.h" />
-    <ClInclude Include=3D"socks.h" />
-    <ClInclude Include=3D"ssl.h" />
-    <ClInclude Include=3D"ssl_backend.h" />
-    <ClInclude Include=3D"ssl_common.h" />
-    <ClInclude Include=3D"ssl_ncp.h" />
-    <ClInclude Include=3D"ssl_openssl.h" />
-    <ClInclude Include=3D"ssl_pkt.h" />
-    <ClInclude Include=3D"ssl_util.h" />
-    <ClInclude Include=3D"ssl_verify.h" />
-    <ClInclude Include=3D"ssl_verify_backend.h" />
-    <ClInclude Include=3D"ssl_verify_openssl.h" />
-    <ClInclude Include=3D"status.h" />
-    <ClInclude Include=3D"syshead.h" />
-    <ClInclude Include=3D"tls_crypt.h" />
-    <ClInclude Include=3D"tun.h" />
-    <ClInclude Include=3D"vlan.h" />
-    <ClInclude Include=3D"win32.h" />
-    <ClInclude Include=3D"win32-util.h" />
-    <ClInclude Include=3D"xkey_common.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include=3D"openvpn_win32_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include=3D"..\..\build\msvc\msvc-generate\msvc-gener=
ate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-    <ProjectReference Include=3D"..\compat\compat.vcxproj">
-      <Project>{4b2e2719-e661-45d7-9203-f6f456b22f19}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <ItemGroup>
-    <Manifest Include=3D"openvpn.manifest" />
-  </ItemGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label=3D"ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn_w=
in32_resources.rc
index 1ea5f87..a843b1b 100644
--- a/src/openvpn/openvpn_win32_resources.rc
+++ b/src/openvpn/openvpn_win32_resources.rc
@@ -1,7 +1,5 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#else
-#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index efddc58..90d85be 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -29,8 +29,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 #ifdef HAVE_CONFIG_VERSION_H
 #include "config-version.h"
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index b071f37..3660da0 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 0bbed81..b28a90f 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index bb790f0..ef83248 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -32,8 +32,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 5eb8926..ca4f810 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 25822c9..ccf9870 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index b6c3bf1..cfe6cf6 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index a286a23..7e4be14 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 9b0ab39..7c07152 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index f6b856f..32c4fe6 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index d662998..b4d4a98 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 #ifdef HAVE_CONFIG_VERSION_H
 #include "config-version.h"
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 4af9bcb..5ab0f95 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 7a84407..cab60c3 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index ed47eaa..76e27cb 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 3609630..4659e17 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8f0a534..01e7cd6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index cfe69a6..0db456b 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 32b346b..e7d4d5f 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f2852b4..90e981e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -27,8 +27,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 8c2a6d7..864b317 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index b0fca03..e1bc24a 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 89c67ef..25c5faa 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -32,8 +32,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 6a0d7dd..c65dec8 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 05c0054..8b80aeb 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index fc643c1..91a6d53 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 2cf0cc9..a29eb83 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -31,8 +31,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8641a51..c975dbc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -36,8 +36,6 @@
  */
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 49989d9..81dd906 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -29,8 +29,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 22dbe21..dafaef1 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -37,8 +37,6 @@
  */
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 65b36d1..0b310de 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 8b3391e..afc5aab 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -22,8 +22,6 @@
  */
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index e12ed3d..bca6eed 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -22,8 +22,6 @@
  */
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 1b589f1..90416b6 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index e3437f7..a1ddf8d 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index e24ce4e..3194c23 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 737f340..0cb4408 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 7354236..975d31f 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index af959bb..6097420 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -31,8 +31,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/vcpkg.json b/src/openvpn/vcpkg.json
deleted file mode 100644
index 0afd802..0000000
--- a/src/openvpn/vcpkg.json
+++ /dev/null
@@ -1,15 +0,0 @@
-{
-  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scr=
ipts/vcpkg.schema.json",
-  "name": "openvpn",
-  "version": "2.6",
-  "dependencies": [
-     {
-       "name": "openssl",
-       "features": ["tools"]
-     },
-    "tap-windows6",
-    "lzo",
-    "lz4",
-    "pkcs11-helper"
-  ]
-}
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 2510042..0bb7abc 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 32f7a00..81e504a 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 25da54a..156ee74 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -28,8 +28,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index ee9677a..40839f2 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index b0f414f..db316fe 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index d68a008..dc53f75 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -22,12 +22,6 @@

 MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in

-EXTRA_DIST =3D \
-	openvpnmsica.vcxproj \
-	openvpnmsica.props \
-	openvpnmsica-Debug.props \
-	openvpnmsica-Release.props
-
 AM_CPPFLAGS =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat

diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 7cff41a..1bf3d56 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif

 #include "openvpnmsica.h"
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index ad6968f..d1eb404 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif

 #include "msica_arg.h"
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 3ea2c1a..78017eb 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif

 #include "msiex.h"
diff --git a/src/openvpnmsica/openvpnmsica-Debug.props b/src/openvpnmsica/o=
penvpnmsica-Debug.props
deleted file mode 100644
index 43532cf..0000000
--- a/src/openvpnmsica/openvpnmsica-Debug.props
+++ /dev/null
@@ -1,14 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
-  <ImportGroup Label=3D"PropertySheets">
-    <Import Project=3D"openvpnmsica.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup />
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <RuntimeLibrary>MultiThreadedDebug</RuntimeLibrary>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica-Release.props b/src/openvpnmsica=
/openvpnmsica-Release.props
deleted file mode 100644
index 47727b3..0000000
--- a/src/openvpnmsica/openvpnmsica-Release.props
+++ /dev/null
@@ -1,15 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
-  <ImportGroup Label=3D"PropertySheets">
-    <Import Project=3D"openvpnmsica.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup />
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <RuntimeLibrary>MultiThreaded</RuntimeLibrary>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 06c9789..e5312d6 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif
 #include <winsock2.h> /* Must be included _before_ <windows.h> */

diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpn=
msica.props
deleted file mode 100644
index 1091c9f..0000000
--- a/src/openvpnmsica/openvpnmsica.props
+++ /dev/null
@@ -1,17 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
-  <ImportGroup Label=3D"PropertySheets" />
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <TargetName>lib$(ProjectName)</TargetName>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <PreprocessorDefinitions>_WIN32_WINNT=3D_WIN32_WINNT_VISTA;%(Preproc=
essorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-    <Link>
-      <SubSystem>Windows</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openv=
pnmsica.vcxproj
deleted file mode 100644
index c9154b3..0000000
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ /dev/null
@@ -1,208 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"15.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label=3D"ProjectConfigurations">
-    <ProjectConfiguration Include=3D"Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label=3D"Globals">
-    <VCProjectVersion>15.0</VCProjectVersion>
-    <ProjectGuid>{D41AA9D6-B818-476E-992E-0E16EB86BEE2}</ProjectGuid>
-    <Keyword>Win32Proj</Keyword>
-    <RootNamespace>openvpnmsica</RootNamespace>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'" Label=3D"Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'" Label=3D"Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'" Label=3D"Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'" Label=3D"Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label=3D"ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Label=3D"Shared">
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Debug|ARM64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-    <Import Project=3D"openvpnmsica-Debug.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Debug|Win32'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-    <Import Project=3D"openvpnmsica-Debug.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Debug|x64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-    <Import Project=3D"openvpnmsica-Debug.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Release|ARM64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-    <Import Project=3D"openvpnmsica-Release.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Release|Win32'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-    <Import Project=3D"openvpnmsica-Release.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Release|x64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-    <Import Project=3D"openvpnmsica-Release.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|x64'">
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|ARM64'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|ARM64'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|x64'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include=3D"..\tapctl\error.c" />
-    <ClCompile Include=3D"..\tapctl\tap.c" />
-    <ClCompile Include=3D"dllmain.c" />
-    <ClCompile Include=3D"msiex.c" />
-    <ClCompile Include=3D"msica_arg.c" />
-    <ClCompile Include=3D"openvpnmsica.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include=3D"..\tapctl\basic.h" />
-    <ClInclude Include=3D"..\tapctl\error.h" />
-    <ClInclude Include=3D"..\tapctl\tap.h" />
-    <ClInclude Include=3D"msiex.h" />
-    <ClInclude Include=3D"msica_arg.h" />
-    <ClInclude Include=3D"openvpnmsica.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include=3D"openvpnmsica_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include=3D"..\..\build\msvc\msvc-generate\msvc-gener=
ate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label=3D"ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/=
openvpnmsica_resources.rc
index d7c14de..e30c8a1 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -19,8 +19,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#else
-#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>
=20
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 4c0ac40..d8ba4eb 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -13,9 +13,6 @@

 MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in

-EXTRA_DIST =3D \
-	openvpnserv.vcxproj
-
 AM_CPPFLAGS =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/c=
ompat

diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj
deleted file mode 100644
index db3a446..0000000
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ /dev/null
@@ -1,229 +0,0 @@
-=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"15.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label=3D"ProjectConfigurations">
-    <ProjectConfiguration Include=3D"Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label=3D"Globals">
-    <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
-    <RootNamespace>openvpnserv</RootNamespace>
-    <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label=3D"ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|W=
in32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|A=
RM64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win=
32'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64=
'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM=
64'" Label=3D"PropertySheets">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Prepro=
cessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.=
lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependenc=
ies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Prepro=
cessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iph=
lpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDepen=
dencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Prepro=
cessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iph=
lpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDepen=
dencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Prepro=
cessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.=
lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependenc=
ies>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Prepro=
cessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iph=
lpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDepen=
dencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Prepro=
cessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iph=
lpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDepen=
dencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include=3D"common.c" />
-    <ClCompile Include=3D"interactive.c" />
-    <ClCompile Include=3D"service.c" />
-    <ClCompile Include=3D"validate.c" />
-    <ClCompile Include=3D"..\openvpn\block_dns.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include=3D"..\openvpn\ring_buffer.h" />
-    <ClInclude Include=3D"service.h" />
-    <ClInclude Include=3D"validate.h" />
-    <ClInclude Include=3D"..\openvpn\block_dns.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include=3D"openvpnserv_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include=3D"..\..\build\msvc\msvc-generate\msvc-gener=
ate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label=3D"ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/ope=
nvpnserv_resources.rc
index 4ea453e..ddd0cb8 100644
--- a/src/openvpnserv/openvpnserv_resources.rc
+++ b/src/openvpnserv/openvpnserv_resources.rc
@@ -1,7 +1,5 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#else
-#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>

diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index fc5ecda..d38a665 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -31,8 +31,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include <winsock2.h>
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index fe8ab2a..69ea161 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -22,11 +22,6 @@

 MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in

-EXTRA_DIST =3D \
-	tapctl.vcxproj \
-	tapctl.props \
-	tapctl.exe.manifest
-
 AM_CPPFLAGS =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index d76d553..a946c2c 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -21,8 +21,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif

 #include "tap.h"
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 44fcdde..5ae8044 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -20,8 +20,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif

 #include "tap.h"
diff --git a/src/tapctl/tapctl.props b/src/tapctl/tapctl.props
deleted file mode 100644
index 0257b9f..0000000
--- a/src/tapctl/tapctl.props
+++ /dev/null
@@ -1,18 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
-  <ImportGroup Label=3D"PropertySheets" />
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;_WIN32_WINNT=3D_WIN32_WINNT_VISTA;=
%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;=
%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ClCompile>
-    <Link>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
deleted file mode 100644
index 6311d7f..0000000
--- a/src/tapctl/tapctl.vcxproj
+++ /dev/null
@@ -1,205 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"15.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label=3D"ProjectConfigurations">
-    <ProjectConfiguration Include=3D"Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include=3D"Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label=3D"Globals">
-    <VCProjectVersion>15.0</VCProjectVersion>
-    <ProjectGuid>{A06436E7-D576-490D-8BA0-0751D920334A}</ProjectGuid>
-    <Keyword>Win32Proj</Keyword>
-    <RootNamespace>tapctl</RootNamespace>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|A=
RM64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|ARM64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'" Label=3D"Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label=3D"ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Label=3D"Shared">
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Debug|ARM64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-    <Import Project=3D"tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Debug|Win32'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-    <Import Project=3D"tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Debug|x64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Debug.props" />
-    <Import Project=3D"tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Release|ARM64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-    <Import Project=3D"tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Release|Win32'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-    <Import Project=3D"tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label=3D"PropertySheets" Condition=3D"'$(Configuration)|$(P=
latform)'=3D=3D'Release|x64'">
-    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
-    <Import Project=3D"..\compat\Release.props" />
-    <Import Project=3D"tapctl.props" />
-  </ImportGroup>
-  <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label=3D"Vcpkg" Condition=3D"'$(Configuration)|$(Platform=
)'=3D=3D'Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|ARM64'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|ARM64'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|x64'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|x64'">
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptio=
ns>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include=3D"error.c" />
-    <ClCompile Include=3D"tap.c" />
-    <ClCompile Include=3D"main.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include=3D"basic.h" />
-    <ClInclude Include=3D"error.h" />
-    <ClInclude Include=3D"tap.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include=3D"tapctl_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include=3D"..\..\build\msvc\msvc-generate\msvc-gener=
ate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <ItemGroup>
-    <Manifest Include=3D"tapctl.exe.manifest" />
-  </ItemGroup>
-  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label=3D"ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index fc65b5a..c49f82d 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -19,8 +19,6 @@

 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#else
-#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>

diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index 3fa9a16..3ff1ea8 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include <stdarg.h>
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index 57e98f5..d96984f 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 9e3b1d2..92ac77a 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index aec4e04..58eebc0 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 0859b58..7b38e18 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -24,8 +24,6 @@
=20
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 5a8978d..43ae96b 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn=
/test_ncp.c
index 0e52ea2..72a1c3b 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index 9b653a8..90c67ac 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index eb69829..9f49ee7 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index 255067c..335fca2 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -24,8 +24,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 8bbe600..ed7c794 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -23,8 +23,6 @@

 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif

 #include "syshead.h"

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/316?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I807cffa40f18faa1adec4e15e84c032877a2b92e
Gerrit-Change-Number: 316
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--DNHVEW2nt3Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/316?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Remove all traces of the previous MSVC build system<br><br>Complete=
ly replaced by the CMake build system now.<br><br>v2:<br> - rebase on top o=
f my dist fixes<br><br>Change-Id: I807cffa40f18faa1adec4e15e84c032877a2b92e=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .=
gitignore<br>M Makefile.am<br>M build/Makefile.am<br>D build/msvc/Makefile.=
am<br>D build/msvc/msvc-generate/Makefile.am<br>D build/msvc/msvc-generate/=
Makefile.mak<br>D build/msvc/msvc-generate/git-version.py<br>D build/msvc/m=
svc-generate/msvc-generate.js<br>D build/msvc/msvc-generate/msvc-generate.v=
cxproj<br>D build/msvc/msvc-generate/version.m4.in<br>D config-msvc-version=
.h.in<br>D config-msvc.h<br>M configure.ac<br>D openvpn.sln<br>D src/compat=
/Debug.props<br>M src/compat/Makefile.am<br>D src/compat/PropertySheet.prop=
s<br>D src/compat/Release.props<br>M src/compat/compat-basename.c<br>M src/=
compat/compat-daemon.c<br>M src/compat/compat-dirname.c<br>M src/compat/com=
pat-gettimeofday.c<br>M src/compat/compat-strsep.c<br>D src/compat/compat.v=
cxproj<br>M src/openvpn/Makefile.am<br>M src/openvpn/argv.c<br>M src/openvp=
n/auth_token.c<br>M src/openvpn/base64.c<br>M src/openvpn/block_dns.c<br>M =
src/openvpn/buffer.c<br>M src/openvpn/clinat.c<br>M src/openvpn/comp-lz4.c<=
br>M src/openvpn/comp.c<br>M src/openvpn/compstub.c<br>M src/openvpn/consol=
e.c<br>M src/openvpn/console_builtin.c<br>M src/openvpn/crypto.c<br>M src/o=
penvpn/crypto_mbedtls.c<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/=
cryptoapi.c<br>M src/openvpn/dco.c<br>M src/openvpn/dco_freebsd.c<br>M src/=
openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/dhcp.c<br>M=
 src/openvpn/dns.c<br>M src/openvpn/env_set.c<br>M src/openvpn/error.c<br>M=
 src/openvpn/event.c<br>M src/openvpn/fdmisc.c<br>M src/openvpn/forward.c<b=
r>M src/openvpn/fragment.c<br>M src/openvpn/gremlin.c<br>M src/openvpn/help=
er.c<br>M src/openvpn/httpdigest.c<br>M src/openvpn/init.c<br>M src/openvpn=
/interval.c<br>M src/openvpn/list.c<br>M src/openvpn/lladdr.c<br>M src/open=
vpn/lzo.c<br>M src/openvpn/manage.c<br>M src/openvpn/mbuf.c<br>M src/openvp=
n/misc.c<br>M src/openvpn/mroute.c<br>M src/openvpn/mss.c<br>M src/openvpn/=
mstats.c<br>M src/openvpn/mtcp.c<br>M src/openvpn/mtu.c<br>M src/openvpn/mu=
dp.c<br>M src/openvpn/multi.c<br>M src/openvpn/networking_freebsd.c<br>M sr=
c/openvpn/networking_iproute2.c<br>M src/openvpn/networking_sitnl.c<br>M sr=
c/openvpn/ntlm.c<br>M src/openvpn/occ.c<br>M src/openvpn/openssl_compat.h<b=
r>M src/openvpn/openvpn.c<br>D src/openvpn/openvpn.vcxproj<br>M src/openvpn=
/openvpn_win32_resources.rc<br>M src/openvpn/options.c<br>M src/openvpn/opt=
ions_util.c<br>M src/openvpn/otime.c<br>M src/openvpn/packet_id.c<br>M src/=
openvpn/perf.c<br>M src/openvpn/ping.c<br>M src/openvpn/pkcs11.c<br>M src/o=
penvpn/pkcs11_mbedtls.c<br>M src/openvpn/pkcs11_openssl.c<br>M src/openvpn/=
platform.c<br>M src/openvpn/plugin.c<br>M src/openvpn/pool.c<br>M src/openv=
pn/proto.c<br>M src/openvpn/proxy.c<br>M src/openvpn/ps.c<br>M src/openvpn/=
push.c<br>M src/openvpn/reflect_filter.c<br>M src/openvpn/reliable.c<br>M s=
rc/openvpn/route.c<br>M src/openvpn/run_command.c<br>M src/openvpn/schedule=
.c<br>M src/openvpn/session_id.c<br>M src/openvpn/shaper.c<br>M src/openvpn=
/sig.c<br>M src/openvpn/socket.c<br>M src/openvpn/socks.c<br>M src/openvpn/=
ssl.c<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_ncp.c<br>M src/op=
envpn/ssl_openssl.c<br>M src/openvpn/ssl_pkt.c<br>M src/openvpn/ssl_util.c<=
br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M sr=
c/openvpn/ssl_verify_openssl.c<br>M src/openvpn/status.c<br>M src/openvpn/t=
ls_crypt.c<br>M src/openvpn/tun.c<br>D src/openvpn/vcpkg.json<br>M src/open=
vpn/vlan.c<br>M src/openvpn/win32-util.c<br>M src/openvpn/win32.c<br>M src/=
openvpn/xkey_helper.c<br>M src/openvpn/xkey_provider.c<br>M src/openvpnmsic=
a/Makefile.am<br>M src/openvpnmsica/dllmain.c<br>M src/openvpnmsica/msica_a=
rg.c<br>M src/openvpnmsica/msiex.c<br>D src/openvpnmsica/openvpnmsica-Debug=
.props<br>D src/openvpnmsica/openvpnmsica-Release.props<br>M src/openvpnmsi=
ca/openvpnmsica.c<br>D src/openvpnmsica/openvpnmsica.props<br>D src/openvpn=
msica/openvpnmsica.vcxproj<br>M src/openvpnmsica/openvpnmsica_resources.rc<=
br>M src/openvpnserv/Makefile.am<br>D src/openvpnserv/openvpnserv.vcxproj<b=
r>M src/openvpnserv/openvpnserv_resources.rc<br>M src/openvpnserv/service.h=
<br>M src/tapctl/Makefile.am<br>M src/tapctl/main.c<br>M src/tapctl/tap.c<b=
r>D src/tapctl/tapctl.props<br>D src/tapctl/tapctl.vcxproj<br>M src/tapctl/=
tapctl_resources.rc<br>M tests/unit_tests/openvpn/mock_msg.c<br>M tests/uni=
t_tests/openvpn/test_auth_token.c<br>M tests/unit_tests/openvpn/test_buffer=
.c<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/unit_tests/openvp=
n/test_cryptoapi.c<br>M tests/unit_tests/openvpn/test_misc.c<br>M tests/uni=
t_tests/openvpn/test_ncp.c<br>M tests/unit_tests/openvpn/test_packet_id.c<b=
r>M tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/openvpn/test_=
provider.c<br>M tests/unit_tests/openvpn/test_tls_crypt.c<br>154 files chan=
ged, 2 insertions(+), 2,403 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/16/316/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.gitigno=
re b/.gitignore</span><br><span>index f44b924..70fc5f9 100644</span><br><sp=
an>--- a/.gitignore</span><br><span>+++ b/.gitignore</span><br><span>@@ -10=
,13 +10,7 @@</span><br><span> *.idb</span><br><span> *.suo</span><br><span>=
 *.ncb</span><br><span style=3D"color: hsl(0, 100%, 40%);">-*.vcproj.*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-*.vcxproj.user</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-*.sln.cache</span><br><span> *.lo=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Release</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-Debug</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-Win32-Output</span><br><span> out</span><br><span>=
 .vs</span><br><span> .deps</span><br><span>@@ -45,12 +39,8 @@</span><br><s=
pan> m4/ltsugar.m4</span><br><span> m4/ltversion.m4</span><br><span> m4/lt~=
obsolete.m4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vcpkg_inst=
alled</span><br><span> </span><br><span> version.sh</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-msvc-env-local.bat</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-config-msvc-local.h</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-config-msvc-version.h</span><br><span> doc/openv=
pn-examples.5</span><br><span> doc/openvpn-examples.5.html</span><br><span>=
 doc/openvpn.8</span><br><span>@@ -62,7 +52,6 @@</span><br><span> sample/sa=
mple-keys/sample-ca/</span><br><span> vendor/cmocka_build</span><br><span> =
vendor/dist</span><br><span style=3D"color: hsl(0, 100%, 40%);">-build/msvc=
/msvc-generate/version.m4</span><br><span> </span><br><span> tests/t_client=
.sh</span><br><span> tests/t_client-*-20??????-??????/</span><br><span>diff=
 --git a/Makefile.am b/Makefile.am</span><br><span>index f4ac7be..7478cc5 1=
00644</span><br><span>--- a/Makefile.am</span><br><span>+++ b/Makefile.am</=
span><br><span>@@ -71,11 +71,7 @@</span><br><span> 	README.dco.md \</span><=
br><span> 	README.ec \</span><br><span> 	README.wolfssl \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	openvpn.sln</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-dist_noinst_HEADERS =3D \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	config-msvc.h \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	config-msvc-version.h.in</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	README.mbedtls</span><br><span> </span><br><span> if WIN32</spa=
n><br><span> rootdir=3D$(prefix)</span><br><span>diff --git a/build/Makefil=
e.am b/build/Makefile.am</span><br><span>index a914d57..e7cc4d8 100644</spa=
n><br><span>--- a/build/Makefile.am</span><br><span>+++ b/build/Makefile.am=
</span><br><span>@@ -13,5 +13,3 @@</span><br><span> </span><br><span> EXTRA=
_DIST =3D \</span><br><span> 	ltrc.inc</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SUBD=
IRS =3D msvc</span><br><span>diff --git a/build/msvc/Makefile.am b/build/ms=
vc/Makefile.am</span><br><span>deleted file mode 100644</span><br><span>ind=
ex df3b41f..0000000</span><br><span>--- a/build/msvc/Makefile.am</span><br>=
<span>+++ /dev/null</span><br><span>@@ -1,15 +0,0 @@</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#  OpenVPN -- An application to securely tunnel IP networks</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#             over a sing=
le UDP port, with support for SSL/TLS-based</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#             session authentication and key exchange=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#             packet=
 encryption, packet authentication, and</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#             packet compression.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#  Copyright (C) 2002-2023 OpenVPN Inc &lt;sales@...515...&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2006-=
2012 Alon Bar-Lev &lt;alon.barlev@...277...&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MAINTAINERCLEAN=
FILES =3D \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(srcdir)=
/Makefile.in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-SUBDIRS =3D msvc-generate</spa=
n><br><span>diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/=
msvc-generate/Makefile.am</span><br><span>deleted file mode 100644</span><b=
r><span>index fe13b37..0000000</span><br><span>--- a/build/msvc/msvc-genera=
te/Makefile.am</span><br><span>+++ /dev/null</span><br><span>@@ -1,20 +0,0 =
@@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#  OpenVPN -- An application to securel=
y tunnel IP networks</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
             over a single UDP port, with support for SSL/TLS-based</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#             session authent=
ication and key exchange,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#             packet encryption, packet authentication, and</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#             packet compression.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2002-2023 OpenVPN Inc &l=
t;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#  Copyright (C) 2006-2012 Alon Bar-Lev &lt;alon.barlev@...277...&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-MAINTAINERCLEANFILES =3D \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	$(srcdir)/Makefile.in</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dist_noi=
nst_DATA =3D \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	git-ve=
rsion.py \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	msvc-gener=
ate.vcxproj \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Makefil=
e.mak \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	msvc-generate=
.js \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	version.m4.in</=
span><br><span>diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/m=
svc/msvc-generate/Makefile.mak</span><br><span>deleted file mode 100644</sp=
an><br><span>index 9190742..0000000</span><br><span>--- a/build/msvc/msvc-g=
enerate/Makefile.mak</span><br><span>+++ /dev/null</span><br><span>@@ -1,67=
 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#  OpenVPN -- An application to s=
ecurely tunnel IP networks</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#             over a single UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#             packet encryption, packet authentication, and</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#             packet compre=
ssion.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2002-2023 OpenVPN =
Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#  Copyright (C) 2008-2012 Alon Bar-Lev &lt;alon.barlev@...277...&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2022=
-2022 Lev Stipakov &lt;lev@...2698...&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#  This program is free software; you can redistribute it and/or modify</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#  it under the terms of =
the GNU General Public License version 2</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#  as published by the Free Software Foundation.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#  This program is distributed in the hope that i=
t will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  b=
ut WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#  GNU General Public License for more details.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  with =
this program; if not, write to the Free Software Foundation, Inc.,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#  51 Franklin Street, Fifth F=
loor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-CONFIG=3D$(SOLUTIONDIR)/versio=
n.m4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-INPUT_MSVC_VER=3D$(SOLUTIONDIR)/config=
-msvc-version.h.in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-OUT=
PUT_MSVC_VER=3D$(SOLUTIONDIR)/config-msvc-version.h</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-INPUT_PLUGIN=3D$(SOLUTIONDIR)/include/openvpn-plugin.h.in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-OUTPUT_PLUGIN=3D$(SOLUTIONDI=
R)/include/openvpn-plugin.h</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-INPUT_PLUGIN_CO=
NFIG=3Dversion.m4.in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-O=
UTPUT_PLUGIN_CONFIG=3Dversion.m4</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-INPUT_MAN=
=3D$(SOLUTIONDIR)/doc/openvpn.8.rst</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-OUTPUT_MAN=3D$(SOLUTIONDIR)/doc/openvpn.8.html</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-OUTPUT_MSVC_GIT_CONFIG=3D$(SOLUTIONDIR)/config-version.h<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(=
OUTPUT_MAN) $(OUTPUT_MSVC_GIT_CONFIG)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-$(OUT=
PUT_MSVC_VER): $(INPUT_MSVC_VER) $(CONFIG)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	cscript //nologo msvc-generate.js --config=3D&quot;$(=
CONFIG)&quot; --input=3D&quot;$(INPUT_MSVC_VER)&quot; --output=3D&quot;$(OU=
TPUT_MSVC_VER)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-$(OUTPUT_PLUGIN_CONFIG=
): $(INPUT_PLUGIN_CONFIG)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	cscript //nologo msvc-generate.js --config=3D&quot;$(CONFIG)&quot; --i=
nput=3D&quot;$(INPUT_PLUGIN_CONFIG)&quot; --output=3D&quot;$(OUTPUT_PLUGIN_=
CONFIG)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-$(OUTPUT_PLUGIN): $(INPUT_PLU=
GIN) $(OUTPUT_PLUGIN_CONFIG)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	cscript //nologo msvc-generate.js --config=3D&quot;$(OUTPUT_PLUGIN_=
CONFIG)&quot; --input=3D&quot;$(INPUT_PLUGIN)&quot; --output=3D&quot;$(OUTP=
UT_PLUGIN)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-$(OUTPUT_MAN): $(INPUT_MAN=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-FOR /F %i IN (&#39=
;where rst2html.py&#39;) DO python %i &quot;$(INPUT_MAN)&quot; &quot;$(OUTP=
UT_MAN)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-# Force regeneration because =
we can&#39;t detect whether it is outdated</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-$(OUTPUT_MSVC_GIT_CONFIG): FORCE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	python git-version.py $(SOLUTIONDIR)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-FORCE:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-clean:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	-del &quot;$(OUTPUT_MSV=
C_VER)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-del &qu=
ot;$(OUTPUT_PLUGIN)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	-del &quot;$(OUTPUT_PLUGIN_CONFIG)&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	-del &quot;$(OUTPUT_MAN)&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	-del &quot;$(OUTPUT_MSVC_GIT_CONFIG)&quo=
t;</span><br><span>diff --git a/build/msvc/msvc-generate/git-version.py b/b=
uild/msvc/msvc-generate/git-version.py</span><br><span>deleted file mode 10=
0644</span><br><span>index c2b4452..0000000</span><br><span>--- a/build/msv=
c/msvc-generate/git-version.py</span><br><span>+++ /dev/null</span><br><spa=
n>@@ -1,75 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  OpenVPN -- An applic=
ation to securely tunnel IP networks</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#             over a single UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#             pac=
ket compression.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2022-202=
3 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#  Copyright (C) 2022-2022 Lev Stipakov &lt;lev@...2698...&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#  This program is free software; you =
can redistribute it and/or modify</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#  it under the terms of the GNU General Public License version=
 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  as published by =
the Free Software Foundation.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#  but WITHOUT ANY WARRANTY; without even =
the implied warranty of</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#  GNU General Public License =
for more details.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#  with this program; if not, write to the Fre=
e Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-import os</span><br><span style=3D"color: hsl(0, 100%, 40%);">-impor=
t sys</span><br><span style=3D"color: hsl(0, 100%, 40%);">-import subproces=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-def run_command(args):</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    sp =3D subprocess.Popen(args, stdout=
=3Dsubprocess.PIPE, stderr=3Dsubprocess.DEVNULL)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    o, _ =3D sp.communicate()</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return o.decode(&quot;utf-8&quot;)[:=
-1]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-def get_branch_commit_id():</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    commit_id =3D run_command([&q=
uot;git&quot;, &quot;rev-parse&quot;, &quot;--short=3D16&quot;, &quot;HEAD&=
quot;])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if not com=
mit_id:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        raise<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    branch =3D run_com=
mand([&quot;git&quot;, &quot;describe&quot;, &quot;--exact-match&quot;])</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if not branch:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        # this returns an a=
rray like [&quot;master&quot;] or [&quot;release&quot;, &quot;2.6&quot;]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        branch =3D run_c=
ommand([&quot;git&quot;, &quot;rev-parse&quot;, &quot;--symbolic-full-name&=
quot;, &quot;HEAD&quot;]).split(&quot;/&quot;)[2:]</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if not branch:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            branch =3D [&quot;none&quot;]</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        branch =3D &quo=
t;/&quot; .join(branch) # handle cases like release/2.6</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return branch, commit_id</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-d=
ef main():</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    try:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        branch, commit_i=
d =3D get_branch_commit_id()</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    except:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     branch, commit_id =3D &quot;unknown&quot;, &quot;unknown&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    prev_content =3D &quot;&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    name =3D os.path.join(&quot;%s&quot; %  (sys.argv[1] if=
 len(sys.argv) &gt; 1 else &quot;.&quot;), &quot;config-version.h&quot;)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    try:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        with open(name, &quot;r&quot;=
) as f:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pr=
ev_content =3D f.read()</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    except:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
# file doesn&#39;t exist</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        pass</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    content =3D &quot;#defi=
ne CONFIGURE_GIT_REVISION \&quot;%s/%s\&quot;\n&quot; % (branch, commit_id)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    content +=3D &quo=
t;#define CONFIGURE_GIT_FLAGS \&quot;\&quot;\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if prev_content !=3D content:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        print(&quot;Writing %s&quot; % name)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        with open(name, &quot=
;w&quot;) as f:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      f.write(content)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    else:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pri=
nt(&quot;Content of %s hasn&#39;t changed&quot; % name)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-if __name__ =3D=3D &quot;__main__&quot;:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    main()</span><br><span>diff --git a/bui=
ld/msvc/msvc-generate/msvc-generate.js b/build/msvc/msvc-generate/msvc-gene=
rate.js</span><br><span>deleted file mode 100644</span><br><span>index d956=
4cf..0000000</span><br><span>--- a/build/msvc/msvc-generate/msvc-generate.j=
s</span><br><span>+++ /dev/null</span><br><span>@@ -1,118 +0,0 @@</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * msvc-generate.js  - string transformation</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Copyright (C) 2008-2012 Alon Bar-Lev &lt;al=
on.barlev@...277...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * BSD License</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Red=
istribution and use in source and binary forms, with or without</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * modification, are permitted pr=
ovided that the following conditions are met:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *     o Redistributions of source code must retain the above copyrigh=
t notice,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *       thi=
s list of conditions and the following disclaimer.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *     o Redistributions in binary form must r=
eproduce the above copyright</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *       notice, this list of conditions and the following disclaime=
r in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *       docu=
mentation and/or other materials provided with the distribution.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *     o Neither the name of the=
 Alon Bar-Lev nor the names of its</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *       contributors may be used to endorse or promote produc=
ts derived from</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    =
   this software without specific prior written permission.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AN=
D CONTRIBUTORS &quot;AS IS&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIM=
ITED TO, THE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * IMPLIE=
D WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * ARE DISCLAIMED. IN NO EVE=
NT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, S=
PECIAL, EXEMPLARY, OR</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * SUBSTITUTE GOODS OR SE=
RVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THE=
ORY OF LIABILITY, WHETHER IN</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHE=
RWISE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ARISING IN A=
NY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * POSSIBILITY OF SUCH DAMAGE.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-var For=
Reading =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-var fso=
 =3D new ActiveXObject(&quot;Scripting.FileSystemObject&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-var input =3D &quot;nul&quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-var output =3D &quot;nul=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-var files =3D =
new Array();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-var env =
=3D new Array();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-function initialize() {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	for (var i=3D0;i&lt;WSc=
ript.Arguments.length;i++) {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		var arg =3D WScript.Arguments(i);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-		if (arg.match(/^--input=3D(.*)$/)) {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-			input=3DRegExp.$1;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-		}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-		else if (arg.match(/^--output=3D(.*)$/)) {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-			output=3DRegExp.$1;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-		}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-		else if (arg.match(/^--config=3D(.*)$/)) {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-			files.push(RegExp.$1);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-		}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-		else if (arg.match(/^--var=3D([^=3D]*)=
=3D(.*)$/)) {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			env[R=
egExp.$1] =3D RegExp.$2;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-		}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
function process_config(vars, file) {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	try {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-		var fin =3D fso.OpenTextFile(file, ForReading);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-		while (!fin.AtEndOfStream) {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-			var content =3D fin.ReadLine();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			if (content.match(/^[ \t]*define\(\[(.*)=
\],[ \t]*\[(.*)\]\)[ \t]*/)) {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-				vars[RegExp.$1] =3D RegExp.$2;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-			}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-		}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	catch(e) {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-		throw new Error(1, &quot;Cannot process =
&#39;&quot; + file + &quot;&#39;.&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-function process_file(vars, input, outpu=
t) {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	var fin =3D fso.=
OpenTextFile(input, ForReading);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	var fout =3D fso.CreateTextFile(output);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	var content =3D fin.ReadAll();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	for (var i in vars) {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-		content =3D content.replace(new RegExp(&quot;@&quot=
;+i+&quot;@&quot;, &quot;g&quot;), vars[i]);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fout.Write(conte=
nt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-function build_vars() {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	var vars =3D new Array();</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	for (var f in files) {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-		process_config(vars, files[f]);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	for (var e in env) {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-		vars[e] =3D env[e];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	return vars;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-function main() {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	try {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		initialize();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		var vars =3D build=
_vars();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-		process_file(</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-			vars,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-			input,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-			output</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-		WScript.Quit(0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	catch(e) {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-		WScript.Echo(&quot;ERROR: when procssing &quot; + output + &quot;: &qu=
ot; + e.description);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
		WScript.Quit(1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-main();</span><br><span>diff --git a/build/msvc/msvc-generate/m=
svc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj</span=
><br><span>deleted file mode 100644</span><br><span>index 70d411e..0000000<=
/span><br><span>--- a/build/msvc/msvc-generate/msvc-generate.vcxproj</span>=
<br><span>+++ /dev/null</span><br><span>@@ -1,158 +0,0 @@</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-=EF=BB=BF&lt;?xml version=3D&quot;1.0&q=
uot; encoding=3D&quot;utf-8&quot;?&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-&lt;Project DefaultTargets=3D&quot;Build&quot; ToolsVersio=
n=3D&quot;15.0&quot; xmlns=3D&quot;http://schemas.microsoft.com/developer/m=
sbuild/2003&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  &lt;ItemGroup Label=3D&quot;ProjectConfigurations&quot;&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration Includ=
e=3D&quot;Debug|ARM64&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;ARM64&lt;/=
Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/=
ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &lt;ProjectConfiguration Include=3D&quot;Debug|Win32&quot;&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;=
Debug&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      &lt;Platform&gt;Win32&lt;/Platform&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration Inclu=
de=3D&quot;Debug|x64&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;x64&lt;/Pla=
tform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Pro=
jectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;ProjectConfiguration Include=3D&quot;Release|ARM64&quot;&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;R=
elease&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      &lt;Platform&gt;ARM64&lt;/Platform&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration In=
clude=3D&quot;Release|Win32&quot;&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;Configuration&gt;Release&lt;/Configuration&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;Wi=
n32&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Release|x64&quot;&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configura=
tion&gt;Release&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;Platform&gt;x64&lt;/Platform&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=
=3D&quot;Globals&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;ProjectGuid&gt;{8598C2C8-34C4-47A1-99B0-7C295A890615}&lt;/Proj=
ectGuid&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Ro=
otNamespace&gt;msvc-generate&lt;/RootNamespace&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;Keyword&gt;MakeFileProj&lt;/Keyword&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;WindowsTarge=
tPlatformVersion&gt;10.0&lt;/WindowsTargetPlatformVersion&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&quot;$(V=
CTargetsPath)\Microsoft.Cpp.Default.props&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;=
$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=
=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ConfigurationType&gt;Makefile&lt;/ConfigurationType&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolse=
t&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configurati=
on&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;C=
onfigurationType&gt;Makefile&lt;/ConfigurationType&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/Platfo=
rmToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/P=
ropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt=
;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&=
gt;Makefile&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Co=
ndition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win3=
2&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Makefile&lt;/Conf=
igurationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#=
39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=
=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ConfigurationType&gt;Makefile&lt;/ConfigurationType&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolse=
t&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configurati=
on&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;C=
onfigurationType&gt;Makefile&lt;/ConfigurationType&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/Platfo=
rmToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/P=
ropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt=
;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.props&quot; /&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=
=3D&quot;ExtensionSettings&quot;&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$=
(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;PropertySh=
eets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platfor=
m).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=
=3D&quot;..\..\..\src\compat\PropertySheet.props&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot=
;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; La=
bel=3D&quot;PropertySheets&quot;&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.=
$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\M=
icrosoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataP=
latform&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;Import Project=3D&quot;..\..\..\src\compat\PropertySheet.props&quot; =
/&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGro=
up&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGro=
up Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Relea=
se|ARM64&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserR=
ootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists=
(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=
=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\..\..\src\compat\Prop=
ertySheet.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform=
)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;PropertySheets&quot;&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Pro=
ject=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Cond=
ition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\.=
.\..\src\compat\PropertySheet.props&quot; /&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Confi=
guration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Pro=
pertySheets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).use=
r.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(=
Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Pr=
oject=3D&quot;..\..\..\src\compat\PropertySheet.props&quot; /&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D=
&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quo=
t; Label=3D&quot;PropertySheets&quot;&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft=
.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootD=
ir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalApp=
DataPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &lt;Import Project=3D&quot;..\..\..\src\compat\PropertySheet.props&q=
uot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Impo=
rtGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Prop=
ertyGroup Label=3D&quot;UserMacros&quot; /&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  &lt;PropertyGroup&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;_ProjectFileVersion&gt;10.0.30319.1&lt;/=
_ProjectFileVersion&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(Configuration)\&lt;/OutDir&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;IntDir Condition=3D=
&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quo=
t;&gt;$(Configuration)\&lt;/IntDir&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;NMakeBuildCommandLine Condition=3D&quot;&#39;$(Con=
figuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;nmake -f M=
akefile.mak all&lt;/NMakeBuildCommandLine&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;NMakeBuildCommandLine Condition=3D&quot;&#3=
9;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;nmake=
 -f Makefile.mak all&lt;/NMakeBuildCommandLine&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;NMakeBuildCommandLine Condition=3D&quo=
t;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&g=
t;nmake -f Makefile.mak all&lt;/NMakeBuildCommandLine&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeReBuildCommandLine Conditi=
on=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39=
;&quot;&gt;nmake -f Makefile.mak clean all&lt;/NMakeReBuildCommandLine&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeReBuildCo=
mmandLine Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#3=
9;Debug|x64&#39;&quot;&gt;nmake -f Makefile.mak clean all&lt;/NMakeReBuildC=
ommandLine&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;NMakeReBuildCommandLine Condition=3D&quot;&#39;$(Configuration)|$(Platform=
)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;nmake -f Makefile.mak clean all&=
lt;/NMakeReBuildCommandLine&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &lt;NMakeCleanCommandLine Condition=3D&quot;&#39;$(Configurat=
ion)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;nmake -f Makefile=
.mak clean&lt;/NMakeCleanCommandLine&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &lt;NMakeCleanCommandLine Condition=3D&quot;&#39;$(C=
onfiguration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;nmake -f M=
akefile.mak clean&lt;/NMakeCleanCommandLine&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;NMakeCleanCommandLine Condition=3D&quot;&=
#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;n=
make -f Makefile.mak clean&lt;/NMakeCleanCommandLine&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeOutput Condition=3D&quot;&#=
39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;co=
nfig-msvc-version.h&lt;/NMakeOutput&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;NMakeOutput Condition=3D&quot;&#39;$(Configuratio=
n)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;config-msvc-version.h=
&lt;/NMakeOutput&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;NMakeOutput Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;config-msvc-version.h&lt;/NMakeOutput&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakePrepr=
ocessorDefinitions Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Debug|Win32&#39;&quot;&gt;WIN32;_DEBUG;$(NMakePreprocessorDefini=
tions)&lt;/NMakePreprocessorDefinitions&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;NMakePreprocessorDefinitions Condition=3D&quo=
t;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;=
WIN32;_DEBUG;$(NMakePreprocessorDefinitions)&lt;/NMakePreprocessorDefinitio=
ns&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakePr=
eprocessorDefinitions Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#=
39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;WIN32;_DEBUG;$(NMakePreprocessorDef=
initions)&lt;/NMakePreprocessorDefinitions&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;NMakeIncludeSearchPath Condition=3D&quot;&=
#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$=
(NMakeIncludeSearchPath)&lt;/NMakeIncludeSearchPath&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeIncludeSearchPath Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&qu=
ot;&gt;$(NMakeIncludeSearchPath)&lt;/NMakeIncludeSearchPath&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeIncludeSearchPath Co=
ndition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM6=
4&#39;&quot;&gt;$(NMakeIncludeSearchPath)&lt;/NMakeIncludeSearchPath&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeForcedInclu=
des Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debu=
g|Win32&#39;&quot;&gt;$(NMakeForcedIncludes)&lt;/NMakeForcedIncludes&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeForcedInclu=
des Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debu=
g|x64&#39;&quot;&gt;$(NMakeForcedIncludes)&lt;/NMakeForcedIncludes&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeForcedInclude=
s Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|=
ARM64&#39;&quot;&gt;$(NMakeForcedIncludes)&lt;/NMakeForcedIncludes&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeAssemblySearc=
hPath Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;De=
bug|Win32&#39;&quot;&gt;$(NMakeAssemblySearchPath)&lt;/NMakeAssemblySearchP=
ath&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeA=
ssemblySearchPath Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Debug|x64&#39;&quot;&gt;$(NMakeAssemblySearchPath)&lt;/NMakeAsse=
mblySearchPath&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;NMakeAssemblySearchPath Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;$(NMakeAssemblySearchPath)&l=
t;/NMakeAssemblySearchPath&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;NMakeForcedUsingAssemblies Condition=3D&quot;&#39;$(Config=
uration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(NMakeForced=
UsingAssemblies)&lt;/NMakeForcedUsingAssemblies&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeForcedUsingAssemblies Conditio=
n=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&q=
uot;&gt;$(NMakeForcedUsingAssemblies)&lt;/NMakeForcedUsingAssemblies&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeForcedUsing=
Assemblies Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#=
39;Debug|ARM64&#39;&quot;&gt;$(NMakeForcedUsingAssemblies)&lt;/NMakeForcedU=
singAssemblies&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&=
#39;Release|Win32&#39;&quot;&gt;$(Configuration)\&lt;/OutDir&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;IntDir Condition=3D&quot=
;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&=
gt;$(Configuration)\&lt;/IntDir&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;NMakeBuildCommandLine Condition=3D&quot;&#39;$(Config=
uration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;nmake -f Ma=
kefile.mak all&lt;/NMakeBuildCommandLine&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;NMakeBuildCommandLine Condition=3D&quot;&#39=
;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;nmak=
e -f Makefile.mak all&lt;/NMakeBuildCommandLine&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeBuildCommandLine Condition=3D&=
quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&qu=
ot;&gt;nmake -f Makefile.mak all&lt;/NMakeBuildCommandLine&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeReBuildCommandLine Co=
ndition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Wi=
n32&#39;&quot;&gt;nmake -f Makefile.mak clean all&lt;/NMakeReBuildCommandLi=
ne&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeRe=
BuildCommandLine Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Release|x64&#39;&quot;&gt;nmake -f Makefile.mak clean all&lt;/NM=
akeReBuildCommandLine&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;NMakeReBuildCommandLine Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;nmake -f Makefile.m=
ak clean all&lt;/NMakeReBuildCommandLine&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;NMakeCleanCommandLine Condition=3D&quot;&#39=
;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;nm=
ake -f Makefile.mak clean&lt;/NMakeCleanCommandLine&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeCleanCommandLine Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&=
quot;&gt;nmake -f Makefile.mak clean&lt;/NMakeCleanCommandLine&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeCleanCommandLine =
Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|=
ARM64&#39;&quot;&gt;nmake -f Makefile.mak clean&lt;/NMakeCleanCommandLine&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeOutput=
 Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release=
|Win32&#39;&quot;&gt;config-msvc-version.h&lt;/NMakeOutput&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeOutput Condition=3D&q=
uot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;=
&gt;config-msvc-version.h&lt;/NMakeOutput&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;NMakeOutput Condition=3D&quot;&#39;$(Config=
uration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;config-msvc=
-version.h&lt;/NMakeOutput&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;NMakePreprocessorDefinitions Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;WIN32;NDE=
BUG;$(NMakePreprocessorDefinitions)&lt;/NMakePreprocessorDefinitions&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakePreprocesso=
rDefinitions Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D=
&#39;Release|x64&#39;&quot;&gt;WIN32;NDEBUG;$(NMakePreprocessorDefinitions)=
&lt;/NMakePreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;NMakePreprocessorDefinitions Condition=3D&quot;&#39=
;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;WI=
N32;NDEBUG;$(NMakePreprocessorDefinitions)&lt;/NMakePreprocessorDefinitions=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeIncl=
udeSearchPath Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Release|Win32&#39;&quot;&gt;$(NMakeIncludeSearchPath)&lt;/NMakeIncl=
udeSearchPath&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;NMakeIncludeSearchPath Condition=3D&quot;&#39;$(Configuration)|$(Platfo=
rm)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;$(NMakeIncludeSearchPath)&lt;/=
NMakeIncludeSearchPath&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;NMakeIncludeSearchPath Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;$(NMakeIncludeSearc=
hPath)&lt;/NMakeIncludeSearchPath&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;NMakeForcedIncludes Condition=3D&quot;&#39;$(Config=
uration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(NMakeForc=
edIncludes)&lt;/NMakeForcedIncludes&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;NMakeForcedIncludes Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;$(NMakeForc=
edIncludes)&lt;/NMakeForcedIncludes&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;NMakeForcedIncludes Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;$(NMakeFo=
rcedIncludes)&lt;/NMakeForcedIncludes&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;NMakeAssemblySearchPath Condition=3D&quot;&#39;=
$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(N=
MakeAssemblySearchPath)&lt;/NMakeAssemblySearchPath&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeAssemblySearchPath Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&=
quot;&gt;$(NMakeAssemblySearchPath)&lt;/NMakeAssemblySearchPath&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeAssemblySearchPa=
th Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Relea=
se|ARM64&#39;&quot;&gt;$(NMakeAssemblySearchPath)&lt;/NMakeAssemblySearchPa=
th&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;NMakeFo=
rcedUsingAssemblies Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39=
;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(NMakeForcedUsingAssemblies)&lt;/N=
MakeForcedUsingAssemblies&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;NMakeForcedUsingAssemblies Condition=3D&quot;&#39;$(Configu=
ration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;$(NMakeForcedU=
singAssemblies)&lt;/NMakeForcedUsingAssemblies&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;NMakeForcedUsingAssemblies Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39=
;&quot;&gt;$(NMakeForcedUsingAssemblies)&lt;/NMakeForcedUsingAssemblies&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefiniti=
onGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Ite=
mDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;None Include=3D&quot;Makefile.mak&quot; /&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;None Include=3D&quot;msvc-generate.js&=
quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Ite=
mGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Impor=
t Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targets&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&q=
uot;ExtensionTargets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-&lt;/Project&gt;</span><br><span>\ No newline at end of file</spa=
n><br><span>diff --git a/build/msvc/msvc-generate/version.m4.in b/build/msv=
c/msvc-generate/version.m4.in</span><br><span>deleted file mode 100644</spa=
n><br><span>index cbb4fef..0000000</span><br><span>--- a/build/msvc/msvc-ge=
nerate/version.m4.in</span><br><span>+++ /dev/null</span><br><span>@@ -1,3 =
+0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-define([OPENVP=
N_VERSION_MAJOR], [@PRODUCT_VERSION_MAJOR@])</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-define([OPENVPN_VERSION_MINOR], [@PRODUCT_VERSION_MI=
NOR@])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-define([OPENVPN=
_VERSION_PATCH], [@PRODUCT_VERSION_PATCH@])</span><br><span>diff --git a/co=
nfig-msvc-version.h.in b/config-msvc-version.h.in</span><br><span>deleted f=
ile mode 100644</span><br><span>index 59ca654..0000000</span><br><span>--- =
a/config-msvc-version.h.in</span><br><span>+++ /dev/null</span><br><span>@@=
 -1,14 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 PACKAGE_NAME &quot;@PRODUCT_NAME@&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define PACKAGE_STRING &quot;@PRODUCT_NAME@ @PRODUCT_VER=
SION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PACKAGE_TARNAME =
&quot;@PRODUCT_TARNAME@&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define PACKAGE &quot;@PRODUCT_TARNAME@&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define PRODUCT_VERSION_MAJOR &quot;@PRODUC=
T_VERSION_MAJOR@&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define PRODUCT_VERSION_MINOR &quot;@PRODUCT_VERSION_MINOR@&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define PRODUCT_VERSION_PATCH =
&quot;@PRODUCT_VERSION_PATCH@&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define PACKAGE_VERSION &quot;@PRODUCT_VERSION_MAJOR@...2741...=
.@...2742...@@PRODUCT_VERSION_PATCH@&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define PRODUCT_VERSION &quot;@PRODUCT_VERS=
ION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PRODUCT_BUGREPORT=
 &quot;@PRODUCT_BUGREPORT@&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TAP_WIN_COMPONENT_=
ID &quot;@PRODUCT_TAP_WIN_COMPONENT_ID@&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define TAP_WIN_MIN_MAJOR @PRODUCT_TAP_WIN_MIN_MAJO=
R@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TAP_WIN_MIN=
_MINOR @PRODUCT_TAP_WIN_MIN_MINOR@</span><br><span>diff --git a/config-msvc=
.h b/config-msvc.h</span><br><span>deleted file mode 100644</span><br><span=
>index a3c687e..0000000</span><br><span>--- a/config-msvc.h</span><br><span=
>+++ /dev/null</span><br><span>@@ -1,93 +0,0 @@</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#include &lt;config-msvc-version.h&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define CONFIGURE_DEFINES &quot;N/A&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define ENABLE_PF 1</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define ENABLE_CRYPTO_OPENSSL 1</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define ENABLE_FRAGMENT 1</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_HTTP_PROXY 1</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_LZO 1</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_LZ4 1</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_MANAGEMENT 1</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_PKCS11 1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_PLUGIN 1</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_PORT_SHARE 1<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_SOCKS 1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define HAVE_FCNTL_H 1</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define HAVE_STDIO_H 1</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define HAVE_STDLIB_H 1</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_STRERROR 1</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_STRINGS_H 1</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_STRING_H 1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_LIMITS_H 1</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_SYSTEM 1</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_TIME 1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_TIME_H 1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_WINDOWS_H 1</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_WINSOCK2_H 1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_WS2TCPIP_H =
1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_IO_H 1<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_SYS_TYPES=
_H 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_SYS_=
STAT_H 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_=
LZO_LZO1X_H 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
HAVE_LZO_LZOUTIL_H 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define HAVE_VERSIONHELPERS_H 1</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE=
_ACCESS 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE=
_CHDIR 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_=
CHSIZE 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_=
IN_PKTINFO 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_OPENSSL_ENGINE 1<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_EXPORT_KE=
YING_MATERIAL 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_DIINSTALLDEVIC=
E 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifndef __cplusplus</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define inline __inline</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define TARGET_WIN32 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define TARGET_ALIAS &quot;Windows-MSVC&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define HAVE_DECL_SO_MARK 0</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define str=
ncasecmp strnicmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine strcasecmp _stricmp</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if _MSC_VER&lt;190=
0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define snprintf _sn=
printf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if _MSC_VER &lt; 1800</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define strtoull strtoul</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
in_addr_t uint32_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine ssize_t SSIZE_T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define S_IRUSR _S_IRE=
AD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define S_IWUSR _S_=
IWRITE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define S_IRGRP=
 (S_IRUSR &gt;&gt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define R_OK 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 W_OK 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define X_OK 1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define F_OK 0</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define SIGHUP    1</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define SIGINT    2</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define SIGUSR1   10</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define SIGUSR2   12</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define SIGTERM   15</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &lt;inttypes.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-typedef uint16_t in_port_t;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE=
_CONFIG_MSVC_LOCAL_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
include &lt;config-msvc-local.h&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_DCO 1</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define HAVE_CONFIG_VERSION_H 1</span><br><=
span>diff --git a/configure.ac b/configure.ac</span><br><span>index 67f680b=
..7313308 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/c=
onfigure.ac</span><br><span>@@ -1492,8 +1492,6 @@</span><br><span> 	version=
.sh</span><br><span> 	Makefile</span><br><span> 	build/Makefile</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	build/msvc/Makefile</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	build/msvc/msvc-generate/Makefile=
</span><br><span> 	distro/Makefile</span><br><span> 	distro/systemd/Makefil=
e</span><br><span> 	doc/Makefile</span><br><span>diff --git a/openvpn.sln b=
/openvpn.sln</span><br><span>deleted file mode 100644</span><br><span>index=
 3485bc9..0000000</span><br><span>--- a/openvpn.sln</span><br><span>+++ /de=
v/null</span><br><span>@@ -1,107 +0,0 @@</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-=EF=BB=BF</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-Microsoft Visual Studio Solution File, Format Version 12.00</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# Visual Studio Version 16</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-VisualStudioVersion =3D 1=
6.0.31205.134</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MinimumV=
isualStudioVersion =3D 10.0.40219.1</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-Project(&quot;{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}&quot;) =
=3D &quot;openvpnserv&quot;, &quot;src\openvpnserv\openvpnserv.vcxproj&quot=
;, &quot;{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-EndProject</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-Project(&quot;{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}&q=
uot;) =3D &quot;openvpn&quot;, &quot;src\openvpn\openvpn.vcxproj&quot;, &qu=
ot;{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-EndProject</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-Project(&quot;{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}&quot;) =
=3D &quot;msvc-generate&quot;, &quot;build\msvc\msvc-generate\msvc-generate=
.vcxproj&quot;, &quot;{8598C2C8-34C4-47A1-99B0-7C295A890615}&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-EndProject</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-Project(&quot;{8BC9CEB8-8B4A-11D0-8D11-00=
A0C91BC942}&quot;) =3D &quot;compat&quot;, &quot;src\compat\compat.vcxproj&=
quot;, &quot;{4B2E2719-E661-45D7-9203-F6F456B22F19}&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-EndProject</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-Project(&quot;{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC94=
2}&quot;) =3D &quot;tapctl&quot;, &quot;src\tapctl\tapctl.vcxproj&quot;, &q=
uot;{A06436E7-D576-490D-8BA0-0751D920334A}&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-EndProject</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-Project(&quot;{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}&quot;)=
 =3D &quot;openvpnmsica&quot;, &quot;src\openvpnmsica\openvpnmsica.vcxproj&=
quot;, &quot;{D41AA9D6-B818-476E-992E-0E16EB86BEE2}&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-EndProject</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-Global</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	GlobalSection(SolutionConfigurationPlatforms) =3D preSolution</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-		Debug|ARM64 =3D Debug|=
ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		Debug|Win32 =
=3D Debug|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		Debu=
g|x64 =3D Debug|x64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		=
Release|ARM64 =3D Release|ARM64</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-		Release|Win32 =3D Release|Win32</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-		Release|x64 =3D Release|x64</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	EndGlobalSection</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	GlobalSection(ProjectConfigurationPlatforms) =
=3D postSolution</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{9C=
91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|ARM64.ActiveCfg =3D Debug|ARM64</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{9C91EE0B-817D-420A-A=
1E6-15A5A9D98BAD}.Debug|ARM64.Build.0 =3D Debug|ARM64</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.De=
bug|Win32.ActiveCfg =3D Debug|Win32</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.0 =
=3D Debug|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{9C9=
1EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.ActiveCfg =3D Debug|x64</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-		{9C91EE0B-817D-420A-A1E6-1=
5A5A9D98BAD}.Debug|x64.Build.0 =3D Debug|x64</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM=
64.ActiveCfg =3D Release|ARM64</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM64.Build.0 =3D=
 Release|ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{9C91=
EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg =3D Release|Win32=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{9C91EE0B-817D-420A=
-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 =3D Release|Win32</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-		{9C91EE0B-817D-420A-A1E6-15A5A9D98B=
AD}.Release|x64.ActiveCfg =3D Release|x64</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.Bu=
ild.0 =3D Release|x64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|ARM64.ActiveCfg =3D Debug|AR=
M64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{29DF226E-4D4E-4=
40F-ADAF-5829CFD4CA94}.Debug|ARM64.Build.0 =3D Debug|ARM64</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA9=
4}.Debug|Win32.ActiveCfg =3D Debug|Win32</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Bui=
ld.0 =3D Debug|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
	{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.ActiveCfg =3D Debug|x64</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{29DF226E-4D4E-440F-A=
DAF-5829CFD4CA94}.Debug|x64.Build.0 =3D Debug|x64</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Releas=
e|ARM64.ActiveCfg =3D Release|ARM64</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|ARM64.Build.=
0 =3D Release|ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		=
{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg =3D Release|=
Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{29DF226E-4D4E=
-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 =3D Release|Win32</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		{29DF226E-4D4E-440F-ADAF-5829C=
FD4CA94}.Release|x64.ActiveCfg =3D Release|x64</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x=
64.Build.0 =3D Release|x64</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|ARM64.ActiveCfg =3D Deb=
ug|ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{8598C2C8-3=
4C4-47A1-99B0-7C295A890615}.Debug|ARM64.Build.0 =3D Debug|ARM64</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-		{8598C2C8-34C4-47A1-99B0-7C295A=
890615}.Debug|Win32.ActiveCfg =3D Debug|Win32</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win3=
2.Build.0 =3D Debug|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.ActiveCfg =3D Debug|=
x64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{8598C2C8-34C4-4=
7A1-99B0-7C295A890615}.Debug|x64.Build.0 =3D Debug|x64</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.R=
elease|ARM64.ActiveCfg =3D Release|ARM64</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|ARM64.B=
uild.0 =3D Release|ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg =3D Rel=
ease|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{8598C2C8=
-34C4-47A1-99B0-7C295A890615}.Release|Win32.Build.0 =3D Release|Win32</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-		{8598C2C8-34C4-47A1-99B0-=
7C295A890615}.Release|x64.ActiveCfg =3D Release|x64</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Re=
lease|x64.Build.0 =3D Release|x64</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.ActiveCfg =
=3D Debug|ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{4B2=
E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.Build.0 =3D Debug|ARM64</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-		{4B2E2719-E661-45D7-9203=
-F6F456B22F19}.Debug|Win32.ActiveCfg =3D Debug|Win32</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.De=
bug|Win32.Build.0 =3D Debug|Win32</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.ActiveCfg =
=3D Debug|x64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{4B2E2=
719-E661-45D7-9203-F6F456B22F19}.Debug|x64.Build.0 =3D Debug|x64</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		{4B2E2719-E661-45D7-9203-F6F45=
6B22F19}.Release|ARM64.ActiveCfg =3D Release|ARM64</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Relea=
se|ARM64.Build.0 =3D Release|ARM64</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.ActiveC=
fg =3D Release|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
	{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 =3D Release|W=
in32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{4B2E2719-E661-=
45D7-9203-F6F456B22F19}.Release|x64.ActiveCfg =3D Release|x64</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-		{4B2E2719-E661-45D7-9203-F6F456B2=
2F19}.Release|x64.Build.0 =3D Release|x64</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.Ac=
tiveCfg =3D Debug|ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.Build.0 =3D Debug|AR=
M64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{A06436E7-D576-4=
90D-8BA0-0751D920334A}.Debug|Win32.ActiveCfg =3D Debug|Win32</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-		{A06436E7-D576-490D-8BA0-0751D9203=
34A}.Debug|Win32.Build.0 =3D Debug|Win32</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.Activ=
eCfg =3D Debug|x64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{=
A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.Build.0 =3D Debug|x64</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-		{A06436E7-D576-490D-8BA0-=
0751D920334A}.Release|ARM64.ActiveCfg =3D Release|ARM64</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-		{A06436E7-D576-490D-8BA0-0751D920334A}.=
Release|ARM64.Build.0 =3D Release|ARM64</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.Ac=
tiveCfg =3D Release|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.Build.0 =3D Rele=
ase|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{A06436E7-=
D576-490D-8BA0-0751D920334A}.Release|x64.ActiveCfg =3D Release|x64</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-		{A06436E7-D576-490D-8BA0-075=
1D920334A}.Release|x64.Build.0 =3D Release|x64</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM=
64.ActiveCfg =3D Debug|ARM64</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM64.Build.0 =3D Deb=
ug|ARM64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{D41AA9D6-B=
818-476E-992E-0E16EB86BEE2}.Debug|Win32.ActiveCfg =3D Debug|Win32</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-		{D41AA9D6-B818-476E-992E-0E16=
EB86BEE2}.Debug|Win32.Build.0 =3D Debug|Win32</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.=
ActiveCfg =3D Debug|x64</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.Build.0 =3D Debug|x64<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{D41AA9D6-B818-476E-=
992E-0E16EB86BEE2}.Release|ARM64.ActiveCfg =3D Release|ARM64</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-		{D41AA9D6-B818-476E-992E-0E16EB86B=
EE2}.Release|ARM64.Build.0 =3D Release|ARM64</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win=
32.ActiveCfg =3D Release|Win32</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.Build.0 =3D=
 Release|Win32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		{D41A=
A9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.ActiveCfg =3D Release|x64</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-		{D41AA9D6-B818-476E-992=
E-0E16EB86BEE2}.Release|x64.Build.0 =3D Release|x64</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	EndGlobalSection</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	GlobalSection(SolutionProperties) =3D preSolut=
ion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		HideSolutionNode=
 =3D FALSE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	EndGlobalS=
ection</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	GlobalSection(=
ExtensibilityGlobals) =3D postSolution</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-		SolutionGuid =3D {EB3CE5D3-415C-46F0-96AB-E1CDA287AB6D}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	EndGlobalSection</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-EndGlobal</span><br><span>=
diff --git a/src/compat/Debug.props b/src/compat/Debug.props</span><br><spa=
n>deleted file mode 100644</span><br><span>index 31bb9d9..0000000</span><br=
><span>--- a/src/compat/Debug.props</span><br><span>+++ /dev/null</span><br=
><span>@@ -1,21 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;Project ToolsVersion=
=3D&quot;4.0&quot; xmlns=3D&quot;http://schemas.microsoft.com/developer/msb=
uild/2003&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;ImportGroup Label=3D&quot;PropertySheets&quot;&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;PropertyShe=
et.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  &lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;_PropertySheetDisplayName&gt;c=
ompat-Debug&lt;/_PropertySheetDisplayName&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;LinkIncremental&gt;true&lt;/LinkIncremental=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGr=
oup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefi=
nitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
&lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicRuntimeChecks&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Optimization&gt;D=
isabled&lt;/Optimization&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      &lt;PreprocessorDefinitions&gt;_DEBUG;%(PreprocessorDefinition=
s)&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/RuntimeL=
ibrary&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;D=
ebugInformationFormat&gt;EditAndContinue&lt;/DebugInformationFormat&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGro=
up&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup=
 /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&gt=
;</span><br><span>\ No newline at end of file</span><br><span>diff --git a/=
src/compat/Makefile.am b/src/compat/Makefile.am</span><br><span>index a42ec=
39..f5de451 100644</span><br><span>--- a/src/compat/Makefile.am</span><br><=
span>+++ b/src/compat/Makefile.am</span><br><span>@@ -12,12 +12,6 @@</span>=
<br><span> MAINTAINERCLEANFILES =3D \</span><br><span> 	$(srcdir)/Makefile.=
in</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-E=
XTRA_DIST =3D \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	compa=
t.vcxproj \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	PropertyS=
heet.props \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Debug.pr=
ops \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Release.props</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> noins=
t_LTLIBRARIES =3D libcompat.la</span><br><span> </span><br><span> libcompat=
_la_SOURCES =3D \</span><br><span>diff --git a/src/compat/PropertySheet.pro=
ps b/src/compat/PropertySheet.props</span><br><span>deleted file mode 10064=
4</span><br><span>index 57f6995..0000000</span><br><span>--- a/src/compat/P=
ropertySheet.props</span><br><span>+++ /dev/null</span><br><span>@@ -1,29 +=
0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;?xml versio=
n=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-&lt;Project ToolsVersion=3D&quot;4.0&quot; =
xmlns=3D&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Lab=
el=3D&quot;PropertySheets&quot; /&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;OutDir&gt;$(So=
lutionDir)$(Platform)-Output\$(Configuration)\&lt;/OutDir&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;_PropertySheetDisplayName&g=
t;compat&lt;/_PropertySheetDisplayName&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;WarningLevel&gt;Level3&lt;/Warnin=
gLevel&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;P=
reprocessorDefinitions&gt;WIN32;$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/=
PreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      &lt;AdditionalIncludeDirectories&gt;$(SolutionDir);$(SolutionDi=
r)include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;GenerateDebu=
gInformation&gt;true&lt;/GenerateDebugInformation&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;ResourceCompile /&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;ResourceCompile&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirect=
ories&gt;$(SOLUTIONDIR)&lt;/AdditionalIncludeDirectories&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ResourceCompile&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;BuildMacro Inc=
lude=3D&quot;SOLUTIONDIR&quot;&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;Value&gt;$(SOLUTIONDIR)&lt;/Value&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      &lt;EnvironmentVariable&gt;tru=
e&lt;/EnvironmentVariable&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;/BuildMacro&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-&lt;/Project&gt;</span><br><span>\ No newline at end of file</span=
><br><span>diff --git a/src/compat/Release.props b/src/compat/Release.props=
</span><br><span>deleted file mode 100644</span><br><span>index 50eaa8d..00=
00000</span><br><span>--- a/src/compat/Release.props</span><br><span>+++ /d=
ev/null</span><br><span>@@ -1,26 +0,0 @@</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;utf-=
8&quot;?&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;Proje=
ct ToolsVersion=3D&quot;4.0&quot; xmlns=3D&quot;http://schemas.microsoft.co=
m/developer/msbuild/2003&quot;&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quot;&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&q=
uot;PropertySheet.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;_PropertySheetD=
isplayName&gt;compat-Release&lt;/_PropertySheetDisplayName&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;LinkIncremental&gt;false&l=
t;/LinkIncremental&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &lt;ItemDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;FunctionLev=
elLinking&gt;true&lt;/FunctionLevelLinking&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/R=
untimeLibrary&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/DebugInformationFormat&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Preproce=
ssorDefinitions&gt;NDEBUG;%(PreprocessorDefinitions)&lt;/PreprocessorDefini=
tions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Co=
ntrolFlowGuard&gt;Guard&lt;/ControlFlowGuard&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      &lt;EnableCOMDATFolding&gt;true&lt;/EnableCOMD=
ATFolding&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &l=
t;OptimizeReferences&gt;true&lt;/OptimizeReferences&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup /&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&gt;</span><br><span>\=
 No newline at end of file</span><br><span>diff --git a/src/compat/compat-b=
asename.c b/src/compat/compat-basename.c</span><br><span>index e66e225..abb=
4f49 100644</span><br><span>--- a/src/compat/compat-basename.c</span><br><s=
pan>+++ b/src/compat/compat-basename.c</span><br><span>@@ -23,8 +23,6 @@</s=
pan><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #inc=
lude &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><br>=
<span> </span><br><span> #ifndef HAVE_BASENAME</span><br><span>diff --git a=
/src/compat/compat-daemon.c b/src/compat/compat-daemon.c</span><br><span>in=
dex 460b9e9..aebb8f4 100644</span><br><span>--- a/src/compat/compat-daemon.=
c</span><br><span>+++ b/src/compat/compat-daemon.c</span><br><span>@@ -23,8=
 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br=
><span> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endi=
f</span><br><span> </span><br><span> #ifndef HAVE_DAEMON</span><br><span>di=
ff --git a/src/compat/compat-dirname.c b/src/compat/compat-dirname.c</span>=
<br><span>index c1523d9..c131dee 100644</span><br><span>--- a/src/compat/co=
mpat-dirname.c</span><br><span>+++ b/src/compat/compat-dirname.c</span><br>=
<span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONF=
IG_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> </span><br><span>diff =
--git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c=
</span><br><span>index 0dc7460..69843fb 100644</span><br><span>--- a/src/co=
mpat/compat-gettimeofday.c</span><br><span>+++ b/src/compat/compat-gettimeo=
fday.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span>=
 #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc=
.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #ifndef=
 HAVE_GETTIMEOFDAY</span><br><span>diff --git a/src/compat/compat-strsep.c =
b/src/compat/compat-strsep.c</span><br><span>index 6db013f..fbad98d 100644<=
/span><br><span>--- a/src/compat/compat-strsep.c</span><br><span>+++ b/src/=
compat/compat-strsep.c</span><br><span>@@ -24,8 +24,6 @@</span><br><span> <=
/span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;confi=
g.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif define=
d(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><b=
r><span> #ifndef HAVE_STRSEP</span><br><span>diff --git a/src/compat/compat=
.vcxproj b/src/compat/compat.vcxproj</span><br><span>deleted file mode 1006=
44</span><br><span>index 9fcfd6c..0000000</span><br><span>--- a/src/compat/=
compat.vcxproj</span><br><span>+++ /dev/null</span><br><span>@@ -1,179 +0,0=
 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=EF=BB=BF&lt;?xml =
version=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-&lt;Project DefaultTargets=3D&quot;Bu=
ild&quot; ToolsVersion=3D&quot;15.0&quot; xmlns=3D&quot;http://schemas.micr=
osoft.com/developer/msbuild/2003&quot;&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;ItemGroup Label=3D&quot;ProjectConfigurations&qu=
ot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Projec=
tConfiguration Include=3D&quot;Debug|ARM64&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Config=
uration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;=
Platform&gt;ARM64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Debug=
|Win32&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 &lt;Configuration&gt;Debug&lt;/Configuration&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;Win32&lt;/Platform&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfigur=
ation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Proj=
ectConfiguration Include=3D&quot;Debug|x64&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Config=
uration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;=
Platform&gt;x64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Release=
|ARM64&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 &lt;Configuration&gt;Release&lt;/Configuration&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;ARM64&lt;/Platform&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConf=
iguration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;=
ProjectConfiguration Include=3D&quot;Release|Win32&quot;&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Release&l=
t;/Configuration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     &lt;Platform&gt;Win32&lt;/Platform&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&q=
uot;Release|x64&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      &lt;Configuration&gt;Release&lt;/Configuration&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;x64&lt;/Platfo=
rm&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Projec=
tConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &l=
t;PropertyGroup Label=3D&quot;Globals&quot;&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;ProjectGuid&gt;{4B2E2719-E661-45D7-9203-F=
6F456B22F19}&lt;/ProjectGuid&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;RootNamespace&gt;compat&lt;/RootNamespace&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Keyword&gt;Win32Proj&lt;=
/Keyword&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;W=
indowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPlatformVersion&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=
=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Default.props&quot; /&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39=
;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;StaticLibrary&lt;/Conf=
igurationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt;true&lt;/W=
holeProgramOptimization&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectr=
e&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Configu=
rationType&gt;StaticLibrary&lt;/ConfigurationType&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;MultiByte&lt;/Chara=
cterSet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Wh=
oleProgramOptimization&gt;true&lt;/WholeProgramOptimization&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&l=
t;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39=
;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;StaticLibrary&lt;/Conf=
igurationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt;true&lt;/W=
holeProgramOptimization&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectr=
e&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Configu=
rationType&gt;StaticLibrary&lt;/ConfigurationType&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;MultiByte&lt;/Chara=
cterSet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Pl=
atformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMit=
igation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Pro=
pertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;P=
ropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D=
&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Stat=
icLibrary&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v=
143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condi=
tion=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#=
39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;StaticLibrary&lt;/Co=
nfigurationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/Platfor=
mToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;S=
pectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&quot;$(VCTargets=
Path)\Microsoft.Cpp.props&quot; /&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Co=
ndition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Wi=
n32&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDi=
r)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39=
;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&q=
uot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;Import Project=3D&quot;Release.props&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condit=
ion=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#3=
9;&quot; Label=3D&quot;PropertySheets&quot;&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Mic=
rosoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(Use=
rRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;Lo=
calAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;Import Project=3D&quot;Release.props&quot; /&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D=
&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&q=
uot; Label=3D&quot;PropertySheets&quot;&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Microso=
ft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRoo=
tDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalA=
ppDataPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;Import Project=3D&quot;Release.props&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quo=
t;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; L=
abel=3D&quot;PropertySheets&quot;&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;Import Project=3D&quot;Debug.props&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$=
(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&qu=
ot;PropertySheets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platfor=
m).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.=
Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&q=
uot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Imp=
ort Project=3D&quot;Debug.props&quot; /&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Prope=
rtySheets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.=
props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Pl=
atform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Proj=
ect=3D&quot;Debug.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;_ProjectFileVer=
sion&gt;10.0.30319.1&lt;/_ProjectFileVersion&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quo=
t; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug=
|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quo=
t; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Relea=
se|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&=
quot; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;De=
bug|Win32&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&=
quot; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Re=
lease|Win32&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg=
&quot; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;D=
ebug|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&=
quot; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Re=
lease|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&q=
uot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Additio=
nalIncludeDirectories&gt;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;=
/AdditionalIncludeDirectories&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      &lt;PreprocessorDefinitions&gt;_LIB;%(PreprocessorDefinit=
ions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;=
$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeD=
irectories&gt;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/Additional=
IncludeDirectories&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      &lt;PreprocessorDefinitions&gt;_LIB;%(PreprocessorDefinitions)&lt;/P=
reprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectorie=
s&gt;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDi=
rectories&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &l=
t;PreprocessorDefinitions&gt;_LIB;%(PreprocessorDefinitions)&lt;/Preprocess=
orDefinitions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;/ItemDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;$=
(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Prep=
rocessorDefinitions&gt;_LIB;%(PreprocessorDefinitions)&lt;/PreprocessorDefi=
nitions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/C=
lCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/It=
emDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;$(Solution=
Dir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;PreprocessorD=
efinitions&gt;_LIB;%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinit=
ionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Ite=
mDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Release|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;$(SolutionDir);=
%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;PreprocessorDefini=
tions&gt;_LIB;%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGr=
oup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGrou=
p&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompil=
e Include=3D&quot;compat-basename.c&quot; /&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;compat-dirname.=
c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;=
ClCompile Include=3D&quot;compat-gettimeofday.c&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;com=
pat-daemon.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &lt;ClCompile Include=3D&quot;compat-strsep.c&quot; /&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;c=
ompat.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;ProjectReference Include=3D&quot;..\..\build\msvc\msvc-generate\msvc-gen=
erate.vcxproj&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      &lt;Project&gt;{8598c2c8-34c4-47a1-99b0-7c295a890615}&lt;/Project&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Reference=
OutputAssembly&gt;false&lt;/ReferenceOutputAssembly&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectReference&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&quot;$(VCT=
argetsPath)\Microsoft.Cpp.targets&quot; /&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;ExtensionTargets&qu=
ot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportG=
roup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&=
gt;</span><br><span>\ No newline at end of file</span><br><span>diff --git =
a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 2=
f97991..52deef8 100644</span><br><span>--- a/src/openvpn/Makefile.am</span>=
<br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -15,9 +15,7 @@</=
span><br><span> 	$(srcdir)/Makefile.in</span><br><span> </span><br><span> E=
XTRA_DIST =3D \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	openv=
pn.vcxproj \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	openvpn.=
manifest \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	vcpkg.json=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	openvpn.manifest</=
span><br><span> </span><br><span> AM_CPPFLAGS =3D \</span><br><span> 	-I$(t=
op_srcdir)/include \</span><br><span>diff --git a/src/openvpn/argv.c b/src/=
openvpn/argv.c</span><br><span>index cef0da9..50083ba 100644</span><br><spa=
n>--- a/src/openvpn/argv.c</span><br><span>+++ b/src/openvpn/argv.c</span><=
br><span>@@ -29,8 +29,6 @@</span><br><span> </span><br><span> #ifdef HAVE_C=
ONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span=
><br><span> #endif</span><br><span> </span><br><span> #include &quot;syshea=
d.h&quot;</span><br><span>diff --git a/src/openvpn/auth_token.c b/src/openv=
pn/auth_token.c</span><br><span>index e4486eb..6787ea7 100644</span><br><sp=
an>--- a/src/openvpn/auth_token.c</span><br><span>+++ b/src/openvpn/auth_to=
ken.c</span><br><span>@@ -1,7 +1,5 @@</span><br><span> #ifdef HAVE_CONFIG_H=
</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><s=
pan> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&quo=
t;</span><br><span>diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c=
</span><br><span>index 0ac65e9..a9c2f4c 100644</span><br><span>--- a/src/op=
envpn/base64.c</span><br><span>+++ b/src/openvpn/base64.c</span><br><span>@=
@ -33,8 +33,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</s=
pan><br><span> #include &quot;config.h&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span=
> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&quot;<=
/span><br><span>diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dn=
s.c</span><br><span>index 4af429b..05b2599 100644</span><br><span>--- a/src=
/openvpn/block_dns.c</span><br><span>+++ b/src/openvpn/block_dns.c</span><b=
r><span>@@ -25,8 +25,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CO=
NFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> #include &quot;syshead=
.h&quot;</span><br><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/bu=
ffer.c</span><br><span>index 7725438..24f1ef2 100644</span><br><span>--- a/=
src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><=
span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFI=
G_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><b=
r><span> #endif</span><br><span> </span><br><span> #include &quot;syshead.h=
&quot;</span><br><span>diff --git a/src/openvpn/clinat.c b/src/openvpn/clin=
at.c</span><br><span>index 514bd43..2b91f7b 100644</span><br><span>--- a/sr=
c/openvpn/clinat.c</span><br><span>+++ b/src/openvpn/clinat.c</span><br><sp=
an>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_=
H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><=
span> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&qu=
ot;</span><br><span>diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-=
lz4.c</span><br><span>index e544a8d..33a480c 100644</span><br><span>--- a/s=
rc/openvpn/comp-lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4.c</span><b=
r><span>@@ -24,8 +24,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CO=
NFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> #include &quot;syshead=
.h&quot;</span><br><span>diff --git a/src/openvpn/comp.c b/src/openvpn/comp=
.c</span><br><span>index 27b640c..6e30369 100644</span><br><span>--- a/src/=
openvpn/comp.c</span><br><span>+++ b/src/openvpn/comp.c</span><br><span>@@ =
-23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</spa=
n><br><span> #include &quot;config.h&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> =
#endif</span><br><span> </span><br><span> #include &quot;syshead.h&quot;</s=
pan><br><span>diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c<=
/span><br><span>index 496e60e..adb1f28 100644</span><br><span>--- a/src/ope=
nvpn/compstub.c</span><br><span>+++ b/src/openvpn/compstub.c</span><br><spa=
n>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H=
</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><s=
pan> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&quo=
t;</span><br><span>diff --git a/src/openvpn/console.c b/src/openvpn/console=
.c</span><br><span>index bbdd59c..5b367f2 100644</span><br><span>--- a/src/=
openvpn/console.c</span><br><span>+++ b/src/openvpn/console.c</span><br><sp=
an>@@ -25,8 +25,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_=
H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><=
span> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&qu=
ot;</span><br><span>diff --git a/src/openvpn/console_builtin.c b/src/openvp=
n/console_builtin.c</span><br><span>index 4101feb..b5264d8 100644</span><br=
><span>--- a/src/openvpn/console_builtin.c</span><br><span>+++ b/src/openvp=
n/console_builtin.c</span><br><span>@@ -30,8 +30,6 @@</span><br><span> </sp=
an><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_=
MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quo=
t;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><=
span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openv=
pn/crypto.c b/src/openvpn/crypto.c</span><br><span>index b5ae17e..b5268f1 1=
00644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/=
openvpn/crypto.c</span><br><span>@@ -24,8 +24,6 @@</span><br><span> </span>=
<br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC=
_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;c=
onfig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><spa=
n> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/=
crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index cd43e=
e5..98cac60 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span=
><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -28,8 +28,=
6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><spa=
n> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</sp=
an><br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><s=
pan>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.=
c</span><br><span>index f5372f8..b043bb9 100644</span><br><span>--- a/src/o=
penvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c<=
/span><br><span>@@ -28,8 +28,6 @@</span><br><span> </span><br><span> #ifdef=
 HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot=
;</span><br><span> #endif</span><br><span> </span><br><span> #include &quot=
;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/cryptoapi.c b/src=
/openvpn/cryptoapi.c</span><br><span>index 20b7d98..3b92e48 100644</span><b=
r><span>--- a/src/openvpn/cryptoapi.c</span><br><span>+++ b/src/openvpn/cry=
ptoapi.c</span><br><span>@@ -31,8 +31,6 @@</span><br><span> </span><br><spa=
n> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-ms=
vc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #incl=
ude &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/dco.c b/=
src/openvpn/dco.c</span><br><span>index 308578b..7c7eaac 100644</span><br><=
span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span>=
<br><span>@@ -26,8 +26,6 @@</span><br><span> </span><br><span> #ifdef HAVE_=
CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</spa=
n><br><span> #endif</span><br><span> </span><br><span> #if defined(ENABLE_D=
CO)</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dc=
o_freebsd.c</span><br><span>index af7776b..3ba1c81 100644</span><br><span>-=
-- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebs=
d.c</span><br><span>@@ -20,8 +20,6 @@</span><br><span> </span><br><span> #i=
fdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&=
quot;</span><br><span> #endif</span><br><span> </span><br><span> #if define=
d(ENABLE_DCO) &amp;&amp; defined(TARGET_FREEBSD)</span><br><span>diff --git=
 a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index =
0cf36ba..b033f85 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span=
><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -23,8 +23,6 @@<=
/span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #i=
nclude &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><b=
r><span> </span><br><span> #if defined(ENABLE_DCO) &amp;&amp; defined(TARGE=
T_LINUX)</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/d=
co_win.c</span><br><span>index 4b414ef..53f1523 100644</span><br><span>--- =
a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><=
br><span>@@ -21,8 +21,6 @@</span><br><span> </span><br><span> #ifdef HAVE_C=
ONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span=
><br><span> #endif</span><br><span> </span><br><span> #if defined(_WIN32)</=
span><br><span>diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</span><=
br><span>index b9cd3c6..ac7f538 100644</span><br><span>--- a/src/openvpn/dh=
cp.c</span><br><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -23,8 +23,=
6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><spa=
n> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</sp=
an><br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><s=
pan>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>inde=
x b7808db..530e6d5 100644</span><br><span>--- a/src/openvpn/dns.c</span><br=
><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -23,8 +23,6 @@</span><br>=
<span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &qu=
ot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#eli=
f defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> <=
/span><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git =
a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><br><span>index 79059=
14..97b011f 100644</span><br><span>--- a/src/openvpn/env_set.c</span><br><s=
pan>+++ b/src/openvpn/env_set.c</span><br><span>@@ -26,8 +26,6 @@</span><br=
><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &q=
uot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
if defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
include &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> =
</span><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git=
 a/src/openvpn/error.c b/src/openvpn/error.c</span><br><span>index 9a234e6.=
.56addff 100644</span><br><span>--- a/src/openvpn/error.c</span><br><span>+=
++ b/src/openvpn/error.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span>=
 </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;con=
fig.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defi=
ned(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span>=
<br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/=
openvpn/event.c b/src/openvpn/event.c</span><br><span>index fa5aee2..6b6f95=
1 100644</span><br><span>--- a/src/openvpn/event.c</span><br><span>+++ b/sr=
c/openvpn/event.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span=
><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MS=
C_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;=
config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><sp=
an> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn=
/fdmisc.c b/src/openvpn/fdmisc.c</span><br><span>index 3f74171..3570ed4 100=
644</span><br><span>--- a/src/openvpn/fdmisc.c</span><br><span>+++ b/src/op=
envpn/fdmisc.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><b=
r><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_V=
ER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;con=
fig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span>=
 #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/fo=
rward.c b/src/openvpn/forward.c</span><br><span>index 5bffe07..d8ad0d1 1006=
44</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/op=
envpn/forward.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><=
br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_=
VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;co=
nfig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span=
> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/f=
ragment.c b/src/openvpn/fragment.c</span><br><span>index 50391de..974ebda 1=
00644</span><br><span>--- a/src/openvpn/fragment.c</span><br><span>+++ b/sr=
c/openvpn/fragment.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </s=
pan><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.=
h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(=
_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &qu=
ot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br>=
<span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/open=
vpn/gremlin.c b/src/openvpn/gremlin.c</span><br><span>index c77fc40..501d70=
c 100644</span><br><span>--- a/src/openvpn/gremlin.c</span><br><span>+++ b/=
src/openvpn/gremlin.c</span><br><span>@@ -28,8 +28,6 @@</span><br><span> </=
span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config=
.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined=
(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &q=
uot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br=
><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/ope=
nvpn/helper.c b/src/openvpn/helper.c</span><br><span>index 7c219fd..fa011ff=
 100644</span><br><span>--- a/src/openvpn/helper.c</span><br><span>+++ b/sr=
c/openvpn/helper.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </spa=
n><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_M=
SC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot=
;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><s=
pan> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvp=
n/httpdigest.c b/src/openvpn/httpdigest.c</span><br><span>index 6714ef9..5c=
255b2 100644</span><br><span>--- a/src/openvpn/httpdigest.c</span><br><span=
>+++ b/src/openvpn/httpdigest.c</span><br><span>@@ -23,8 +23,6 @@</span><br=
><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &q=
uot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
if defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
include &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> =
</span><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git=
 a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index d358ad0..6=
fb6900 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ =
b/src/openvpn/init.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </s=
pan><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.=
h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(=
_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &qu=
ot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br>=
<span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/open=
vpn/interval.c b/src/openvpn/interval.c</span><br><span>index 8308df4..bde9=
dd9 100644</span><br><span>--- a/src/openvpn/interval.c</span><br><span>+++=
 b/src/openvpn/interval.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span=
> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;co=
nfig.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif def=
ined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span=
><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src=
/openvpn/list.c b/src/openvpn/list.c</span><br><span>index f65d8a8..480f39d=
 100644</span><br><span>--- a/src/openvpn/list.c</span><br><span>+++ b/src/=
openvpn/list.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><b=
r><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_V=
ER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;con=
fig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span>=
 #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/ll=
addr.c b/src/openvpn/lladdr.c</span><br><span>index ee67718..cc677b4 100644=
</span><br><span>--- a/src/openvpn/lladdr.c</span><br><span>+++ b/src/openv=
pn/lladdr.c</span><br><span>@@ -4,8 +4,6 @@</span><br><span> </span><br><sp=
an> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-m=
svc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #inc=
lude &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/lzo.c b=
/src/openvpn/lzo.c</span><br><span>index 848cb06..1901780 100644</span><br>=
<span>--- a/src/openvpn/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span=
><br><span>@@ -27,8 +27,6 @@</span><br><span> </span><br><span> #ifdef HAVE=
_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</sp=
an><br><span> #endif</span><br><span> </span><br><span> #include &quot;sysh=
ead.h&quot;</span><br><span>diff --git a/src/openvpn/manage.c b/src/openvpn=
/manage.c</span><br><span>index 2eaf2f1..739ed40 100644</span><br><span>---=
 a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><b=
r><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CO=
NFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> #include &quot;syshead=
.h&quot;</span><br><span>diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf=
.c</span><br><span>index a44f8c3..318b9ed 100644</span><br><span>--- a/src/=
openvpn/mbuf.c</span><br><span>+++ b/src/openvpn/mbuf.c</span><br><span>@@ =
-23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</spa=
n><br><span> #include &quot;config.h&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> =
#endif</span><br><span> </span><br><span> #include &quot;syshead.h&quot;</s=
pan><br><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><b=
r><span>index 774ea06..ce6e4fd 100644</span><br><span>--- a/src/openvpn/mis=
c.c</span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -25,8 +25,6=
 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span=
> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</spa=
n><br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><sp=
an>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span=
>index 2683b40..91af2b6 100644</span><br><span>--- a/src/openvpn/mroute.c</=
span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -23,8 +23,6 @@=
</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #=
include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><=
br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><span>=
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><span>index 98=
d5406..816e65b 100644</span><br><span>--- a/src/openvpn/mss.c</span><br><sp=
an>+++ b/src/openvpn/mss.c</span><br><span>@@ -23,8 +23,6 @@</span><br><spa=
n> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;c=
onfig.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif de=
fined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inclu=
de &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </spa=
n><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/sr=
c/openvpn/mstats.c b/src/openvpn/mstats.c</span><br><span>index 1e92b41..04=
be449 100644</span><br><span>--- a/src/openvpn/mstats.c</span><br><span>+++=
 b/src/openvpn/mstats.c</span><br><span>@@ -27,8 +27,6 @@</span><br><span> =
</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;conf=
ig.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defin=
ed(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include =
&quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><=
br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/o=
penvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 6c56a26..62eb14b 1=
00644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/op=
envpn/mtcp.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br>=
<span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;confi=
g-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #=
include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/mtu.=
c b/src/openvpn/mtu.c</span><br><span>index 2925b7f..132f93c 100644</span><=
br><span>--- a/src/openvpn/mtu.c</span><br><span>+++ b/src/openvpn/mtu.c</s=
pan><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef H=
AVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;<=
/span><br><span> #endif</span><br><span> </span><br><span> #include &quot;s=
yshead.h&quot;</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvp=
n/mudp.c</span><br><span>index 8698aef..81625ea 100644</span><br><span>--- =
a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><sp=
an>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_=
H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><=
span> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&qu=
ot;</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<=
/span><br><span>index 6fb9cff..aad11b1 100644</span><br><span>--- a/src/ope=
nvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -=
23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span=
><br><span> #include &quot;config.h&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #=
endif</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><b=
r><span>diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/network=
ing_freebsd.c</span><br><span>index 0633dce..1c94756 100644</span><br><span=
>--- a/src/openvpn/networking_freebsd.c</span><br><span>+++ b/src/openvpn/n=
etworking_freebsd.c</span><br><span>@@ -1,7 +1,5 @@</span><br><span> #ifdef=
 HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot=
;</span><br><span> #endif</span><br><span> #include &quot;syshead.h&quot;</=
span><br><span> #include &quot;errlevel.h&quot;</span><br><span>diff --git =
a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c</sp=
an><br><span>index 0efeed0..9d2351c 100644</span><br><span>--- a/src/openvp=
n/networking_iproute2.c</span><br><span>+++ b/src/openvpn/networking_iprout=
e2.c</span><br><span>@@ -20,8 +20,6 @@</span><br><span> </span><br><span> #=
ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h=
&quot;</span><br><span> #endif</span><br><span> </span><br><span> #if defin=
ed(TARGET_LINUX) &amp;&amp; defined(ENABLE_IPROUTE)</span><br><span>diff --=
git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c</span=
><br><span>index cb9a47c..662e0e2 100644</span><br><span>--- a/src/openvpn/=
networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_sitnl.c</sp=
an><br><span>@@ -20,8 +20,6 @@</span><br><span> </span><br><span> #ifdef HA=
VE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</=
span><br><span> #endif</span><br><span> </span><br><span> #ifdef TARGET_LIN=
UX</span><br><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</sp=
an><br><span>index 20527d4..0cb0a32 100644</span><br><span>--- a/src/openvp=
n/ntlm.c</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ -22,8 =
+22,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br>=
<span> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif=
</span><br><span> </span><br><span> #include &quot;syshead.h&quot;</span><b=
r><span>diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c</span><br><span>=
index 94b82e0..8541f6e 100644</span><br><span>--- a/src/openvpn/occ.c</span=
><br><span>+++ b/src/openvpn/occ.c</span><br><span>@@ -23,8 +23,6 @@</span>=
<br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include=
 &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><spa=
n> </span><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --=
git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</span><br=
><span>index 56b1dcf..ffb64ad 100644</span><br><span>--- a/src/openvpn/open=
ssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_compat.h</span><br><=
span>@@ -36,8 +36,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFI=
G_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><b=
r><span> #endif</span><br><span> </span><br><span> #include &quot;buffer.h&=
quot;</span><br><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn/open=
vpn.c</span><br><span>index 1aaddcd..348392e 100644</span><br><span>--- a/s=
rc/openvpn/openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br>=
<span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONF=
IG_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> #include &quot;syshead=
.h&quot;</span><br><span>diff --git a/src/openvpn/openvpn.vcxproj b/src/ope=
nvpn/openvpn.vcxproj</span><br><span>deleted file mode 100644</span><br><sp=
an>index 97baf67..0000000</span><br><span>--- a/src/openvpn/openvpn.vcxproj=
</span><br><span>+++ /dev/null</span><br><span>@@ -1,470 +0,0 @@</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-=EF=BB=BF&lt;?xml version=3D&quo=
t;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-&lt;Project DefaultTargets=3D&quot;Build&quot; Tool=
sVersion=3D&quot;15.0&quot; xmlns=3D&quot;http://schemas.microsoft.com/deve=
loper/msbuild/2003&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  &lt;ItemGroup Label=3D&quot;ProjectConfigurations&quot;&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration=
 Include=3D&quot;Debug|ARM64&quot;&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;ARM=
64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Debug|Win32&quot;&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configurat=
ion&gt;Debug&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;Platform&gt;Win32&lt;/Platform&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguratio=
n Include=3D&quot;Debug|x64&quot;&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;x64&=
lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &lt;ProjectConfiguration Include=3D&quot;Release|ARM64&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configurati=
on&gt;Release&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-      &lt;Platform&gt;ARM64&lt;/Platform&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfigurati=
on Include=3D&quot;Release|Win32&quot;&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Release&lt;/Configuration&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&=
gt;Win32&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Release|x64&qu=
ot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Conf=
iguration&gt;Release&lt;/Configuration&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      &lt;Platform&gt;x64&lt;/Platform&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup La=
bel=3D&quot;Globals&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;ProjectGuid&gt;{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}&lt;/P=
rojectGuid&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;RootNamespace&gt;openvpn&lt;/RootNamespace&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;WindowsTargetPlatf=
ormVersion&gt;10.0&lt;/WindowsTargetPlatformVersion&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&quot;$(VCTarge=
tsPath)\Microsoft.Cpp.Default.props&quot; /&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quo=
t;Configuration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;ConfigurationType&gt;Application&lt;/ConfigurationType&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimi=
zation&gt;true&lt;/WholeProgramOptimization&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToo=
lset&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGrou=
p&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGr=
oup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Rele=
ase|x64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Application=
&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOptimization&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterS=
et&gt;NotSet&lt;/CharacterSet&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;=
Spectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configura=
tion&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;ConfigurationType&gt;Application&lt;/ConfigurationType&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt;t=
rue&lt;/WholeProgramOptimization&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v14=
3&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Conditi=
on=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39=
;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Application&lt;/Config=
urationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMi=
tigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Con=
figuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;C=
onfiguration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;ConfigurationType&gt;Application&lt;/ConfigurationType&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;NotSe=
t&lt;/CharacterSet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;=
/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)=
&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configuration&quot;&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Configuratio=
nType&gt;Application&lt;/ConfigurationType&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformTool=
set&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Proj=
ect=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.props&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;Exte=
nsionSettings&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#3=
9;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Proje=
ct=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condit=
ion=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\com=
pat\Release.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Platfo=
rm)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;PropertySheets&quot=
;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import P=
roject=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Co=
ndition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.p=
rops&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..=
\compat\Release.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;PropertySheet=
s&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Im=
port Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&qu=
ot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).=
user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&q=
uot;..\compat\Release.props&quot; /&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;PropertyS=
heets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platfo=
rm).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=
=3D&quot;..\compat\Debug.props&quot; /&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configurat=
ion)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Property=
Sheets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platf=
orm).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=
=3D&quot;..\compat\Debug.props&quot; /&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configurat=
ion)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Proper=
tySheets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.p=
rops&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Pla=
tform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Proje=
ct=3D&quot;..\compat\Debug.props&quot; /&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;UserMacros&quot; =
/&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGr=
oup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;_Proje=
ctFileVersion&gt;10.0.30319.1&lt;/_ProjectFileVersion&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quo=
t;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;GenerateManif=
est&gt;false&lt;/GenerateManifest&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configurati=
on)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;GenerateManifest&gt;false&lt;/G=
enerateManifest&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#3=
9;=3D=3D&#39;Release|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;GenerateManifest&gt;false&lt;/GenerateManifest&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGro=
up Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Relea=
se|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;GenerateManifest&gt;false&lt;/GenerateManifest&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&=
quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&qu=
ot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Genera=
teManifest&gt;false&lt;/GenerateManifest&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;GenerateManifest&gt;fals=
e&lt;/GenerateManifest&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;&#3=
9;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled&gt;=
true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;VcpkgTriplet&gt;arm64-windows-ovpn&lt;/VcpkgTriplet&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgAdditionalInstal=
lOptions&gt;--overlay-triplets=3D$(SolutionDir)contrib\vcpkg-triplets --ove=
rlay-ports=3D$(SolutionDir)contrib\vcpkg-ports&lt;/VcpkgAdditionalInstallOp=
tions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Prope=
rtyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Pro=
pertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgE=
nabled&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vcp=
kgTriplet&gt;arm64-windows-ovpn&lt;/VcpkgTriplet&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgAdditionalInstallOptions&gt;--=
overlay-triplets=3D$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=3D$=
(SolutionDir)contrib\vcpkg-ports&lt;/VcpkgAdditionalInstallOptions&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Lab=
el=3D&quot;Vcpkg&quot; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&=
#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgTriplet&gt;x86=
-windows-ovpn&lt;/VcpkgTriplet&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;VcpkgAdditionalInstallOptions&gt;--overlay-triplets=3D=
$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contri=
b\vcpkg-ports&lt;/VcpkgAdditionalInstallOptions&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&=
quot; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Re=
lease|Win32&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgTriplet&gt;x86-windows-ovpn&l=
t;/VcpkgTriplet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;VcpkgAdditionalInstallOptions&gt;--overlay-triplets=3D$(SolutionDir)c=
ontrib\vcpkg-triplets --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports&l=
t;/VcpkgAdditionalInstallOptions&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&qu=
ot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgE=
nabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;VcpkgTriplet&gt;x64-windows-ovpn&lt;/VcpkgTriplet&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgAddition=
alInstallOptions&gt;--overlay-triplets=3D$(SolutionDir)contrib\vcpkg-triple=
ts --overlay-ports=3D$(SolutionDir)contrib\vcpkg-ports&lt;/VcpkgAdditionalI=
nstallOptions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &l=
t;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;&#39;$(Confi=
guration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled&gt;true&lt;/=
VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;VcpkgTriplet&gt;x64-windows-ovpn&lt;/VcpkgTriplet&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgAdditionalInstallOptions&gt=
;--overlay-triplets=3D$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=
=3D$(SolutionDir)contrib\vcpkg-ports&lt;/VcpkgAdditionalInstallOptions&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup=
 Label=3D&quot;Vcpkg&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;VcpkgEnableManifest&gt;true&lt;/VcpkgEnableManifest&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionG=
roup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Deb=
ug|Win32&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECUR=
E_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefini=
tions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      &lt;UndefinePreprocessorDefinitions&gt;%(UndefinePre=
processorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      &lt;TreatWarningAsError&gt;tr=
ue&lt;/TreatWarningAsError&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      &lt;AdditionalIncludeDirectories&gt;..\compat;%(AdditionalIn=
cludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      &lt;WarningLevel&gt;Level2&lt;/Warni=
ngLevel&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;=
AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLChec=
k&gt;true&lt;/SDLCheck&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ResourceCompile /&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      &lt;AdditionalDependencies&gt;Ncrypt.lib;gdi32.lib;ws2_32.li=
b;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;se=
tupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalLibraryDirectories&gt;=
$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibrary=
Directories)&lt;/AdditionalLibraryDirectories&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGro=
up&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefin=
itionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#=
39;Debug|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPRECATE;_CRT_S=
ECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDe=
finitions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      &lt;UndefinePreprocessorDefinitions&gt;%(Undefin=
ePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;TreatWarningAsError&g=
t;true&lt;/TreatWarningAsError&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;..\compat;%(Addition=
alIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      &lt;WarningLevel&gt;Level2&lt;/W=
arningLevel&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
&lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOpt=
ions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDL=
Check&gt;true&lt;/SDLCheck&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &lt;ResourceCompile /&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;AdditionalDependencies&gt;Ncrypt.lib;gdi32.lib;ws2_3=
2.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.li=
b;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalLibraryDirectories=
&gt;$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLib=
raryDirectories)&lt;/AdditionalLibraryDirectories&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;SubSystem&gt;Console&lt;/SubSyste=
m&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitio=
nGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemD=
efinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Debug|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPRECATE=
;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Preproc=
essorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      &lt;UndefinePreprocessorDefinitions&gt;%(=
UndefinePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;TreatWarningAs=
Error&gt;true&lt;/TreatWarningAsError&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;..\compat;%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;WarningLevel&gt;Level=
2&lt;/WarningLevel&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/Additi=
onalOptions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
&lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ResourceCompile /&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      &lt;AdditionalDependencies&gt;Ncrypt.lib;gdi32.li=
b;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rp=
crt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalLibraryDire=
ctories&gt;$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(Additi=
onalLibraryDirectories)&lt;/AdditionalLibraryDirectories&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      &lt;SubSystem&gt;Console&lt;/S=
ubSystem&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/=
Link&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDe=
finitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &l=
t;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#=
39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_D=
EPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%=
(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      &lt;UndefinePreprocessorDefinitio=
ns&gt;%(UndefinePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinition=
s&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;TreatW=
arningAsError&gt;true&lt;/TreatWarningAsError&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;..\co=
mpat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;ControlFlowGu=
ard&gt;Guard&lt;/ControlFlowGuard&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions=
&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDL=
Check&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClC=
ompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Res=
ourceCompile /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;Link&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &l=
t;AdditionalDependencies&gt;Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cry=
pt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi=
32.lib&lt;/AdditionalDependencies&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HOME)/l=
ib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)&lt;/=
AdditionalLibraryDirectories&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      &lt;CETCompat&gt;true&lt;/CETCo=
mpat&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefini=
tionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;It=
emDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Release|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPREC=
ATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prep=
rocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;UndefinePreprocessorDefinitions&g=
t;%(UndefinePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;TreatWarni=
ngAsError&gt;true&lt;/TreatWarningAsError&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;..\compat=
;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;ControlFlowGuard&=
gt;Guard&lt;/ControlFlowGuard&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      &lt;WarningLevel&gt;Level2&lt;/Warn=
ingLevel&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt=
;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOption=
s&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompi=
le&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Resourc=
eCompile /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;Link&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Ad=
ditionalDependencies&gt;Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32=
.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.l=
ib&lt;/AdditionalDependencies&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      &lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HOME)/lib;$=
(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)&lt;/Addi=
tionalLibraryDirectories&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      &lt;CETCompat&gt;true&lt;/CETCompat=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinition=
Group&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDe=
finitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Release|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPRECA=
TE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prepr=
ocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;UndefinePreprocessorDefinitions&g=
t;%(UndefinePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;TreatWarni=
ngAsError&gt;true&lt;/TreatWarningAsError&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories&gt;..\compat=
;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;ControlFlowGuard&=
gt;Guard&lt;/ControlFlowGuard&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&gt;=
/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLChec=
k&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompi=
le&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Resourc=
eCompile /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;Link&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Ad=
ditionalDependencies&gt;Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32=
.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.l=
ib&lt;/AdditionalDependencies&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      &lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HOME)/lib;$=
(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)&lt;/Addi=
tionalLibraryDirectories&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;ar=
gv.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;ClCompile Include=3D&quot;auth_token.c&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;base64.c&=
quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Cl=
Compile Include=3D&quot;block_dns.c&quot; /&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;buffer.c&quot; =
/&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompil=
e Include=3D&quot;clinat.c&quot; /&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;comp-lz4.c&quot; /&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Inclu=
de=3D&quot;comp.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;ClCompile Include=3D&quot;compstub.c&quot; /&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quo=
t;console.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClCompile Include=3D&quot;console_builtin.c&quot; /&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&qu=
ot;crypto.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClCompile Include=3D&quot;crypto_openssl.c&quot; /&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quo=
t;cryptoapi.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;ClCompile Include=3D&quot;dco.c&quot; /&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;dco_win=
.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;ClCompile Include=3D&quot;dhcp.c&quot; /&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;dns.c&quot; /&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Inc=
lude=3D&quot;env_set.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;ClCompile Include=3D&quot;error.c&quot; /&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&q=
uot;event.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClCompile Include=3D&quot;fdmisc.c&quot; /&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;forwar=
d.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;ClCompile Include=3D&quot;fragment.c&quot; /&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;gremlin.c&qu=
ot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCo=
mpile Include=3D&quot;helper.c&quot; /&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;httpdigest.c&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile=
 Include=3D&quot;init.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;ClCompile Include=3D&quot;interval.c&quot; /&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=
=3D&quot;list.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ClCompile Include=3D&quot;lladdr.c&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;lz=
o.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;ClCompile Include=3D&quot;manage.c&quot; /&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;mbuf.c&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile=
 Include=3D&quot;misc.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;ClCompile Include=3D&quot;mroute.c&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D=
&quot;mss.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClCompile Include=3D&quot;mstats.c&quot; /&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;mtcp.c=
&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;C=
lCompile Include=3D&quot;mtu.c&quot; /&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;mudp.c&quot; /&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Inclu=
de=3D&quot;multi.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;ClCompile Include=3D&quot;ntlm.c&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;o=
cc.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;ClCompile Include=3D&quot;openvpn.c&quot; /&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;options.c&qu=
ot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCo=
mpile Include=3D&quot;options_util.c&quot; /&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;otime.c&quot; =
/&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompil=
e Include=3D&quot;packet_id.c&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;perf.c&quot; /&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Includ=
e=3D&quot;ping.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &lt;ClCompile Include=3D&quot;pkcs11.c&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;p=
kcs11_openssl.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ClCompile Include=3D&quot;platform.c&quot; /&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;=
plugin.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ClCompile Include=3D&quot;pool.c&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;proto.c&q=
uot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClC=
ompile Include=3D&quot;proxy.c&quot; /&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;ps.c&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=
=3D&quot;push.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ClCompile Include=3D&quot;reflect_filter.c&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D=
&quot;reliable.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &lt;ClCompile Include=3D&quot;route.c&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;ru=
n_command.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClCompile Include=3D&quot;schedule.c&quot; /&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;sess=
ion_id.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ClCompile Include=3D&quot;shaper.c&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;sig.c&quo=
t; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCom=
pile Include=3D&quot;socket.c&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;socks.c&quot; /&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Inclu=
de=3D&quot;ssl.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &lt;ClCompile Include=3D&quot;ssl_openssl.c&quot; /&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&q=
uot;ssl_ncp.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;ClCompile Include=3D&quot;ssl_pkt.c&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;ssl=
_util.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;ClCompile Include=3D&quot;ssl_verify.c&quot; /&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;ssl_ve=
rify_openssl.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;ClCompile Include=3D&quot;status.c&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;tls=
_crypt.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ClCompile Include=3D&quot;tun.c&quot; /&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;vlan.c&quot;=
 /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompi=
le Include=3D&quot;win32.c&quot; /&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;win32-util.c&quot; /&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Inc=
lude=3D&quot;xkey_helper.c&quot; /&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;xkey_provider.c&quot; /&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Inc=
lude=3D&quot;argv.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &lt;ClInclude Include=3D&quot;auth_token.h&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D=
&quot;base64.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;ClInclude Include=3D&quot;basic.h&quot; /&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;bloc=
k_dns.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;ClInclude Include=3D&quot;buffer.h&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;circ_list=
.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;ClInclude Include=3D&quot;clinat.h&quot; /&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;common.h&quot; =
/&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclud=
e Include=3D&quot;comp-lz4.h&quot; /&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;comp.h&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=
=3D&quot;compstub.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &lt;ClInclude Include=3D&quot;console.h&quot; /&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&qu=
ot;crypto.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClInclude Include=3D&quot;crypto_backend.h&quot; /&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quo=
t;crypto_openssl.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;ClInclude Include=3D&quot;cryptoapi.h&quot; /&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&q=
uot;dco.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;ClInclude Include=3D&quot;dco_internal.h&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;dc=
o_win.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;ClInclude Include=3D&quot;dhcp.h&quot; /&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;dns.h&quot; =
/&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclud=
e Include=3D&quot;env_set.h&quot; /&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;errlevel.h&quot; /&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Incl=
ude=3D&quot;error.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &lt;ClInclude Include=3D&quot;event.h&quot; /&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot=
;fdmisc.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;ClInclude Include=3D&quot;forward.h&quot; /&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;fragmen=
t.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;ClInclude Include=3D&quot;gremlin.h&quot; /&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;helper.h&quot=
; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClIncl=
ude Include=3D&quot;httpdigest.h&quot; /&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;init.h&quot; /&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Inc=
lude=3D&quot;integer.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;ClInclude Include=3D&quot;interval.h&quot; /&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=
=3D&quot;list.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ClInclude Include=3D&quot;lladdr.h&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;lz=
o.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;ClInclude Include=3D&quot;manage.h&quot; /&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;mbuf.h&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude=
 Include=3D&quot;memdbg.h&quot; /&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;misc.h&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D=
&quot;mroute.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;ClInclude Include=3D&quot;mss.h&quot; /&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;mstats=
.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;ClInclude Include=3D&quot;mtcp.h&quot; /&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;mtu.h&quot; /&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Inc=
lude=3D&quot;mudp.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &lt;ClInclude Include=3D&quot;multi.h&quot; /&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot=
;ntlm.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;ClInclude Include=3D&quot;occ.h&quot; /&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;openvpn.h&quo=
t; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInc=
lude Include=3D&quot;options.h&quot; /&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;options_util.h&quot;=
 /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclu=
de Include=3D&quot;otime.h&quot; /&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;ovpn_dco_win.h&quot; /&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude I=
nclude=3D&quot;packet_id.h&quot; /&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;perf.h&quot; /&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=
=3D&quot;ping.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ClInclude Include=3D&quot;pkcs11.h&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;pk=
cs11_backend.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;ClInclude Include=3D&quot;platform.h&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;p=
lugin.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;ClInclude Include=3D&quot;pool.h&quot; /&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;proto.h&quot=
; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClIncl=
ude Include=3D&quot;proxy.h&quot; /&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;ps.h&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D=
&quot;push.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &lt;ClInclude Include=3D&quot;pushlist.h&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;ref=
lect_filter.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;ClInclude Include=3D&quot;reliable.h&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;ri=
ng_buffer.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClInclude Include=3D&quot;route.h&quot; /&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;run_com=
mand.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;ClInclude Include=3D&quot;schedule.h&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;session_i=
d.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;ClInclude Include=3D&quot;shaper.h&quot; /&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;sig.h&quot; /&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude =
Include=3D&quot;socket.h&quot; /&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;ClInclude Include=3D&quot;socks.h&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D=
&quot;ssl.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClInclude Include=3D&quot;ssl_backend.h&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;s=
sl_common.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClInclude Include=3D&quot;ssl_ncp.h&quot; /&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;ssl_o=
penssl.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ClInclude Include=3D&quot;ssl_pkt.h&quot; /&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;ssl_util=
.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;ClInclude Include=3D&quot;ssl_verify.h&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;ssl_verif=
y_backend.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;ClInclude Include=3D&quot;ssl_verify_openssl.h&quot; /&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D=
&quot;status.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;ClInclude Include=3D&quot;syshead.h&quot; /&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;tl=
s_crypt.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;ClInclude Include=3D&quot;tun.h&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;vlan.h&qu=
ot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClIn=
clude Include=3D&quot;win32.h&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;win32-util.h&quot; /&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude =
Include=3D&quot;xkey_common.h&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ResourceCompile Include=3D&quot;openvpn_win32_reso=
urces.rc&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;ProjectReference Include=3D&quot;..\..\build\msvc\msvc-generate\msvc-ge=
nerate.vcxproj&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      &lt;Project&gt;{8598c2c8-34c4-47a1-99b0-7c295a890615}&lt;/Project&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Referenc=
eOutputAssembly&gt;false&lt;/ReferenceOutputAssembly&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectReference&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectReference Include=
=3D&quot;..\compat\compat.vcxproj&quot;&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-      &lt;Project&gt;{4b2e2719-e661-45d7-9203-f6f456b=
22f19}&lt;/Project&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      &lt;ReferenceOutputAssembly&gt;false&lt;/ReferenceOutputAssembly&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectRefer=
ence&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGr=
oup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGrou=
p&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Manifest=
 Include=3D&quot;openvpn.manifest&quot; /&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&quot;$(VCTargetsPath)\Micros=
oft.Cpp.targets&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&gt;</span><br><spa=
n>\ No newline at end of file</span><br><span>diff --git a/src/openvpn/open=
vpn_win32_resources.rc b/src/openvpn/openvpn_win32_resources.rc</span><br><=
span>index 1ea5f87..a843b1b 100644</span><br><span>--- a/src/openvpn/openvp=
n_win32_resources.rc</span><br><span>+++ b/src/openvpn/openvpn_win32_resour=
ces.rc</span><br><span>@@ -1,7 +1,5 @@</span><br><span> #ifdef HAVE_CONFIG_=
H</span><br><span> #include &lt;config.h&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#include &lt;config-msvc-version.h&gt;</span><br><span> #endif</span=
><br><span> #include &lt;winresrc.h&gt;</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>i=
ndex efddc58..90d85be 100644</span><br><span>--- a/src/openvpn/options.c</s=
pan><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -29,8 +29,6 @@=
</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #=
include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><=
br><span> #ifdef HAVE_CONFIG_VERSION_H</span><br><span> #include &quot;conf=
ig-version.h&quot;</span><br><span>diff --git a/src/openvpn/options_util.c =
b/src/openvpn/options_util.c</span><br><span>index b071f37..3660da0 100644<=
/span><br><span>--- a/src/openvpn/options_util.c</span><br><span>+++ b/src/=
openvpn/options_util.c</span><br><span>@@ -24,8 +24,6 @@</span><br><span> <=
/span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;confi=
g.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif define=
d(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><b=
r><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/op=
envpn/otime.c b/src/openvpn/otime.c</span><br><span>index 0bbed81..b28a90f =
100644</span><br><span>--- a/src/openvpn/otime.c</span><br><span>+++ b/src/=
openvpn/otime.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><=
br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_=
VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;co=
nfig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span=
> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/p=
acket_id.c b/src/openvpn/packet_id.c</span><br><span>index bb790f0..ef83248=
 100644</span><br><span>--- a/src/openvpn/packet_id.c</span><br><span>+++ b=
/src/openvpn/packet_id.c</span><br><span>@@ -32,8 +32,6 @@</span><br><span>=
 </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;con=
fig.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defi=
ned(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span>=
<br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/=
openvpn/perf.c b/src/openvpn/perf.c</span><br><span>index 5eb8926..ca4f810 =
100644</span><br><span>--- a/src/openvpn/perf.c</span><br><span>+++ b/src/o=
penvpn/perf.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br=
><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VE=
R)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;conf=
ig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> =
#include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/pin=
g.c b/src/openvpn/ping.c</span><br><span>index 25822c9..ccf9870 100644</spa=
n><br><span>--- a/src/openvpn/ping.c</span><br><span>+++ b/src/openvpn/ping=
.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #if=
def HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&q=
uot;</span><br><span> #endif</span><br><span> </span><br><span> #include &q=
uot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/pkcs11.c b/src=
/openvpn/pkcs11.c</span><br><span>index b6c3bf1..cfe6cf6 100644</span><br><=
span>--- a/src/openvpn/pkcs11.c</span><br><span>+++ b/src/openvpn/pkcs11.c<=
/span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef=
 HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot=
;</span><br><span> #endif</span><br><span> </span><br><span> #include &quot=
;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/pkcs11_mbedtls.c =
b/src/openvpn/pkcs11_mbedtls.c</span><br><span>index a286a23..7e4be14 10064=
4</span><br><span>--- a/src/openvpn/pkcs11_mbedtls.c</span><br><span>+++ b/=
src/openvpn/pkcs11_mbedtls.c</span><br><span>@@ -28,8 +28,6 @@</span><br><s=
pan> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot=
;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif =
defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </s=
pan><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/=
src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c</span><br><span=
>index 9b0ab39..7c07152 100644</span><br><span>--- a/src/openvpn/pkcs11_ope=
nssl.c</span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</span><br><span>@=
@ -28,8 +28,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</s=
pan><br><span> #include &quot;config.h&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span=
> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&quot;<=
/span><br><span>diff --git a/src/openvpn/platform.c b/src/openvpn/platform.=
c</span><br><span>index f6b856f..32c4fe6 100644</span><br><span>--- a/src/o=
penvpn/platform.c</span><br><span>+++ b/src/openvpn/platform.c</span><br><s=
pan>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG=
_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><b=
r><span> #endif</span><br><span> </span><br><span> #include &quot;syshead.h=
&quot;</span><br><span>diff --git a/src/openvpn/plugin.c b/src/openvpn/plug=
in.c</span><br><span>index d662998..b4d4a98 100644</span><br><span>--- a/sr=
c/openvpn/plugin.c</span><br><span>+++ b/src/openvpn/plugin.c</span><br><sp=
an>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_=
H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><=
span> #endif</span><br><span> #ifdef HAVE_CONFIG_VERSION_H</span><br><span>=
 #include &quot;config-version.h&quot;</span><br><span>diff --git a/src/ope=
nvpn/pool.c b/src/openvpn/pool.c</span><br><span>index 4af9bcb..5ab0f95 100=
644</span><br><span>--- a/src/openvpn/pool.c</span><br><span>+++ b/src/open=
vpn/pool.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><s=
pan> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-=
msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #in=
clude &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/proto.=
c b/src/openvpn/proto.c</span><br><span>index 7a84407..cab60c3 100644</span=
><br><span>--- a/src/openvpn/proto.c</span><br><span>+++ b/src/openvpn/prot=
o.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #i=
fdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&=
quot;</span><br><span> #endif</span><br><span> </span><br><span> #include &=
quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/proxy.c b/src=
/openvpn/proxy.c</span><br><span>index ed47eaa..76e27cb 100644</span><br><s=
pan>--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</sp=
an><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HA=
VE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</=
span><br><span> #endif</span><br><span> </span><br><span> #include &quot;sy=
shead.h&quot;</span><br><span>diff --git a/src/openvpn/ps.c b/src/openvpn/p=
s.c</span><br><span>index 3609630..4659e17 100644</span><br><span>--- a/src=
/openvpn/ps.c</span><br><span>+++ b/src/openvpn/ps.c</span><br><span>@@ -23=
,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><=
br><span> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #en=
dif</span><br><span> </span><br><span> #include &quot;syshead.h&quot;</span=
><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><=
span>index 8f0a534..01e7cd6 100644</span><br><span>--- a/src/openvpn/push.c=
</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -23,8 +23,6 @@=
</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #=
include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><=
br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><span>=
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c</s=
pan><br><span>index cfe69a6..0db456b 100644</span><br><span>--- a/src/openv=
pn/reflect_filter.c</span><br><span>+++ b/src/openvpn/reflect_filter.c</spa=
n><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAV=
E_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</s=
pan><br><span> #endif</span><br><span> </span><br><span> #include &quot;sys=
head.h&quot;</span><br><span>diff --git a/src/openvpn/reliable.c b/src/open=
vpn/reliable.c</span><br><span>index 32b346b..e7d4d5f 100644</span><br><spa=
n>--- a/src/openvpn/reliable.c</span><br><span>+++ b/src/openvpn/reliable.c=
</span><br><span>@@ -28,8 +28,6 @@</span><br><span> </span><br><span> #ifde=
f HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quo=
t;</span><br><span> #endif</span><br><span> </span><br><span> #include &quo=
t;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/route.c b/src/op=
envpn/route.c</span><br><span>index f2852b4..90e981e 100644</span><br><span=
>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span>=
<br><span>@@ -27,8 +27,6 @@</span><br><span> </span><br><span> #ifdef HAVE_=
CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</spa=
n><br><span> #endif</span><br><span> </span><br><span> #include &quot;syshe=
ad.h&quot;</span><br><span>diff --git a/src/openvpn/run_command.c b/src/ope=
nvpn/run_command.c</span><br><span>index 8c2a6d7..864b317 100644</span><br>=
<span>--- a/src/openvpn/run_command.c</span><br><span>+++ b/src/openvpn/run=
_command.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><s=
pan> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-=
msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #in=
clude &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/schedu=
le.c b/src/openvpn/schedule.c</span><br><span>index b0fca03..e1bc24a 100644=
</span><br><span>--- a/src/openvpn/schedule.c</span><br><span>+++ b/src/ope=
nvpn/schedule.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><=
br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_=
VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;co=
nfig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span=
> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/s=
ession_id.c b/src/openvpn/session_id.c</span><br><span>index 89c67ef..25c5f=
aa 100644</span><br><span>--- a/src/openvpn/session_id.c</span><br><span>++=
+ b/src/openvpn/session_id.c</span><br><span>@@ -32,8 +32,6 @@</span><br><s=
pan> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot=
;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif =
defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </s=
pan><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/=
src/openvpn/shaper.c b/src/openvpn/shaper.c</span><br><span>index 6a0d7dd..=
c65dec8 100644</span><br><span>--- a/src/openvpn/shaper.c</span><br><span>+=
++ b/src/openvpn/shaper.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span=
> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;co=
nfig.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif def=
ined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span=
><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src=
/openvpn/sig.c b/src/openvpn/sig.c</span><br><span>index 05c0054..8b80aeb 1=
00644</span><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ b/src/ope=
nvpn/sig.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><s=
pan> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-=
msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #in=
clude &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/socket=
.c b/src/openvpn/socket.c</span><br><span>index fc643c1..91a6d53 100644</sp=
an><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/s=
ocket.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span=
> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msv=
c.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #inclu=
de &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/socks.c b=
/src/openvpn/socks.c</span><br><span>index 2cf0cc9..a29eb83 100644</span><b=
r><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/socks.c=
</span><br><span>@@ -31,8 +31,6 @@</span><br><span> </span><br><span> #ifde=
f HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quo=
t;</span><br><span> #endif</span><br><span> </span><br><span> #include &quo=
t;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/ssl.c b/src/open=
vpn/ssl.c</span><br><span>index 8641a51..c975dbc 100644</span><br><span>---=
 a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><spa=
n>@@ -36,8 +36,6 @@</span><br><span>  */</span><br><span> #ifdef HAVE_CONFI=
G_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><b=
r><span> #endif</span><br><span> </span><br><span> #include &quot;syshead.h=
&quot;</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn=
/ssl_mbedtls.c</span><br><span>index 49989d9..81dd906 100644</span><br><spa=
n>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbe=
dtls.c</span><br><span>@@ -29,8 +29,6 @@</span><br><span> </span><br><span>=
 #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc=
.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #includ=
e &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/ssl_ncp.c =
b/src/openvpn/ssl_ncp.c</span><br><span>index 22dbe21..dafaef1 100644</span=
><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ss=
l_ncp.c</span><br><span>@@ -37,8 +37,6 @@</span><br><span>  */</span><br><s=
pan> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-=
msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #in=
clude &quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/ssl_op=
enssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 65b36d1..0b310de =
100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ =
b/src/openvpn/ssl_openssl.c</span><br><span>@@ -28,8 +28,6 @@</span><br><sp=
an> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;=
config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif d=
efined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#incl=
ude &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </sp=
an><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/s=
rc/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><span>index 8b3391e.=
.afc5aab 100644</span><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><span=
>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -22,8 +22,6 @@</span><br><s=
pan>  */</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &q=
uot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
if defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
include &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> =
</span><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git=
 a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c</span><br><span>index e1=
2ed3d..bca6eed 100644</span><br><span>--- a/src/openvpn/ssl_util.c</span><b=
r><span>+++ b/src/openvpn/ssl_util.c</span><br><span>@@ -22,8 +22,6 @@</spa=
n><br><span>  */</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #in=
clude &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><br=
><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><span>di=
ff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><s=
pan>index 1b589f1..90416b6 100644</span><br><span>--- a/src/openvpn/ssl_ver=
ify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -28=
,8 +28,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><=
br><span> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #en=
dif</span><br><span> </span><br><span> #include &quot;syshead.h&quot;</span=
><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_=
verify_mbedtls.c</span><br><span>index e3437f7..a1ddf8d 100644</span><br><s=
pan>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvp=
n/ssl_verify_mbedtls.c</span><br><span>@@ -28,8 +28,6 @@</span><br><span> <=
/span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;confi=
g.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif define=
d(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><b=
r><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src/op=
envpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><sp=
an>index e24ce4e..3194c23 100644</span><br><span>--- a/src/openvpn/ssl_veri=
fy_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><=
br><span>@@ -28,8 +28,6 @@</span><br><span> </span><br><span> #ifdef HAVE_C=
ONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span=
><br><span> #endif</span><br><span> </span><br><span> #include &quot;syshea=
d.h&quot;</span><br><span>diff --git a/src/openvpn/status.c b/src/openvpn/s=
tatus.c</span><br><span>index 737f340..0cb4408 100644</span><br><span>--- a=
/src/openvpn/status.c</span><br><span>+++ b/src/openvpn/status.c</span><br>=
<span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONF=
IG_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> #include &quot;syshead=
.h&quot;</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn=
/tls_crypt.c</span><br><span>index 7354236..975d31f 100644</span><br><span>=
--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c=
</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifde=
f HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quo=
t;</span><br><span> #endif</span><br><span> </span><br><span> #include &quo=
t;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/tun.c b/src/open=
vpn/tun.c</span><br><span>index af959bb..6097420 100644</span><br><span>---=
 a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><spa=
n>@@ -31,8 +31,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H=
</span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><s=
pan> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&quo=
t;</span><br><span>diff --git a/src/openvpn/vcpkg.json b/src/openvpn/vcpkg.=
json</span><br><span>deleted file mode 100644</span><br><span>index 0afd802=
..0000000</span><br><span>--- a/src/openvpn/vcpkg.json</span><br><span>+++ =
/dev/null</span><br><span>@@ -1,15 +0,0 @@</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &quot;$schema&quot;: &quot;https://raw.githubusercontent.com/microsoft/v=
cpkg/master/scripts/vcpkg.schema.json&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &quot;name&quot;: &quot;openvpn&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &quot;version&quot;: &quot;2.6&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;depende=
ncies&quot;: [</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-       &quot;name&quot=
;: &quot;openssl&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-       &quot;features&quot;: [&quot;tools&quot;]</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     },</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &quot;tap-windows6&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &quot;lzo&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &quot;lz4&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &quot;pkcs11-helper&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  ]</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span>diff --git a/src/openvpn/vlan.c b/src/openvpn/=
vlan.c</span><br><span>index 2510042..0bb7abc 100644</span><br><span>--- a/=
src/openvpn/vlan.c</span><br><span>+++ b/src/openvpn/vlan.c</span><br><span=
>@@ -24,8 +24,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H<=
/span><br><span> #include &quot;config.h&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><sp=
an> #endif</span><br><span> </span><br><span> #include &quot;syshead.h&quot=
;</span><br><span>diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32=
-util.c</span><br><span>index 32f7a00..81e504a 100644</span><br><span>--- a=
/src/openvpn/win32-util.c</span><br><span>+++ b/src/openvpn/win32-util.c</s=
pan><br><span>@@ -28,8 +28,6 @@</span><br><span> </span><br><span> #ifdef H=
AVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;<=
/span><br><span> #endif</span><br><span> </span><br><span> #include &quot;s=
yshead.h&quot;</span><br><span>diff --git a/src/openvpn/win32.c b/src/openv=
pn/win32.c</span><br><span>index 25da54a..156ee74 100644</span><br><span>--=
- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br=
><span>@@ -28,8 +28,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CON=
FIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> #include &quot;syshead=
.h&quot;</span><br><span>diff --git a/src/openvpn/xkey_helper.c b/src/openv=
pn/xkey_helper.c</span><br><span>index ee9677a..40839f2 100644</span><br><s=
pan>--- a/src/openvpn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_=
helper.c</span><br><span>@@ -24,8 +24,6 @@</span><br><span> </span><br><spa=
n> #ifdef HAVE_CONFIG_H</span><br><span> #include &lt;config.h&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h=
&quot;</span><br><span> #endif</span><br><span> </span><br><span> #include =
&quot;syshead.h&quot;</span><br><span>diff --git a/src/openvpn/xkey_provide=
r.c b/src/openvpn/xkey_provider.c</span><br><span>index b0f414f..db316fe 10=
0644</span><br><span>--- a/src/openvpn/xkey_provider.c</span><br><span>+++ =
b/src/openvpn/xkey_provider.c</span><br><span>@@ -24,8 +24,6 @@</span><br><=
span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &lt;=
config.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif def=
ined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </span=
><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/src=
/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am</span><br><span>in=
dex d68a008..dc53f75 100644</span><br><span>--- a/src/openvpnmsica/Makefile=
.am</span><br><span>+++ b/src/openvpnmsica/Makefile.am</span><br><span>@@ -=
22,12 +22,6 @@</span><br><span> </span><br><span> MAINTAINERCLEANFILES =3D =
$(srcdir)/Makefile.in</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-EXTRA_DIST =3D \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	openvpnmsica.vcxproj \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	openvpnmsica.props \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	openvpnmsica-Debug.props \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	openvpnmsica-Release.props</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> AM_CPPFLAGS =3D \</span><br><s=
pan> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat</span><br><span> <=
/span><br><span>diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/=
dllmain.c</span><br><span>index 7cff41a..1bf3d56 100644</span><br><span>---=
 a/src/openvpnmsica/dllmain.c</span><br><span>+++ b/src/openvpnmsica/dllmai=
n.c</span><br><span>@@ -20,8 +20,6 @@</span><br><span> </span><br><span> #i=
fdef HAVE_CONFIG_H</span><br><span> #include &lt;config.h&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;config-msvc.h&gt;</s=
pan><br><span> #endif</span><br><span> </span><br><span> #include &quot;ope=
nvpnmsica.h&quot;</span><br><span>diff --git a/src/openvpnmsica/msica_arg.c=
 b/src/openvpnmsica/msica_arg.c</span><br><span>index ad6968f..d1eb404 1006=
44</span><br><span>--- a/src/openvpnmsica/msica_arg.c</span><br><span>+++ b=
/src/openvpnmsica/msica_arg.c</span><br><span>@@ -20,8 +20,6 @@</span><br><=
span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &lt;=
config.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif def=
ined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &lt;config-msvc.h&gt;</span><br><span> #endif</span><br><span> </span><br=
><span> #include &quot;msica_arg.h&quot;</span><br><span>diff --git a/src/o=
penvpnmsica/msiex.c b/src/openvpnmsica/msiex.c</span><br><span>index 3ea2c1=
a..78017eb 100644</span><br><span>--- a/src/openvpnmsica/msiex.c</span><br>=
<span>+++ b/src/openvpnmsica/msiex.c</span><br><span>@@ -20,8 +20,6 @@</spa=
n><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #inclu=
de &lt;config.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#include &lt;config-msvc.h&gt;</span><br><span> #endif</span><br><span> </s=
pan><br><span> #include &quot;msiex.h&quot;</span><br><span>diff --git a/sr=
c/openvpnmsica/openvpnmsica-Debug.props b/src/openvpnmsica/openvpnmsica-Deb=
ug.props</span><br><span>deleted file mode 100644</span><br><span>index 435=
32cf..0000000</span><br><span>--- a/src/openvpnmsica/openvpnmsica-Debug.pro=
ps</span><br><span>+++ /dev/null</span><br><span>@@ -1,14 +0,0 @@</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-&lt;?xml version=3D&quot;1.0&qu=
ot; encoding=3D&quot;utf-8&quot;?&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-&lt;Project ToolsVersion=3D&quot;4.0&quot; xmlns=3D&quot;ht=
tp://schemas.microsoft.com/developer/msbuild/2003&quot;&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;Prope=
rtySheets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;Import Project=3D&quot;openvpnmsica.props&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Us=
erMacros&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;PropertyGroup /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  &lt;ItemDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      &lt;RuntimeLibrary&gt;MultiThreadedDebug&lt;/RuntimeLibrar=
y&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompi=
le&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefi=
nitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;=
ItemGroup /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;/P=
roject&gt;</span><br><span>\ No newline at end of file</span><br><span>diff=
 --git a/src/openvpnmsica/openvpnmsica-Release.props b/src/openvpnmsica/ope=
nvpnmsica-Release.props</span><br><span>deleted file mode 100644</span><br>=
<span>index 47727b3..0000000</span><br><span>--- a/src/openvpnmsica/openvpn=
msica-Release.props</span><br><span>+++ /dev/null</span><br><span>@@ -1,15 =
+0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;?xml versi=
on=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-&lt;Project ToolsVersion=3D&quot;4.0&quot;=
 xmlns=3D&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot;&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup La=
bel=3D&quot;PropertySheets&quot;&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;Import Project=3D&quot;openvpnmsica.props&quot; /&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup=
 Label=3D&quot;UserMacros&quot; /&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;PropertyGroup /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      &lt;RuntimeLibrary&gt;MultiThreaded&lt;/R=
untimeLibrary&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGuard&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup /&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&gt;</span><br><sp=
an>\ No newline at end of file</span><br><span>diff --git a/src/openvpnmsic=
a/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</span><br><span>index 06=
c9789..e5312d6 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.c=
</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.c</span><br><span>@@ -=
20,8 +20,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span=
><br><span> #include &lt;config.h&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &lt;config-msvc.h&gt;</span><br><span> #endif</s=
pan><br><span> #include &lt;winsock2.h&gt; /* Must be included _before_ &lt=
;windows.h&gt; */</span><br><span> </span><br><span>diff --git a/src/openvp=
nmsica/openvpnmsica.props b/src/openvpnmsica/openvpnmsica.props</span><br><=
span>deleted file mode 100644</span><br><span>index 1091c9f..0000000</span>=
<br><span>--- a/src/openvpnmsica/openvpnmsica.props</span><br><span>+++ /de=
v/null</span><br><span>@@ -1,17 +0,0 @@</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;utf-8=
&quot;?&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;Projec=
t ToolsVersion=3D&quot;4.0&quot; xmlns=3D&quot;http://schemas.microsoft.com=
/developer/msbuild/2003&quot;&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quot; /&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=
=3D&quot;UserMacros&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  &lt;PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;TargetName&gt;lib$(ProjectName)&lt;/TargetName&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGro=
up&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompi=
le&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Prepr=
ocessorDefinitions&gt;_WIN32_WINNT=3D_WIN32_WINNT_VISTA;%(PreprocessorDefin=
itions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-      &lt;SubSystem&gt;Windows&lt;/SubSystem&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup /&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&gt;</span><br><s=
pan>\ No newline at end of file</span><br><span>diff --git a/src/openvpnmsi=
ca/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj</span><br><=
span>deleted file mode 100644</span><br><span>index c9154b3..0000000</span>=
<br><span>--- a/src/openvpnmsica/openvpnmsica.vcxproj</span><br><span>+++ /=
dev/null</span><br><span>@@ -1,208 +0,0 @@</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;ut=
f-8&quot;?&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;Pro=
ject DefaultTargets=3D&quot;Build&quot; ToolsVersion=3D&quot;15.0&quot; xml=
ns=3D&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot;&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup Label=3D=
&quot;ProjectConfigurations&quot;&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Debug|ARM64&qu=
ot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Conf=
iguration&gt;Debug&lt;/Configuration&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-      &lt;Platform&gt;ARM64&lt;/Platform&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfig=
uration Include=3D&quot;Debug|Win32&quot;&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform=
&gt;Win32&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Debug|x64&quo=
t;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Confi=
guration&gt;Debug&lt;/Configuration&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      &lt;Platform&gt;x64&lt;/Platform&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfigura=
tion Include=3D&quot;Release|ARM64&quot;&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Release&lt;/Configuration=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platfor=
m&gt;ARM64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Release|Win3=
2&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;=
Configuration&gt;Release&lt;/Configuration&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      &lt;Platform&gt;Win32&lt;/Platform&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfigurati=
on&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Project=
Configuration Include=3D&quot;Release|x64&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Release&lt;/Conf=
iguration&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &l=
t;Platform&gt;x64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Globals&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VCProjectVers=
ion&gt;15.0&lt;/VCProjectVersion&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;ProjectGuid&gt;{D41AA9D6-B818-476E-992E-0E16EB86BEE2=
}&lt;/ProjectGuid&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;RootNamespace&gt;openvpnmsica&lt;/RootNamesp=
ace&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Window=
sTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPlatformVersion&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&qu=
ot;$(VCTargetsPath)\Microsoft.Cpp.Default.props&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot=
;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; La=
bel=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;ConfigurationType&gt;DynamicLibrary&lt;/Configuration=
Type&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;UseDe=
bugLibraries&gt;true&lt;/UseDebugLibraries&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolse=
t&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Characte=
rSet&gt;Unicode&lt;/CharacterSet&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSDK=
DesktopARM64Support&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&=
quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;DynamicLibrary&lt;/Confi=
gurationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/Platfo=
rmToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;=
CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMiti=
gation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Prop=
ertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Pr=
opertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&=
#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Dynam=
icLibrary&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset=
&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spec=
tre&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Con=
figurationType&gt;DynamicLibrary&lt;/ConfigurationType&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;UseDebugLibraries&gt;false&lt;=
/UseDebugLibraries&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt;true=
&lt;/WholeProgramOptimization&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;WindowsSDKDesktopARM64Su=
pport&gt;true&lt;/WindowsSDKDesktopARM64Support&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/Sp=
ectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#3=
9;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Configuration=
Type&gt;DynamicLibrary&lt;/ConfigurationType&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;UseDebugLibraries&gt;false&lt;/UseDebugL=
ibraries&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;P=
latformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt;true&lt;/Whole=
ProgramOptimization&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/S=
pectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#=
39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationT=
ype&gt;DynamicLibrary&lt;/ConfigurationType&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;UseDebugLibraries&gt;false&lt;/UseDebugLi=
braries&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Pl=
atformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt;true&lt;/WholeP=
rogramOptimization&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/Sp=
ectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.props&quot; /&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup =
Label=3D&quot;ExtensionSettings&quot;&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;Shared&quot;&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D=
&quot;PropertySheets&quot; Condition=3D&quot;&#39;$(Configuration)|$(Platfo=
rm)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Micro=
soft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserR=
ootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;Loca=
lAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &lt;Import Project=3D&quot;..\compat\Debug.props&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D=
&quot;openvpnmsica-Debug.props&quot; /&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quot; =
Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Wi=
n32&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.p=
rops&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Pla=
tform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Proje=
ct=3D&quot;..\compat\Debug.props&quot; /&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;openvpnmsica-Debug.pr=
ops&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;=
/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt=
;ImportGroup Label=3D&quot;PropertySheets&quot; Condition=3D&quot;&#39;$(Co=
nfiguration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$=
(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;=
exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot;=
 Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Debug.pr=
ops&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;Import Project=3D&quot;openvpnmsica-Debug.props&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;Pr=
opertySheets&quot; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Release|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.C=
pp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir=
)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppDa=
taPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;Import Project=3D&quot;..\compat\Release.props&quot; /&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quo=
t;openvpnmsica-Release.props&quot; /&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quot; Co=
ndition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Wi=
n32&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.p=
rops&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Pla=
tform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Proje=
ct=3D&quot;..\compat\Release.props&quot; /&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;openvpnmsica-Releas=
e.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;ImportGroup Label=3D&quot;PropertySheets&quot; Condition=3D&quot;&#39;=
$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&=
quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D=
&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)=
&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Re=
lease.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;Import Project=3D&quot;openvpnmsica-Release.props&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Labe=
l=3D&quot;UserMacros&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;=
&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled&=
gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;&=
#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled=
&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;=
&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled&=
gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;&=
#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled=
&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;=
&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled&gt=
;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;&#3=
9;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;VcpkgEnabled&gt;=
true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(=
Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      &lt;CETCompat&gt;true&lt;/CETCompat&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&=
gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLC=
heck&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCo=
mpile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemD=
efinitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&=
#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      &lt;CETCompat&gt;true&lt;/CETCompat&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SHA=
_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitio=
nGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemD=
efinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Debug|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions=
)&lt;/AdditionalOptions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39=
;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Cl=
Compile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;=
AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLChec=
k&gt;true&lt;/SDLCheck&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SH=
A_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitio=
nGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemD=
efinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Debug|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&=
lt;/AdditionalOptions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;..\tapc=
tl\error.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;ClCompile Include=3D&quot;..\tapctl\tap.c&quot; /&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;=
dllmain.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;ClCompile Include=3D&quot;msiex.c&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;msica_arg=
.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;ClCompile Include=3D&quot;openvpnmsica.c&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;..\tapctl=
\basic.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ClInclude Include=3D&quot;..\tapctl\error.h&quot; /&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;=
..\tapctl\tap.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;ClInclude Include=3D&quot;msiex.h&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;msi=
ca_arg.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ClInclude Include=3D&quot;openvpnmsica.h&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;ResourceCompile Include=3D&quot;=
openvpnmsica_resources.rc&quot; /&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;ProjectReference Include=3D&quot;..\..\build\msvc\msvc=
-generate\msvc-generate.vcxproj&quot;&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      &lt;Project&gt;{8598c2c8-34c4-47a1-99b0-7c295a890=
615}&lt;/Project&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     &lt;ReferenceOutputAssembly&gt;false&lt;/ReferenceOutputAssembly&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectReferen=
ce&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGrou=
p&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Pro=
ject=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targets&quot; /&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;E=
xtensionTargets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-&lt;/Project&gt;</span><br><span>\ No newline at end of file</span><br=
><span>diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvp=
nmsica/openvpnmsica_resources.rc</span><br><span>index d7c14de..e30c8a1 100=
644</span><br><span>--- a/src/openvpnmsica/openvpnmsica_resources.rc</span>=
<br><span>+++ b/src/openvpnmsica/openvpnmsica_resources.rc</span><br><span>=
@@ -19,8 +19,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</=
span><br><span> #include &lt;config.h&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#include &lt;config-msvc-version.h&gt;</span><br><span> #endif</span><b=
r><span> #include &lt;winresrc.h&gt;</span><br><span> </span><br><span>diff=
 --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am</span><b=
r><span>index 4c0ac40..d8ba4eb 100644</span><br><span>--- a/src/openvpnserv=
/Makefile.am</span><br><span>+++ b/src/openvpnserv/Makefile.am</span><br><s=
pan>@@ -13,9 +13,6 @@</span><br><span> </span><br><span> MAINTAINERCLEANFIL=
ES =3D $(srcdir)/Makefile.in</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-EXTRA_DIST =3D \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	openvpnserv.vcxproj</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> AM_CPPFLAGS =3D \</span><br><span> 	-I=
$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compa=
t</span><br><span> </span><br><span>diff --git a/src/openvpnserv/openvpnser=
v.vcxproj b/src/openvpnserv/openvpnserv.vcxproj</span><br><span>deleted fil=
e mode 100644</span><br><span>index db3a446..0000000</span><br><span>--- a/=
src/openvpnserv/openvpnserv.vcxproj</span><br><span>+++ /dev/null</span><br=
><span>@@ -1,229 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-=EF=BB=BF&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;=
?&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;Project Defa=
ultTargets=3D&quot;Build&quot; ToolsVersion=3D&quot;15.0&quot; xmlns=3D&quo=
t;http://schemas.microsoft.com/developer/msbuild/2003&quot;&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup Label=3D&quot;Pro=
jectConfigurations&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &lt;ProjectConfiguration Include=3D&quot;Debug|ARM64&quot;&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration=
&gt;Debug&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      &lt;Platform&gt;ARM64&lt;/Platform&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration I=
nclude=3D&quot;Debug|Win32&quot;&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;Win32=
&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;ProjectConfiguration Include=3D&quot;Debug|x64&quot;&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configuration&=
gt;Debug&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      &lt;Platform&gt;x64&lt;/Platform&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfiguration In=
clude=3D&quot;Release|ARM64&quot;&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;Configuration&gt;Release&lt;/Configuration&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;AR=
M64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Release|Win32&quot;=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configu=
ration&gt;Release&lt;/Configuration&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      &lt;Platform&gt;Win32&lt;/Platform&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfigu=
ration Include=3D&quot;Release|x64&quot;&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Release&lt;/Configuration=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platfor=
m&gt;x64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Globals&quot;&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectGuid&gt;{9C91EE=
0B-817D-420A-A1E6-15A5A9D98BAD}&lt;/ProjectGuid&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;RootNamespace&gt;openvpnserv&lt;/Ro=
otNamespace&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &l=
t;Keyword&gt;Win32Proj&lt;/Keyword&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTa=
rgetPlatformVersion&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Default.pr=
ops&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;=
PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&=
gt;Application&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptim=
ization&gt;true&lt;/WholeProgramOptimization&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformTool=
set&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Spectr=
eMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;=
$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D=
&quot;Configuration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;ConfigurationType&gt;Application&lt;/ConfigurationType&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterSet&g=
t;Unicode&lt;/CharacterSet&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOptimizat=
ion&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Platfo=
rmToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigat=
ion&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Propert=
yGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Prope=
rtyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39=
;Release|ARM64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Appl=
ication&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization=
&gt;true&lt;/WholeProgramOptimization&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitiga=
tion&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configu=
ration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Con=
figuration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ConfigurationType&gt;Application&lt;/ConfigurationType&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;Unicode=
&lt;/CharacterSet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/=
SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&=
#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationTy=
pe&gt;Application&lt;/ConfigurationType&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolse=
t&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup=
 Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|A=
RM64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Application&lt=
;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/Platfo=
rmToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;=
SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&quot;$(VCTarget=
sPath)\Microsoft.Cpp.props&quot; /&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup C=
ondition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|W=
in32&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootD=
ir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#3=
9;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&=
quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Release.props&quot=
; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportG=
roup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportG=
roup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Rel=
ease|x64&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserR=
ootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists=
(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=
=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Release.props&=
quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Imp=
ortGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Imp=
ortGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39=
;Release|ARM64&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$=
(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;=
exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot;=
 Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Release.=
props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &l=
t;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&q=
uot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&=
quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&=
quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\De=
bug.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&=
quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D=
&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)=
&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\De=
bug.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;PropertySheets&quot;&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=
=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&quot; Conditio=
n=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#=
39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compa=
t\Debug.props&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  &lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;_ProjectFileVersion&gt;10=
.0.30319.1&lt;/_ProjectFileVersion&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&=
quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vcpk=
gEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39=
;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vc=
pkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Conditio=
n=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;=
&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vcp=
kgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39=
;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vc=
pkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Conditio=
n=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&q=
uot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vcpkg=
Enabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&=
quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vcpk=
gEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Confi=
guration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirect=
ories&gt;..\openvpn;..\compat;%(AdditionalIncludeDirectories)&lt;/Additiona=
lIncludeDirectories&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      &lt;PreprocessorDefinitions&gt;_CONSOLE;%(PreprocessorDefinitions)&=
lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SHA_256 =
%(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;ResourceCompile /&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      &lt;AdditionalDependencies&gt;Userenv.li=
b;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(Additional=
Dependencies)&lt;/AdditionalDependencies&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinition=
Group Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;De=
bug|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      &lt;AdditionalIncludeDirectories&gt;..\openvpn;..\compat;%(Additiona=
lIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      &lt;PreprocessorDefinitions&gt;_C=
ONSOLE;%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/=
SDLCheck&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt=
;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOption=
s&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompi=
le&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Resourc=
eCompile /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;Link&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Ad=
ditionalDependencies&gt;legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.l=
ib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies=
)&lt;/AdditionalDependencies&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condit=
ion=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#3=
9;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;C=
lCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt=
;AdditionalIncludeDirectories&gt;..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)&lt;/AdditionalIncludeDirectories&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-      &lt;PreprocessorDefinitions&gt;_CONSOLE;%(P=
reprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Additiona=
lOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ResourceCompile /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalDe=
pendencies&gt;legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.l=
ib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)&lt;/Addi=
tionalDependencies&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quo=
t;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Additio=
nalIncludeDirectories&gt;..\openvpn;..\compat;%(AdditionalIncludeDirectorie=
s)&lt;/AdditionalIncludeDirectories&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preproces=
sorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions=
&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ResourceCompile /&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalDependenci=
es&gt;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.=
lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      &lt;SubSystem&gt;Console&lt;/S=
ubSystem&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt=
;CETCompat&gt;true&lt;/CETCompat&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirec=
tories&gt;..\openvpn;..\compat;%(AdditionalIncludeDirectories)&lt;/Addition=
alIncludeDirectories&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      &lt;PreprocessorDefinitions&gt;_CONSOLE;%(PreprocessorDefinitions)=
&lt;/PreprocessorDefinitions&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SHA_256=
 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;ResourceCompile /&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalDependencies&gt;legacy_=
stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netap=
i32.lib;Shlwapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;SubSystem&=
gt;Console&lt;/SubSystem&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      &lt;CETCompat&gt;true&lt;/CETCompat&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D=
&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&q=
uot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCom=
pile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Add=
itionalIncludeDirectories&gt;..\openvpn;..\compat;%(AdditionalIncludeDirect=
ories)&lt;/AdditionalIncludeDirectories&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-      &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepr=
ocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalO=
ptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ResourceCompile /&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalDepe=
ndencies&gt;legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib=
;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)&lt;/Additi=
onalDependencies&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;common.c&=
quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Cl=
Compile Include=3D&quot;interactive.c&quot; /&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;service.c&quo=
t; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCom=
pile Include=3D&quot;validate.c&quot; /&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;..\openvpn\block_dn=
s.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;=
/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;I=
temGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;C=
lInclude Include=3D&quot;..\openvpn\ring_buffer.h&quot; /&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;s=
ervice.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;ClInclude Include=3D&quot;validate.h&quot; /&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&quot;..\open=
vpn\block_dns.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  &lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &lt;ResourceCompile Include=3D&quot;openvpnserv_resources.rc&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectRefer=
ence Include=3D&quot;..\..\build\msvc\msvc-generate\msvc-generate.vcxproj&q=
uot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Pro=
ject&gt;{8598c2c8-34c4-47a1-99b0-7c295a890615}&lt;/Project&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      &lt;ReferenceOutputAssembly&=
gt;false&lt;/ReferenceOutputAssembly&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &lt;/ProjectReference&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  &lt;Import Project=3D&quot;$(VCTargetsPath)\Mic=
rosoft.Cpp.targets&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  &lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&gt;</span><br><=
span>\ No newline at end of file</span><br><span>diff --git a/src/openvpnse=
rv/openvpnserv_resources.rc b/src/openvpnserv/openvpnserv_resources.rc</spa=
n><br><span>index 4ea453e..ddd0cb8 100644</span><br><span>--- a/src/openvpn=
serv/openvpnserv_resources.rc</span><br><span>+++ b/src/openvpnserv/openvpn=
serv_resources.rc</span><br><span>@@ -1,7 +1,5 @@</span><br><span> #ifdef H=
AVE_CONFIG_H</span><br><span> #include &lt;config.h&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &lt;config-msvc-version.h&gt;</span><br><span> #=
endif</span><br><span> #include &lt;winresrc.h&gt;</span><br><span> </span>=
<br><span>diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.=
h</span><br><span>index fc5ecda..d38a665 100644</span><br><span>--- a/src/o=
penvpnserv/service.h</span><br><span>+++ b/src/openvpnserv/service.h</span>=
<br><span>@@ -31,8 +31,6 @@</span><br><span> </span><br><span> #ifdef HAVE_=
CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;</spa=
n><br><span> #endif</span><br><span> </span><br><span> #include &lt;winsock=
2.h&gt;</span><br><span>diff --git a/src/tapctl/Makefile.am b/src/tapctl/Ma=
kefile.am</span><br><span>index fe8ab2a..69ea161 100644</span><br><span>---=
 a/src/tapctl/Makefile.am</span><br><span>+++ b/src/tapctl/Makefile.am</spa=
n><br><span>@@ -22,11 +22,6 @@</span><br><span> </span><br><span> MAINTAINE=
RCLEANFILES =3D $(srcdir)/Makefile.in</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-EXTRA_DIST =3D \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	tapctl.vcxproj \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	tapctl.props \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	tapctl.exe.manifest</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> AM_CPPFLAGS =3D \</span><br><span> 	-I$=
(top_srcdir)/include -I$(top_srcdir)/src/compat</span><br><span> </span><br=
><span>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>i=
ndex d76d553..a946c2c 100644</span><br><span>--- a/src/tapctl/main.c</span>=
<br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -21,8 +21,6 @@</span><=
br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include =
&lt;config.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif=
 defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#in=
clude &lt;config-msvc.h&gt;</span><br><span> #endif</span><br><span> </span=
><br><span> #include &quot;tap.h&quot;</span><br><span>diff --git a/src/tap=
ctl/tap.c b/src/tapctl/tap.c</span><br><span>index 44fcdde..5ae8044 100644<=
/span><br><span>--- a/src/tapctl/tap.c</span><br><span>+++ b/src/tapctl/tap=
.c</span><br><span>@@ -20,8 +20,6 @@</span><br><span> </span><br><span> #if=
def HAVE_CONFIG_H</span><br><span> #include &lt;config.h&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#include &lt;config-msvc.h&gt;</sp=
an><br><span> #endif</span><br><span> </span><br><span> #include &quot;tap.=
h&quot;</span><br><span>diff --git a/src/tapctl/tapctl.props b/src/tapctl/t=
apctl.props</span><br><span>deleted file mode 100644</span><br><span>index =
0257b9f..0000000</span><br><span>--- a/src/tapctl/tapctl.props</span><br><s=
pan>+++ /dev/null</span><br><span>@@ -1,18 +0,0 @@</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-&lt;?xml version=3D&quot;1.0&quot; encoding=3D=
&quot;utf-8&quot;?&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-&lt;Project ToolsVersion=3D&quot;4.0&quot; xmlns=3D&quot;http://schemas.mi=
crosoft.com/developer/msbuild/2003&quot;&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quot;=
 /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyG=
roup Label=3D&quot;UserMacros&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;PropertyGroup&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &lt;GenerateManifest&gt;false&lt;/GenerateManifes=
t&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/PropertyG=
roup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDef=
initionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 &lt;PreprocessorDefinitions&gt;_CONSOLE;_WIN32_WINNT=3D_WIN32_WINNT_VISTA;=
%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalIncludeDirectories=
&gt;..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)&l=
t;/AdditionalIncludeDirectories&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;Link&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      &lt;SubSystem&gt;Console&lt;/SubSystem&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup /&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-&lt;/Project&gt;</span><br><span>=
\ No newline at end of file</span><br><span>diff --git a/src/tapctl/tapctl.=
vcxproj b/src/tapctl/tapctl.vcxproj</span><br><span>deleted file mode 10064=
4</span><br><span>index 6311d7f..0000000</span><br><span>--- a/src/tapctl/t=
apctl.vcxproj</span><br><span>+++ /dev/null</span><br><span>@@ -1,205 +0,0 =
@@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&lt;?xml version=3D=
&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-&lt;Project DefaultTargets=3D&quot;Build&quot; =
ToolsVersion=3D&quot;15.0&quot; xmlns=3D&quot;http://schemas.microsoft.com/=
developer/msbuild/2003&quot;&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  &lt;ItemGroup Label=3D&quot;ProjectConfigurations&quot;&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfigura=
tion Include=3D&quot;Debug|ARM64&quot;&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt=
;ARM64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Debug|Win32&quot=
;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Config=
uration&gt;Debug&lt;/Configuration&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      &lt;Platform&gt;Win32&lt;/Platform&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfigur=
ation Include=3D&quot;Debug|x64&quot;&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      &lt;Configuration&gt;Debug&lt;/Configuration&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platform&gt;=
x64&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Release|ARM64&quot;=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Configu=
ration&gt;Release&lt;/Configuration&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      &lt;Platform&gt;ARM64&lt;/Platform&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectConfigu=
ration Include=3D&quot;Release|Win32&quot;&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      &lt;Configuration&gt;Release&lt;/Configurati=
on&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Platf=
orm&gt;Win32&lt;/Platform&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;/ProjectConfiguration&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;ProjectConfiguration Include=3D&quot;Release|x6=
4&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;=
Configuration&gt;Release&lt;/Configuration&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      &lt;Platform&gt;x64&lt;/Platform&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ProjectConfiguration=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGrou=
p Label=3D&quot;Globals&quot;&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;VCProjectVersion&gt;15.0&lt;/VCProjectVersion&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectGuid&gt;{A06=
436E7-D576-490D-8BA0-0751D920334A}&lt;/ProjectGuid&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;Keyword&gt;Win32Proj&lt;/Keyword&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;RootNamespa=
ce&gt;tapctl&lt;/RootNamespace&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTarget=
PlatformVersion&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Default.props&=
quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Prop=
ertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#3=
9;Debug|ARM64&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt;Appli=
cation&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformToolset&gt=
;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    &lt;WindowsSDKDesktopARM64Suppor=
t&gt;true&lt;/WindowsSDKDesktopARM64Support&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Spectre&lt;/SpectreM=
itigation&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/P=
ropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt=
;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=
=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&quot;&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ConfigurationType&gt=
;Application&lt;/ConfigurationType&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;PlatformTool=
set&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;S=
pectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$=
(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&=
quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Conf=
igurationType&gt;Application&lt;/ConfigurationType&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;UseDebugLibraries&gt;true&lt;/UseD=
ebugLibraries&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/Charact=
erSet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Spec=
treMitigation&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;=
$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=
=3D&quot;Configuration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &lt;ConfigurationType&gt;Application&lt;/ConfigurationType&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;UseDebugLib=
raries&gt;false&lt;/UseDebugLibraries&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramO=
ptimization&gt;true&lt;/WholeProgramOptimization&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/Charact=
erSet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Wind=
owsSDKDesktopARM64Support&gt;true&lt;/WindowsSDKDesktopARM64Support&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation=
&gt;Spectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configurati=
on)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Confi=
guration&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;ConfigurationType&gt;Application&lt;/ConfigurationType&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;UseDebugLibraries&gt;fals=
e&lt;/UseDebugLibraries&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt=
;true&lt;/WholeProgramOptimization&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&g=
t;Spectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configura=
tion&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt=
;ConfigurationType&gt;Application&lt;/ConfigurationType&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &lt;UseDebugLibraries&gt;false&lt=
;/UseDebugLibraries&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &lt;PlatformToolset&gt;v143&lt;/PlatformToolset&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;WholeProgramOptimization&gt;tru=
e&lt;/WholeProgramOptimization&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;SpectreMitigation&gt;Sp=
ectre&lt;/SpectreMitigation&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.pr=
ops&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;=
ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;Shared&quo=
t;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGr=
oup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGr=
oup Label=3D&quot;PropertySheets&quot; Condition=3D&quot;&#39;$(Configurati=
on)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRo=
otDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(=
&#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=
=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Debug.props&qu=
ot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Impo=
rt Project=3D&quot;tapctl.props&quot; /&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quot;=
 Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|W=
in32&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.=
props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Pl=
atform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Proj=
ect=3D&quot;..\compat\Debug.props&quot; /&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;tapctl.props&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGrou=
p&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGrou=
p Label=3D&quot;PropertySheets&quot; Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRootDi=
r)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39=
;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&q=
uot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Debug.props&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Pr=
oject=3D&quot;tapctl.props&quot; /&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quot; Cond=
ition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM6=
4&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(Platf=
orm).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=
=3D&quot;..\compat\Release.props&quot; /&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;tapctl.props&quot; /&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ImportGroup=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup=
 Label=3D&quot;PropertySheets&quot; Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;$(UserRoo=
tDir)\Microsoft.Cpp.$(Platform).user.props&quot; Condition=3D&quot;exists(&=
#39;$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=
=3D&quot;LocalAppDataPlatform&quot; /&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;..\compat\Release.props&=
quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Im=
port Project=3D&quot;tapctl.props&quot; /&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;/ImportGroup&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;PropertySheets&quo=
t; Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Relea=
se|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp.$(Platform).use=
r.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\Microsoft.Cpp.$(=
Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppDataPlatform&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Import Pr=
oject=3D&quot;..\compat\Release.props&quot; /&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &lt;Import Project=3D&quot;tapctl.props&quo=
t; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/Import=
Group&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Proper=
tyGroup Label=3D&quot;UserMacros&quot; /&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condit=
ion=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#3=
9;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;V=
cpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Conditi=
on=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#=
39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;=
VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condit=
ion=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#3=
9;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;V=
cpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Conditi=
on=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#=
39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;=
VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condit=
ion=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;=
&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vcp=
kgEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=
=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&=
quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Vcpk=
gEnabled&gt;true&lt;/VcpkgEnabled&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;/PropertyGroup&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Confi=
guration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SD=
LCheck&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;A=
dditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefini=
tionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;It=
emDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=
=3D=3D&#39;Release|ARM64&#39;&quot;&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:=
SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGroup Condit=
ion=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#3=
9;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;C=
lCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt=
;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions=
)&lt;/AdditionalOptions&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &lt;/ClCompile&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDL=
Check&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Ad=
ditionalOptions&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;Link&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;CETCompat&gt;=
true&lt;/CETCompat&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &lt;/Link&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;/ItemDefinitionGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOption=
s&gt;/ZH:SHA_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemDefinitionGro=
up Condition=3D&quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Relea=
se|x64&#39;&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;Link&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 &lt;CETCompat&gt;true&lt;/CETCompat&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &lt;/Link&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;ClCompile&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      &lt;AdditionalOptions&gt;/ZH:SHA=
_256 %(AdditionalOptions)&lt;/AdditionalOptions&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;/ClCompile&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemDefinitionGroup&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;e=
rror.c&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &lt;ClCompile Include=3D&quot;tap.c&quot; /&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &lt;ClCompile Include=3D&quot;main.c&quot; /=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude In=
clude=3D&quot;basic.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;ClInclude Include=3D&quot;error.h&quot; /&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ClInclude Include=3D&qu=
ot;tap.h&quot; /&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;ResourceCompile Include=3D&quot;tapctl_resources.rc&quot; /&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;ItemGroup&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;ProjectReference Include=
=3D&quot;..\..\build\msvc\msvc-generate\msvc-generate.vcxproj&quot;&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;Project&gt;{859=
8c2c8-34c4-47a1-99b0-7c295a890615}&lt;/Project&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      &lt;ReferenceOutputAssembly&gt;false&lt;=
/ReferenceOutputAssembly&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &lt;/ProjectReference&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;/ItemGroup&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  &lt;ItemGroup&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &lt;Manifest Include=3D&quot;tapctl.exe.manifest&quot; /&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/ItemGroup&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;Import Project=
=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targets&quot; /&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &lt;ImportGroup Label=3D&quot;Exten=
sionTargets&quot;&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  &lt;/ImportGroup&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-&lt;/Project&gt;</span><br><span>\ No newline at end of file</span><br><sp=
an>diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resource=
s.rc</span><br><span>index fc65b5a..c49f82d 100644</span><br><span>--- a/sr=
c/tapctl/tapctl_resources.rc</span><br><span>+++ b/src/tapctl/tapctl_resour=
ces.rc</span><br><span>@@ -19,8 +19,6 @@</span><br><span> </span><br><span>=
 #ifdef HAVE_CONFIG_H</span><br><span> #include &lt;config.h&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#include &lt;config-msvc-version.h&gt;</span><br=
><span> #endif</span><br><span> #include &lt;winresrc.h&gt;</span><br><span=
> </span><br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests=
/unit_tests/openvpn/mock_msg.c</span><br><span>index 3fa9a16..3ff1ea8 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>@@ -23,8 +23,6 @=
@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> =
#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span>=
<br><span> </span><br><span> #include &lt;stdarg.h&gt;</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/open=
vpn/test_auth_token.c</span><br><span>index 57e98f5..d96984f 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>@@ -23,8 +2=
3,6 @@</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><s=
pan> #include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</=
span><br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_test=
s/openvpn/test_buffer.c</span><br><span>index 9e3b1d2..92ac77a 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -23,8 +23,6 @@=
</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #=
include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><=
br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c</span><br><span>index aec4e04..58eebc0 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -23,8 +23,6 @@</span=
><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #includ=
e &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><sp=
an> </span><br><span> #include &quot;syshead.h&quot;</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn=
/test_cryptoapi.c</span><br><span>index 0859b58..7b38e18 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>@@ -24,8 +24,6 @@=
</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #=
include &quot;config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;config-msvc.h&quot;</span><br><span> #endif</span><=
br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c</span><br><span>index 5a8978d..43ae96b 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_misc.c</span><br><span>@@ -23,8 +23,6 @@</span><br><sp=
an> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;=
config.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif d=
efined(_MSC_VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#incl=
ude &quot;config-msvc.h&quot;</span><br><span> #endif</span><br><span> </sp=
an><br><span> #include &quot;syshead.h&quot;</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c</s=
pan><br><span>index 0e52ea2..72a1c3b 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_ncp.c</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_ncp.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><sp=
an> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-m=
svc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #inc=
lude &quot;syshead.h&quot;</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</span><b=
r><span>index 9b653a8..90c67ac 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_packet_id.c</span><br><span>@@ -24,8 +24,6 @@</span><br><span> </span><=
br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_=
VER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;co=
nfig-msvc.h&quot;</span><br><span> #endif</span><br><span> </span><br><span=
> #include &quot;syshead.h&quot;</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><spa=
n>index eb69829..9f49ee7 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</s=
pan><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> #ifdef H=
AVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot;<=
/span><br><span> #endif</span><br><span> </span><br><span> #include &quot;s=
yshead.h&quot;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_p=
rovider.c b/tests/unit_tests/openvpn/test_provider.c</span><br><span>index =
255067c..335fca2 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_provider.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_provider.c<=
/span><br><span>@@ -24,8 +24,6 @@</span><br><span> </span><br><span> #ifdef=
 HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.h&quot=
;</span><br><span> #endif</span><br><span> </span><br><span> #include &quot=
;syshead.h&quot;</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>in=
dex 8bbe600..ed7c794 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_cr=
ypt.c</span><br><span>@@ -23,8 +23,6 @@</span><br><span> </span><br><span> =
#ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(_MSC_VER)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config-msvc.=
h&quot;</span><br><span> #endif</span><br><span> </span><br><span> #include=
 &quot;syshead.h&quot;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/316?usp=3Demail">change 316=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/316?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807cffa40f18faa1adec4e15e84=
c032877a2b92e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 316 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--DNHVEW2nt3Y=--

