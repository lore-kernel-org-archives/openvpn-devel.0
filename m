From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 20 Jun 2023 15:53:08 +0200
Message-Id: <20230620135310.94455-4-frank@...2641...>
In-Reply-To: <20230620135310.94455-1-frank@...2641...>
References: <20230509111205.138997-1-frank@...2641...>
 <20230620135310.94455-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 3/5] Remove all traces of the previous
 MSVC build system
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Completely replaced by the CMake build system now.

v3:
 - rebase on top of my dist fixes

Change-Id: I807cffa40f18faa1adec4e15e84c032877a2b92e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .gitignore                                    |  11 -
 Makefile.am                                   |   7 +-
 build/Makefile.am                             |   2 -
 build/msvc/Makefile.am                        |  15 -
 build/msvc/msvc-generate/Makefile.am          |  20 -
 build/msvc/msvc-generate/Makefile.mak         |  67 ---
 build/msvc/msvc-generate/git-version.py       |  75 ---
 build/msvc/msvc-generate/msvc-generate.js     | 118 -----
 .../msvc/msvc-generate/msvc-generate.vcxproj  | 158 ------
 build/msvc/msvc-generate/version.m4.in        |   3 -
 config-msvc-version.h.in                      |  14 -
 config-msvc.h                                 |  93 ----
 configure.ac                                  |   2 -
 openvpn.sln                                   | 107 ----
 src/compat/Debug.props                        |  21 -
 src/compat/Makefile.am                        |   6 -
 src/compat/PropertySheet.props                |  29 --
 src/compat/Release.props                      |  26 -
 src/compat/compat-basename.c                  |   2 -
 src/compat/compat-daemon.c                    |   2 -
 src/compat/compat-dirname.c                   |   2 -
 src/compat/compat-gettimeofday.c              |   2 -
 src/compat/compat-strsep.c                    |   2 -
 src/compat/compat.vcxproj                     | 179 -------
 src/openvpn/Makefile.am                       |   4 +-
 src/openvpn/argv.c                            |   2 -
 src/openvpn/auth_token.c                      |   2 -
 src/openvpn/base64.c                          |   2 -
 src/openvpn/block_dns.c                       |   2 -
 src/openvpn/buffer.c                          |   2 -
 src/openvpn/clinat.c                          |   2 -
 src/openvpn/comp-lz4.c                        |   2 -
 src/openvpn/comp.c                            |   2 -
 src/openvpn/compstub.c                        |   2 -
 src/openvpn/console.c                         |   2 -
 src/openvpn/console_builtin.c                 |   2 -
 src/openvpn/crypto.c                          |   2 -
 src/openvpn/crypto_mbedtls.c                  |   2 -
 src/openvpn/crypto_openssl.c                  |   2 -
 src/openvpn/cryptoapi.c                       |   2 -
 src/openvpn/dco.c                             |   2 -
 src/openvpn/dco_freebsd.c                     |   2 -
 src/openvpn/dco_linux.c                       |   2 -
 src/openvpn/dco_win.c                         |   2 -
 src/openvpn/dhcp.c                            |   2 -
 src/openvpn/dns.c                             |   2 -
 src/openvpn/env_set.c                         |   2 -
 src/openvpn/error.c                           |   2 -
 src/openvpn/event.c                           |   2 -
 src/openvpn/fdmisc.c                          |   2 -
 src/openvpn/forward.c                         |   2 -
 src/openvpn/fragment.c                        |   2 -
 src/openvpn/gremlin.c                         |   2 -
 src/openvpn/helper.c                          |   2 -
 src/openvpn/httpdigest.c                      |   2 -
 src/openvpn/init.c                            |   2 -
 src/openvpn/interval.c                        |   2 -
 src/openvpn/list.c                            |   2 -
 src/openvpn/lladdr.c                          |   2 -
 src/openvpn/lzo.c                             |   2 -
 src/openvpn/manage.c                          |   2 -
 src/openvpn/mbuf.c                            |   2 -
 src/openvpn/misc.c                            |   2 -
 src/openvpn/mroute.c                          |   2 -
 src/openvpn/mss.c                             |   2 -
 src/openvpn/mstats.c                          |   2 -
 src/openvpn/mtcp.c                            |   2 -
 src/openvpn/mtu.c                             |   2 -
 src/openvpn/mudp.c                            |   2 -
 src/openvpn/multi.c                           |   2 -
 src/openvpn/networking_freebsd.c              |   2 -
 src/openvpn/networking_iproute2.c             |   2 -
 src/openvpn/networking_sitnl.c                |   2 -
 src/openvpn/ntlm.c                            |   2 -
 src/openvpn/occ.c                             |   2 -
 src/openvpn/openssl_compat.h                  |   2 -
 src/openvpn/openvpn.c                         |   2 -
 src/openvpn/openvpn.vcxproj                   | 470 ------------------
 src/openvpn/openvpn_win32_resources.rc        |   2 -
 src/openvpn/options.c                         |   2 -
 src/openvpn/options_util.c                    |   2 -
 src/openvpn/otime.c                           |   2 -
 src/openvpn/packet_id.c                       |   2 -
 src/openvpn/perf.c                            |   2 -
 src/openvpn/ping.c                            |   2 -
 src/openvpn/pkcs11.c                          |   2 -
 src/openvpn/pkcs11_mbedtls.c                  |   2 -
 src/openvpn/pkcs11_openssl.c                  |   2 -
 src/openvpn/platform.c                        |   2 -
 src/openvpn/plugin.c                          |   2 -
 src/openvpn/pool.c                            |   2 -
 src/openvpn/proto.c                           |   2 -
 src/openvpn/proxy.c                           |   2 -
 src/openvpn/ps.c                              |   2 -
 src/openvpn/push.c                            |   2 -
 src/openvpn/reflect_filter.c                  |   2 -
 src/openvpn/reliable.c                        |   2 -
 src/openvpn/route.c                           |   2 -
 src/openvpn/run_command.c                     |   2 -
 src/openvpn/schedule.c                        |   2 -
 src/openvpn/session_id.c                      |   2 -
 src/openvpn/shaper.c                          |   2 -
 src/openvpn/sig.c                             |   2 -
 src/openvpn/socket.c                          |   2 -
 src/openvpn/socks.c                           |   2 -
 src/openvpn/ssl.c                             |   2 -
 src/openvpn/ssl_mbedtls.c                     |   2 -
 src/openvpn/ssl_ncp.c                         |   2 -
 src/openvpn/ssl_openssl.c                     |   2 -
 src/openvpn/ssl_pkt.c                         |   2 -
 src/openvpn/ssl_util.c                        |   2 -
 src/openvpn/ssl_verify.c                      |   2 -
 src/openvpn/ssl_verify_mbedtls.c              |   2 -
 src/openvpn/ssl_verify_openssl.c              |   2 -
 src/openvpn/status.c                          |   2 -
 src/openvpn/tls_crypt.c                       |   2 -
 src/openvpn/tun.c                             |   2 -
 src/openvpn/vcpkg.json                        |  15 -
 src/openvpn/vlan.c                            |   2 -
 src/openvpn/win32-util.c                      |   2 -
 src/openvpn/win32.c                           |   2 -
 src/openvpn/xkey_helper.c                     |   2 -
 src/openvpn/xkey_provider.c                   |   2 -
 src/openvpnmsica/Makefile.am                  |   6 -
 src/openvpnmsica/dllmain.c                    |   2 -
 src/openvpnmsica/msica_arg.c                  |   2 -
 src/openvpnmsica/msiex.c                      |   2 -
 src/openvpnmsica/openvpnmsica-Debug.props     |  14 -
 src/openvpnmsica/openvpnmsica-Release.props   |  15 -
 src/openvpnmsica/openvpnmsica.c               |   2 -
 src/openvpnmsica/openvpnmsica.props           |  17 -
 src/openvpnmsica/openvpnmsica.vcxproj         | 208 --------
 src/openvpnmsica/openvpnmsica_resources.rc    |   2 -
 src/openvpnserv/Makefile.am                   |   3 -
 src/openvpnserv/openvpnserv.vcxproj           | 229 ---------
 src/openvpnserv/openvpnserv_resources.rc      |   2 -
 src/openvpnserv/service.h                     |   2 -
 src/tapctl/Makefile.am                        |   5 -
 src/tapctl/main.c                             |   2 -
 src/tapctl/tap.c                              |   2 -
 src/tapctl/tapctl.props                       |  18 -
 src/tapctl/tapctl.vcxproj                     | 205 --------
 src/tapctl/tapctl_resources.rc                |   2 -
 tests/unit_tests/openvpn/mock_msg.c           |   2 -
 tests/unit_tests/openvpn/pkey_test_utils.c    |   2 -
 tests/unit_tests/openvpn/test_auth_token.c    |   2 -
 tests/unit_tests/openvpn/test_buffer.c        |   2 -
 tests/unit_tests/openvpn/test_crypto.c        |   2 -
 tests/unit_tests/openvpn/test_cryptoapi.c     |   2 -
 tests/unit_tests/openvpn/test_misc.c          |   2 -
 tests/unit_tests/openvpn/test_ncp.c           |   2 -
 tests/unit_tests/openvpn/test_packet_id.c     |   2 -
 tests/unit_tests/openvpn/test_pkcs11.c        |   2 -
 tests/unit_tests/openvpn/test_pkt.c           |   2 -
 tests/unit_tests/openvpn/test_provider.c      |   2 -
 tests/unit_tests/openvpn/test_tls_crypt.c     |   2 -
 156 files changed, 2 insertions(+), 2408 deletions(-)
 delete mode 100644 build/msvc/Makefile.am
 delete mode 100644 build/msvc/msvc-generate/Makefile.am
 delete mode 100644 build/msvc/msvc-generate/Makefile.mak
 delete mode 100644 build/msvc/msvc-generate/git-version.py
 delete mode 100644 build/msvc/msvc-generate/msvc-generate.js
 delete mode 100644 build/msvc/msvc-generate/msvc-generate.vcxproj
 delete mode 100644 build/msvc/msvc-generate/version.m4.in
 delete mode 100644 config-msvc-version.h.in
 delete mode 100644 config-msvc.h
 delete mode 100644 openvpn.sln
 delete mode 100644 src/compat/Debug.props
 delete mode 100644 src/compat/PropertySheet.props
 delete mode 100644 src/compat/Release.props
 delete mode 100644 src/compat/compat.vcxproj
 delete mode 100644 src/openvpn/openvpn.vcxproj
 delete mode 100644 src/openvpn/vcpkg.json
 delete mode 100644 src/openvpnmsica/openvpnmsica-Debug.props
 delete mode 100644 src/openvpnmsica/openvpnmsica-Release.props
 delete mode 100644 src/openvpnmsica/openvpnmsica.props
 delete mode 100644 src/openvpnmsica/openvpnmsica.vcxproj
 delete mode 100644 src/openvpnserv/openvpnserv.vcxproj
 delete mode 100644 src/tapctl/tapctl.props
 delete mode 100644 src/tapctl/tapctl.vcxproj

diff --git a/.gitignore b/.gitignore
index 658f57e5..ed03aaa9 100644
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
@@ -45,11 +39,7 @@ m4/ltoptions.m4
 m4/ltsugar.m4
 m4/ltversion.m4
 m4/lt~obsolete.m4
-vcpkg_installed
 
-msvc-env-local.bat
-config-msvc-local.h
-config-msvc-version.h
 doc/openvpn-examples.5
 doc/openvpn-examples.5.html
 doc/openvpn.8
@@ -61,7 +51,6 @@ distro/systemd/*.service
 sample/sample-keys/sample-ca/
 vendor/cmocka_build
 vendor/dist
-build/msvc/msvc-generate/version.m4
 
 tests/t_client.sh
 tests/t_client-*-20??????-??????/
diff --git a/Makefile.am b/Makefile.am
index 9bdbe7ea..24c47ae9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -69,12 +69,7 @@ dist_noinst_DATA = \
 	PORTS \
 	README.dco.md \
 	README.ec \
-	README.wolfssl \
-	openvpn.sln
-
-dist_noinst_HEADERS = \
-	config-msvc.h \
-	config-msvc-version.h.in
+	README.wolfssl
 
 config-version.h:
 	@CONFIGURE_GIT_CHFILES="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
diff --git a/build/Makefile.am b/build/Makefile.am
index a914d572..e7cc4d8b 100644
--- a/build/Makefile.am
+++ b/build/Makefile.am
@@ -13,5 +13,3 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = \
 	ltrc.inc
-
-SUBDIRS = msvc
diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
deleted file mode 100644
index df3b41f3..00000000
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
-MAINTAINERCLEANFILES = \
-	$(srcdir)/Makefile.in
-
-SUBDIRS = msvc-generate
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
deleted file mode 100644
index fe13b370..00000000
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
-MAINTAINERCLEANFILES = \
-	$(srcdir)/Makefile.in
-
-dist_noinst_DATA = \
-	git-version.py \
-	msvc-generate.vcxproj \
-	Makefile.mak \
-	msvc-generate.js \
-	version.m4.in
diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-generate/Makefile.mak
deleted file mode 100644
index 91907420..00000000
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
-CONFIG=$(SOLUTIONDIR)/version.m4
-
-INPUT_MSVC_VER=$(SOLUTIONDIR)/config-msvc-version.h.in
-OUTPUT_MSVC_VER=$(SOLUTIONDIR)/config-msvc-version.h
-
-INPUT_PLUGIN=$(SOLUTIONDIR)/include/openvpn-plugin.h.in
-OUTPUT_PLUGIN=$(SOLUTIONDIR)/include/openvpn-plugin.h
-
-INPUT_PLUGIN_CONFIG=version.m4.in
-OUTPUT_PLUGIN_CONFIG=version.m4
-
-INPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.rst
-OUTPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.html
-
-OUTPUT_MSVC_GIT_CONFIG=$(SOLUTIONDIR)/config-version.h
-
-all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN) $(OUTPUT_MSVC_GIT_CONFIG)
-
-$(OUTPUT_MSVC_VER): $(INPUT_MSVC_VER) $(CONFIG)
-	cscript //nologo msvc-generate.js --config="$(CONFIG)" --input="$(INPUT_MSVC_VER)" --output="$(OUTPUT_MSVC_VER)"
-
-$(OUTPUT_PLUGIN_CONFIG): $(INPUT_PLUGIN_CONFIG)
-	cscript //nologo msvc-generate.js --config="$(CONFIG)" --input="$(INPUT_PLUGIN_CONFIG)" --output="$(OUTPUT_PLUGIN_CONFIG)"
-
-$(OUTPUT_PLUGIN): $(INPUT_PLUGIN) $(OUTPUT_PLUGIN_CONFIG)
-	cscript //nologo msvc-generate.js --config="$(OUTPUT_PLUGIN_CONFIG)" --input="$(INPUT_PLUGIN)" --output="$(OUTPUT_PLUGIN)"
-
-$(OUTPUT_MAN): $(INPUT_MAN)
-	-FOR /F %i IN ('where rst2html.py') DO python %i "$(INPUT_MAN)" "$(OUTPUT_MAN)"
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
diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-generate/git-version.py
deleted file mode 100644
index c2b44527..00000000
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
-    sp = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
-    o, _ = sp.communicate()
-    return o.decode("utf-8")[:-1]
-
-def get_branch_commit_id():
-    commit_id = run_command(["git", "rev-parse", "--short=16", "HEAD"])
-    if not commit_id:
-        raise
-    branch = run_command(["git", "describe", "--exact-match"])
-    if not branch:
-        # this returns an array like ["master"] or ["release", "2.6"]
-        branch = run_command(["git", "rev-parse", "--symbolic-full-name", "HEAD"]).split("/")[2:]
-        if not branch:
-            branch = ["none"]
-        branch = "/" .join(branch) # handle cases like release/2.6
-
-    return branch, commit_id
-
-def main():
-    try:
-        branch, commit_id = get_branch_commit_id()
-    except:
-        branch, commit_id = "unknown", "unknown"
-
-    prev_content = ""
-
-    name = os.path.join("%s" %  (sys.argv[1] if len(sys.argv) > 1 else "."), "config-version.h")
-    try:
-        with open(name, "r") as f:
-            prev_content = f.read()
-    except:
-        # file doesn't exist
-        pass
-
-    content = "#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch, commit_id)
-    content += "#define CONFIGURE_GIT_FLAGS \"\"\n"
-
-    if prev_content != content:
-        print("Writing %s" % name)
-        with open(name, "w") as f:
-            f.write(content)
-    else:
-        print("Content of %s hasn't changed" % name)
-
-if __name__ == "__main__":
-    main()
diff --git a/build/msvc/msvc-generate/msvc-generate.js b/build/msvc/msvc-generate/msvc-generate.js
deleted file mode 100644
index d9564cfd..00000000
--- a/build/msvc/msvc-generate/msvc-generate.js
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * msvc-generate.js  - string transformation
- *
- * Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
- *
- * BSD License
- * ============
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *
- *     o Redistributions of source code must retain the above copyright notice,
- *       this list of conditions and the following disclaimer.
- *     o Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     o Neither the name of the Alon Bar-Lev nor the names of its
- *       contributors may be used to endorse or promote products derived from
- *       this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-var ForReading = 1;
-var fso = new ActiveXObject("Scripting.FileSystemObject");
-var input = "nul";
-var output = "nul";
-var files = new Array();
-var env = new Array();
-
-function initialize() {
-	for (var i=0;i<WScript.Arguments.length;i++) {
-		var arg = WScript.Arguments(i);
-		if (arg.match(/^--input=(.*)$/)) {
-			input=RegExp.$1;
-		}
-		else if (arg.match(/^--output=(.*)$/)) {
-			output=RegExp.$1;
-		}
-		else if (arg.match(/^--config=(.*)$/)) {
-			files.push(RegExp.$1);
-		}
-		else if (arg.match(/^--var=([^=]*)=(.*)$/)) {
-			env[RegExp.$1] = RegExp.$2;
-		}
-	}
-}
-
-function process_config(vars, file) {
-	try {
-		var fin = fso.OpenTextFile(file, ForReading);
-
-		while (!fin.AtEndOfStream) {
-			var content = fin.ReadLine();
-			if (content.match(/^[ \t]*define\(\[(.*)\],[ \t]*\[(.*)\]\)[ \t]*/)) {
-				vars[RegExp.$1] = RegExp.$2;
-			}
-		}
-	}
-	catch(e) {
-		throw new Error(1, "Cannot process '" + file + "'.");
-	}
-}
-
-function process_file(vars, input, output) {
-	var fin = fso.OpenTextFile(input, ForReading);
-	var fout = fso.CreateTextFile(output);
-	var content = fin.ReadAll();
-
-	for (var i in vars) {
-		content = content.replace(new RegExp("@"+i+"@", "g"), vars[i]);
-	}
-
-	fout.Write(content);
-}
-
-function build_vars() {
-	var vars = new Array();
-	for (var f in files) {
-		process_config(vars, files[f]);
-	}
-	for (var e in env) {
-		vars[e] = env[e];
-	}
-	return vars;
-}
-
-function main() {
-	try {
-		initialize();
-
-		var vars = build_vars();
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
diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
deleted file mode 100644
index 70d411e4..00000000
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ /dev/null
@@ -1,158 +0,0 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label="ProjectConfigurations">
-    <ProjectConfiguration Include="Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label="Globals">
-    <ProjectGuid>{8598C2C8-34C4-47A1-99B0-7C295A890615}</ProjectGuid>
-    <RootNamespace>msvc-generate</RootNamespace>
-    <Keyword>MakeFileProj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
-    <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v143</PlatformToolset>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label="ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\..\..\src\compat\PropertySheet.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
-    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
-    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
-    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
-    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">config-msvc-version.h</NMakeOutput>
-    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
-    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
-    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
-    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
-    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
-    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
-    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
-    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|x64'">config-msvc-version.h</NMakeOutput>
-    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">config-msvc-version.h</NMakeOutput>
-    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|x64'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
-    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
-    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
-    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
-    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <None Include="Makefile.mak" />
-    <None Include="msvc-generate.js" />
-  </ItemGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label="ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/build/msvc/msvc-generate/version.m4.in b/build/msvc/msvc-generate/version.m4.in
deleted file mode 100644
index cbb4fef1..00000000
--- a/build/msvc/msvc-generate/version.m4.in
+++ /dev/null
@@ -1,3 +0,0 @@
-define([OPENVPN_VERSION_MAJOR], [@PRODUCT_VERSION_MAJOR@])
-define([OPENVPN_VERSION_MINOR], [@PRODUCT_VERSION_MINOR@])
-define([OPENVPN_VERSION_PATCH], [@PRODUCT_VERSION_PATCH@])
diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
deleted file mode 100644
index 59ca654a..00000000
--- a/config-msvc-version.h.in
+++ /dev/null
@@ -1,14 +0,0 @@
-#define PACKAGE_NAME "@PRODUCT_NAME@"
-#define PACKAGE_STRING "@PRODUCT_NAME@ @PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
-#define PACKAGE_TARNAME "@PRODUCT_TARNAME@"
-#define PACKAGE "@PRODUCT_TARNAME@"
-#define PRODUCT_VERSION_MAJOR "@PRODUCT_VERSION_MAJOR@"
-#define PRODUCT_VERSION_MINOR "@PRODUCT_VERSION_MINOR@"
-#define PRODUCT_VERSION_PATCH "@PRODUCT_VERSION_PATCH@"
-#define PACKAGE_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
-#define PRODUCT_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
-#define PRODUCT_BUGREPORT "@PRODUCT_BUGREPORT@"
-#define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@
-#define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
-#define TAP_WIN_MIN_MAJOR @PRODUCT_TAP_WIN_MIN_MAJOR@
-#define TAP_WIN_MIN_MINOR @PRODUCT_TAP_WIN_MIN_MINOR@
diff --git a/config-msvc.h b/config-msvc.h
deleted file mode 100644
index a3c687ed..00000000
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
index 50bccc72..5ab1d0df 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1504,8 +1504,6 @@ AC_SUBST([TEST_CFLAGS])
 AC_CONFIG_FILES([
 	Makefile
 	build/Makefile
-	build/msvc/Makefile
-	build/msvc/msvc-generate/Makefile
 	distro/Makefile
 	distro/systemd/Makefile
 	doc/Makefile
diff --git a/openvpn.sln b/openvpn.sln
deleted file mode 100644
index 3485bc94..00000000
--- a/openvpn.sln
+++ /dev/null
@@ -1,107 +0,0 @@
-﻿
-Microsoft Visual Studio Solution File, Format Version 12.00
-# Visual Studio Version 16
-VisualStudioVersion = 16.0.31205.134
-MinimumVisualStudioVersion = 10.0.40219.1
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnserv", "src\openvpnserv\openvpnserv.vcxproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpn", "src\openvpn\openvpn.vcxproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "msvc-generate", "build\msvc\msvc-generate\msvc-generate.vcxproj", "{8598C2C8-34C4-47A1-99B0-7C295A890615}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "compat", "src\compat\compat.vcxproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "tapctl", "src\tapctl\tapctl.vcxproj", "{A06436E7-D576-490D-8BA0-0751D920334A}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnmsica", "src\openvpnmsica\openvpnmsica.vcxproj", "{D41AA9D6-B818-476E-992E-0E16EB86BEE2}"
-EndProject
-Global
-	GlobalSection(SolutionConfigurationPlatforms) = preSolution
-		Debug|ARM64 = Debug|ARM64
-		Debug|Win32 = Debug|Win32
-		Debug|x64 = Debug|x64
-		Release|ARM64 = Release|ARM64
-		Release|Win32 = Release|Win32
-		Release|x64 = Release|x64
-	EndGlobalSection
-	GlobalSection(ProjectConfigurationPlatforms) = postSolution
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|ARM64.ActiveCfg = Debug|ARM64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|ARM64.Build.0 = Debug|ARM64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.ActiveCfg = Debug|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.0 = Debug|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.ActiveCfg = Debug|x64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.Build.0 = Debug|x64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM64.ActiveCfg = Release|ARM64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM64.Build.0 = Release|ARM64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg = Release|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 = Release|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.ActiveCfg = Release|x64
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.Build.0 = Release|x64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|ARM64.ActiveCfg = Debug|ARM64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|ARM64.Build.0 = Debug|ARM64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.ActiveCfg = Debug|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.0 = Debug|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.ActiveCfg = Debug|x64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.Build.0 = Debug|x64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|ARM64.ActiveCfg = Release|ARM64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|ARM64.Build.0 = Release|ARM64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg = Release|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 = Release|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.ActiveCfg = Release|x64
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.Build.0 = Release|x64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|ARM64.ActiveCfg = Debug|ARM64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|ARM64.Build.0 = Debug|ARM64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.ActiveCfg = Debug|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.0 = Debug|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.ActiveCfg = Debug|x64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.Build.0 = Debug|x64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|ARM64.ActiveCfg = Release|ARM64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|ARM64.Build.0 = Release|ARM64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg = Release|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Build.0 = Release|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.ActiveCfg = Release|x64
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.Build.0 = Release|x64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.ActiveCfg = Debug|ARM64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.Build.0 = Debug|ARM64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.ActiveCfg = Debug|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.0 = Debug|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.ActiveCfg = Debug|x64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.Build.0 = Debug|x64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|ARM64.ActiveCfg = Release|ARM64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|ARM64.Build.0 = Release|ARM64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.ActiveCfg = Release|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 = Release|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.ActiveCfg = Release|x64
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.Build.0 = Release|x64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.ActiveCfg = Debug|ARM64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.Build.0 = Debug|ARM64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.ActiveCfg = Debug|Win32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.Build.0 = Debug|Win32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.ActiveCfg = Debug|x64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.Build.0 = Debug|x64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|ARM64.ActiveCfg = Release|ARM64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|ARM64.Build.0 = Release|ARM64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.ActiveCfg = Release|Win32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.Build.0 = Release|Win32
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.ActiveCfg = Release|x64
-		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.Build.0 = Release|x64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM64.ActiveCfg = Debug|ARM64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM64.Build.0 = Debug|ARM64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.ActiveCfg = Debug|Win32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.Build.0 = Debug|Win32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.ActiveCfg = Debug|x64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.Build.0 = Debug|x64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|ARM64.ActiveCfg = Release|ARM64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|ARM64.Build.0 = Release|ARM64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.ActiveCfg = Release|Win32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.Build.0 = Release|Win32
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.ActiveCfg = Release|x64
-		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.Build.0 = Release|x64
-	EndGlobalSection
-	GlobalSection(SolutionProperties) = preSolution
-		HideSolutionNode = FALSE
-	EndGlobalSection
-	GlobalSection(ExtensibilityGlobals) = postSolution
-		SolutionGuid = {EB3CE5D3-415C-46F0-96AB-E1CDA287AB6D}
-	EndGlobalSection
-EndGlobal
diff --git a/src/compat/Debug.props b/src/compat/Debug.props
deleted file mode 100644
index 31bb9d91..00000000
--- a/src/compat/Debug.props
+++ /dev/null
@@ -1,21 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ImportGroup Label="PropertySheets">
-    <Import Project="PropertySheet.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <_PropertySheetDisplayName>compat-Debug</_PropertySheetDisplayName>
-    <LinkIncremental>true</LinkIncremental>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <Optimization>Disabled</Optimization>
-      <PreprocessorDefinitions>_DEBUG;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index a42ec39c..f5de4515 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -12,12 +12,6 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
-EXTRA_DIST = \
-	compat.vcxproj \
-	PropertySheet.props \
-	Debug.props \
-	Release.props
-
 noinst_LTLIBRARIES = libcompat.la
 
 libcompat_la_SOURCES = \
diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.props
deleted file mode 100644
index 57f6995f..00000000
--- a/src/compat/PropertySheet.props
+++ /dev/null
@@ -1,29 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ImportGroup Label="PropertySheets" />
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <_PropertySheetDisplayName>compat</_PropertySheetDisplayName>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <WarningLevel>Level3</WarningLevel>
-      <PreprocessorDefinitions>WIN32;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <AdditionalIncludeDirectories>$(SolutionDir);$(SolutionDir)include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ClCompile>
-    <Link>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
-    </Link>
-    <ResourceCompile />
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOLUTIONDIR)</AdditionalIncludeDirectories>
-    </ResourceCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <BuildMacro Include="SOLUTIONDIR">
-      <Value>$(SOLUTIONDIR)</Value>
-      <EnvironmentVariable>true</EnvironmentVariable>
-    </BuildMacro>
-  </ItemGroup>
-</Project>
\ No newline at end of file
diff --git a/src/compat/Release.props b/src/compat/Release.props
deleted file mode 100644
index 50eaa8de..00000000
--- a/src/compat/Release.props
+++ /dev/null
@@ -1,26 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ImportGroup Label="PropertySheets">
-    <Import Project="PropertySheet.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
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
-      <PreprocessorDefinitions>NDEBUG;%(PreprocessorDefinitions)</PreprocessorDefinitions>
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
index e66e225d..abb4f49e 100644
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
index 460b9e99..aebb8f4e 100644
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
index c1523d99..c131dee8 100644
--- a/src/compat/compat-dirname.c
+++ b/src/compat/compat-dirname.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index 0dc74607..69843fb4 100644
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
index 6db013f7..fbad98d3 100644
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
index 9fcfd6c6..00000000
--- a/src/compat/compat.vcxproj
+++ /dev/null
@@ -1,179 +0,0 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label="ProjectConfigurations">
-    <ProjectConfiguration Include="Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label="Globals">
-    <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
-    <RootNamespace>compat</RootNamespace>
-    <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
-    <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label="ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="Debug.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include="compat-basename.c" />
-    <ClCompile Include="compat-dirname.c" />
-    <ClCompile Include="compat-gettimeofday.c" />
-    <ClCompile Include="compat-daemon.c" />
-    <ClCompile Include="compat-strsep.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="compat.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label="ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 2f979914..52deef85 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -15,9 +15,7 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 EXTRA_DIST = \
-	openvpn.vcxproj \
-	openvpn.manifest \
-	vcpkg.json
+	openvpn.manifest
 
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include \
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index cef0da9a..50083baf 100644
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
index e4486eb0..6787ea7d 100644
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
index 0ac65e99..a9c2f4c6 100644
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
index 4af429be..05b2599c 100644
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
index 7725438e..24f1ef26 100644
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
index 514bd438..2b91f7b1 100644
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
index e544a8dc..33a480cc 100644
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
index 27b640ce..6e303694 100644
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
index 496e60e5..adb1f28a 100644
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
index bbdd59c5..5b367f23 100644
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
index 4101feb8..b5264d8e 100644
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
index 930f15a4..a77b5a13 100644
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
index cd43ee58..98cac60d 100644
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
index f5372f85..b043bb95 100644
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
index 20b7d985..3b92e481 100644
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
index 308578b4..7c7eaac4 100644
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
index af7776bb..3ba1c817 100644
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
index 2bfdf980..6737f354 100644
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
index 4b414efa..53f1523d 100644
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
index b9cd3c61..ac7f538c 100644
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
index b7808db1..530e6d5e 100644
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
index 79059141..97b011fb 100644
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
index 9a234e67..56addff7 100644
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
index fa5aee23..6b6f9514 100644
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
index 3f74171b..3570ed4e 100644
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
index 5bffe07d..d8ad0d15 100644
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
index 50391de2..974ebda1 100644
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
index c77fc406..501d70cf 100644
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
index 7c219fdf..fa011ffb 100644
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
index 6714ef94..5c255b22 100644
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
index d358ad00..6fb6900d 100644
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
index 8308df4a..bde9dd99 100644
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
index f65d8a8e..480f39d7 100644
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
index ee677187..cc677b4b 100644
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
index 848cb06a..19017802 100644
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
index 05358af4..d80f9ffd 100644
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
index a44f8c3b..318b9eda 100644
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
index 774ea062..ce6e4fd9 100644
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
index 2683b405..91af2b60 100644
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
index 98d54068..816e65b6 100644
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
index 1e92b41e..04be449e 100644
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
index 6c56a260..62eb14b9 100644
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
index 2925b7fe..132f93c5 100644
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
index 8698aefc..81625ea5 100644
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
index 6fb9cff2..aad11b1d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #ifdef HAVE_SYS_INOTIFY_H
diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c
index 0633dce7..1c94756e 100644
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
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 0efeed0f..9d2351cd 100644
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
index cb9a47c0..662e0e2d 100644
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
index 20527d44..0cb0a32f 100644
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
index 94b82e0f..8541f6ec 100644
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
index 56b1dcf1..ffb64adf 100644
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
index 1aaddcdf..348392e2 100644
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
index 97baf678..00000000
--- a/src/openvpn/openvpn.vcxproj
+++ /dev/null
@@ -1,470 +0,0 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label="ProjectConfigurations">
-    <ProjectConfiguration Include="Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label="Globals">
-    <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
-    <RootNamespace>openvpn</RootNamespace>
-    <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label="ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-    <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
-    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg">
-    <VcpkgEnableManifest>true</VcpkgEnableManifest>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-      <SDLCheck>true</SDLCheck>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <ClCompile>
-      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <ControlFlowGuard>Guard</ControlFlowGuard>
-      <WarningLevel>Level2</WarningLevel>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
-      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include="argv.c" />
-    <ClCompile Include="auth_token.c" />
-    <ClCompile Include="base64.c" />
-    <ClCompile Include="block_dns.c" />
-    <ClCompile Include="buffer.c" />
-    <ClCompile Include="clinat.c" />
-    <ClCompile Include="comp-lz4.c" />
-    <ClCompile Include="comp.c" />
-    <ClCompile Include="compstub.c" />
-    <ClCompile Include="console.c" />
-    <ClCompile Include="console_builtin.c" />
-    <ClCompile Include="crypto.c" />
-    <ClCompile Include="crypto_openssl.c" />
-    <ClCompile Include="cryptoapi.c" />
-    <ClCompile Include="dco.c" />
-    <ClCompile Include="dco_win.c" />
-    <ClCompile Include="dhcp.c" />
-    <ClCompile Include="dns.c" />
-    <ClCompile Include="env_set.c" />
-    <ClCompile Include="error.c" />
-    <ClCompile Include="event.c" />
-    <ClCompile Include="fdmisc.c" />
-    <ClCompile Include="forward.c" />
-    <ClCompile Include="fragment.c" />
-    <ClCompile Include="gremlin.c" />
-    <ClCompile Include="helper.c" />
-    <ClCompile Include="httpdigest.c" />
-    <ClCompile Include="init.c" />
-    <ClCompile Include="interval.c" />
-    <ClCompile Include="list.c" />
-    <ClCompile Include="lladdr.c" />
-    <ClCompile Include="lzo.c" />
-    <ClCompile Include="manage.c" />
-    <ClCompile Include="mbuf.c" />
-    <ClCompile Include="misc.c" />
-    <ClCompile Include="mroute.c" />
-    <ClCompile Include="mss.c" />
-    <ClCompile Include="mstats.c" />
-    <ClCompile Include="mtcp.c" />
-    <ClCompile Include="mtu.c" />
-    <ClCompile Include="mudp.c" />
-    <ClCompile Include="multi.c" />
-    <ClCompile Include="ntlm.c" />
-    <ClCompile Include="occ.c" />
-    <ClCompile Include="openvpn.c" />
-    <ClCompile Include="options.c" />
-    <ClCompile Include="options_util.c" />
-    <ClCompile Include="otime.c" />
-    <ClCompile Include="packet_id.c" />
-    <ClCompile Include="perf.c" />
-    <ClCompile Include="ping.c" />
-    <ClCompile Include="pkcs11.c" />
-    <ClCompile Include="pkcs11_openssl.c" />
-    <ClCompile Include="platform.c" />
-    <ClCompile Include="plugin.c" />
-    <ClCompile Include="pool.c" />
-    <ClCompile Include="proto.c" />
-    <ClCompile Include="proxy.c" />
-    <ClCompile Include="ps.c" />
-    <ClCompile Include="push.c" />
-    <ClCompile Include="reflect_filter.c" />
-    <ClCompile Include="reliable.c" />
-    <ClCompile Include="route.c" />
-    <ClCompile Include="run_command.c" />
-    <ClCompile Include="schedule.c" />
-    <ClCompile Include="session_id.c" />
-    <ClCompile Include="shaper.c" />
-    <ClCompile Include="sig.c" />
-    <ClCompile Include="socket.c" />
-    <ClCompile Include="socks.c" />
-    <ClCompile Include="ssl.c" />
-    <ClCompile Include="ssl_openssl.c" />
-    <ClCompile Include="ssl_ncp.c" />
-    <ClCompile Include="ssl_pkt.c" />
-    <ClCompile Include="ssl_util.c" />
-    <ClCompile Include="ssl_verify.c" />
-    <ClCompile Include="ssl_verify_openssl.c" />
-    <ClCompile Include="status.c" />
-    <ClCompile Include="tls_crypt.c" />
-    <ClCompile Include="tun.c" />
-    <ClCompile Include="vlan.c" />
-    <ClCompile Include="win32.c" />
-    <ClCompile Include="win32-util.c" />
-    <ClCompile Include="xkey_helper.c" />
-    <ClCompile Include="xkey_provider.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="argv.h" />
-    <ClInclude Include="auth_token.h" />
-    <ClInclude Include="base64.h" />
-    <ClInclude Include="basic.h" />
-    <ClInclude Include="block_dns.h" />
-    <ClInclude Include="buffer.h" />
-    <ClInclude Include="circ_list.h" />
-    <ClInclude Include="clinat.h" />
-    <ClInclude Include="common.h" />
-    <ClInclude Include="comp-lz4.h" />
-    <ClInclude Include="comp.h" />
-    <ClInclude Include="compstub.h" />
-    <ClInclude Include="console.h" />
-    <ClInclude Include="crypto.h" />
-    <ClInclude Include="crypto_backend.h" />
-    <ClInclude Include="crypto_openssl.h" />
-    <ClInclude Include="cryptoapi.h" />
-    <ClInclude Include="dco.h" />
-    <ClInclude Include="dco_internal.h" />
-    <ClInclude Include="dco_win.h" />
-    <ClInclude Include="dhcp.h" />
-    <ClInclude Include="dns.h" />
-    <ClInclude Include="env_set.h" />
-    <ClInclude Include="errlevel.h" />
-    <ClInclude Include="error.h" />
-    <ClInclude Include="event.h" />
-    <ClInclude Include="fdmisc.h" />
-    <ClInclude Include="forward.h" />
-    <ClInclude Include="fragment.h" />
-    <ClInclude Include="gremlin.h" />
-    <ClInclude Include="helper.h" />
-    <ClInclude Include="httpdigest.h" />
-    <ClInclude Include="init.h" />
-    <ClInclude Include="integer.h" />
-    <ClInclude Include="interval.h" />
-    <ClInclude Include="list.h" />
-    <ClInclude Include="lladdr.h" />
-    <ClInclude Include="lzo.h" />
-    <ClInclude Include="manage.h" />
-    <ClInclude Include="mbuf.h" />
-    <ClInclude Include="memdbg.h" />
-    <ClInclude Include="misc.h" />
-    <ClInclude Include="mroute.h" />
-    <ClInclude Include="mss.h" />
-    <ClInclude Include="mstats.h" />
-    <ClInclude Include="mtcp.h" />
-    <ClInclude Include="mtu.h" />
-    <ClInclude Include="mudp.h" />
-    <ClInclude Include="multi.h" />
-    <ClInclude Include="ntlm.h" />
-    <ClInclude Include="occ.h" />
-    <ClInclude Include="openvpn.h" />
-    <ClInclude Include="options.h" />
-    <ClInclude Include="options_util.h" />
-    <ClInclude Include="otime.h" />
-    <ClInclude Include="ovpn_dco_win.h" />
-    <ClInclude Include="packet_id.h" />
-    <ClInclude Include="perf.h" />
-    <ClInclude Include="ping.h" />
-    <ClInclude Include="pkcs11.h" />
-    <ClInclude Include="pkcs11_backend.h" />
-    <ClInclude Include="platform.h" />
-    <ClInclude Include="plugin.h" />
-    <ClInclude Include="pool.h" />
-    <ClInclude Include="proto.h" />
-    <ClInclude Include="proxy.h" />
-    <ClInclude Include="ps.h" />
-    <ClInclude Include="push.h" />
-    <ClInclude Include="pushlist.h" />
-    <ClInclude Include="reflect_filter.h" />
-    <ClInclude Include="reliable.h" />
-    <ClInclude Include="ring_buffer.h" />
-    <ClInclude Include="route.h" />
-    <ClInclude Include="run_command.h" />
-    <ClInclude Include="schedule.h" />
-    <ClInclude Include="session_id.h" />
-    <ClInclude Include="shaper.h" />
-    <ClInclude Include="sig.h" />
-    <ClInclude Include="socket.h" />
-    <ClInclude Include="socks.h" />
-    <ClInclude Include="ssl.h" />
-    <ClInclude Include="ssl_backend.h" />
-    <ClInclude Include="ssl_common.h" />
-    <ClInclude Include="ssl_ncp.h" />
-    <ClInclude Include="ssl_openssl.h" />
-    <ClInclude Include="ssl_pkt.h" />
-    <ClInclude Include="ssl_util.h" />
-    <ClInclude Include="ssl_verify.h" />
-    <ClInclude Include="ssl_verify_backend.h" />
-    <ClInclude Include="ssl_verify_openssl.h" />
-    <ClInclude Include="status.h" />
-    <ClInclude Include="syshead.h" />
-    <ClInclude Include="tls_crypt.h" />
-    <ClInclude Include="tun.h" />
-    <ClInclude Include="vlan.h" />
-    <ClInclude Include="win32.h" />
-    <ClInclude Include="win32-util.h" />
-    <ClInclude Include="xkey_common.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="openvpn_win32_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-    <ProjectReference Include="..\compat\compat.vcxproj">
-      <Project>{4b2e2719-e661-45d7-9203-f6f456b22f19}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <ItemGroup>
-    <Manifest Include="openvpn.manifest" />
-  </ItemGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label="ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn_win32_resources.rc
index 1ea5f878..a843b1b2 100644
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
index efddc589..90d85be4 100644
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
index b071f37d..3660da06 100644
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
index 0bbed81d..b28a90f9 100644
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
index bb790f03..ef832488 100644
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
index 5eb89265..ca4f810d 100644
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
index 25822c99..ccf9870a 100644
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
index b6c3bf13..cfe6cf6d 100644
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
index a286a231..7e4be144 100644
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
index 9b0ab39f..7c07152c 100644
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
index f6b856f3..32c4fe6b 100644
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
index d662998e..b4d4a986 100644
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
index 4af9bcb1..5ab0f95b 100644
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
index 7a844074..cab60c3a 100644
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
index ed47eaa2..76e27cb4 100644
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
index 3609630a..4659e17d 100644
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
index 8e962719..ddfc28b4 100644
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
index cfe69a63..0db456bc 100644
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
index 32b346b4..e7d4d5f8 100644
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
index 3798bc65..d18acd01 100644
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
index 8c2a6d78..864b317d 100644
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
index b0fca033..e1bc24ae 100644
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
index 89c67efb..25c5faa8 100644
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
index 6a0d7ddf..c65dec8f 100644
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
index 05c0054b..8b80aeb4 100644
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
index fc643c1c..91a6d53d 100644
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
index 2cf0cc9f..a29eb83a 100644
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
index 8641a51a..c975dbc6 100644
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
index 49989d94..81dd9069 100644
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
index 22dbe210..dafaef12 100644
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
index 65b36d1c..0b310de3 100644
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
index 8b3391e7..afc5aab3 100644
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
index e12ed3d8..bca6eed0 100644
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
index 1b589f1a..90416b69 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -28,8 +28,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index e3437f74..a1ddf8d0 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -28,8 +28,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index e24ce4e4..3194c232 100644
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
index 737f340b..0cb44083 100644
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
index 88b2d6d7..c97f9257 100644
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
index 4ef390ad..d1fd6def 100644
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
index 0afd802c..00000000
--- a/src/openvpn/vcpkg.json
+++ /dev/null
@@ -1,15 +0,0 @@
-{
-  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json",
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
index 25100428..0bb7abc8 100644
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
index 32f7a00b..81e504a4 100644
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
index 25da54ab..156ee746 100644
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
index ee9677ab..40839f28 100644
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
index b0f414f6..db316feb 100644
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
index d68a0089..dc53f758 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -22,12 +22,6 @@ include $(top_srcdir)/build/ltrc.inc
 
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
-EXTRA_DIST = \
-	openvpnmsica.vcxproj \
-	openvpnmsica.props \
-	openvpnmsica-Debug.props \
-	openvpnmsica-Release.props
-
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat
 
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 7cff41ac..1bf3d564 100644
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
index ad6968f2..d1eb4046 100644
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
index 3ea2c1ac..78017eb3 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -20,8 +20,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif
 
 #include "msiex.h"
diff --git a/src/openvpnmsica/openvpnmsica-Debug.props b/src/openvpnmsica/openvpnmsica-Debug.props
deleted file mode 100644
index 43532cfe..00000000
--- a/src/openvpnmsica/openvpnmsica-Debug.props
+++ /dev/null
@@ -1,14 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ImportGroup Label="PropertySheets">
-    <Import Project="openvpnmsica.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup />
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <RuntimeLibrary>MultiThreadedDebug</RuntimeLibrary>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica-Release.props b/src/openvpnmsica/openvpnmsica-Release.props
deleted file mode 100644
index 47727b35..00000000
--- a/src/openvpnmsica/openvpnmsica-Release.props
+++ /dev/null
@@ -1,15 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ImportGroup Label="PropertySheets">
-    <Import Project="openvpnmsica.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
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
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 06c9789d..e5312d69 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -20,8 +20,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
 #endif
 #include <winsock2.h> /* Must be included _before_ <windows.h> */
 
diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpnmsica.props
deleted file mode 100644
index 1091c9f4..00000000
--- a/src/openvpnmsica/openvpnmsica.props
+++ /dev/null
@@ -1,17 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ImportGroup Label="PropertySheets" />
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <TargetName>lib$(ProjectName)</TargetName>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <PreprocessorDefinitions>_WIN32_WINNT=_WIN32_WINNT_VISTA;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-    </ClCompile>
-    <Link>
-      <SubSystem>Windows</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup />
-</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
deleted file mode 100644
index c9154b37..00000000
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ /dev/null
@@ -1,208 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label="ProjectConfigurations">
-    <ProjectConfiguration Include="Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label="Globals">
-    <VCProjectVersion>15.0</VCProjectVersion>
-    <ProjectGuid>{D41AA9D6-B818-476E-992E-0E16EB86BEE2}</ProjectGuid>
-    <Keyword>Win32Proj</Keyword>
-    <RootNamespace>openvpnmsica</RootNamespace>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
-    <ConfigurationType>DynamicLibrary</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label="ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Label="Shared">
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-    <Import Project="openvpnmsica-Debug.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-    <Import Project="openvpnmsica-Debug.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-    <Import Project="openvpnmsica-Debug.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-    <Import Project="openvpnmsica-Release.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-    <Import Project="openvpnmsica-Release.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-    <Import Project="openvpnmsica-Release.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <ClCompile>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-      <SDLCheck>true</SDLCheck>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include="..\tapctl\error.c" />
-    <ClCompile Include="..\tapctl\tap.c" />
-    <ClCompile Include="dllmain.c" />
-    <ClCompile Include="msiex.c" />
-    <ClCompile Include="msica_arg.c" />
-    <ClCompile Include="openvpnmsica.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="..\tapctl\basic.h" />
-    <ClInclude Include="..\tapctl\error.h" />
-    <ClInclude Include="..\tapctl\tap.h" />
-    <ClInclude Include="msiex.h" />
-    <ClInclude Include="msica_arg.h" />
-    <ClInclude Include="openvpnmsica.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="openvpnmsica_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label="ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
index d7c14ded..e30c8a14 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -19,8 +19,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#else
-#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>
 
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 4c0ac40c..d8ba4eb0 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -13,9 +13,6 @@ include $(top_srcdir)/build/ltrc.inc
 
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
-EXTRA_DIST = \
-	openvpnserv.vcxproj
-
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
 
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
deleted file mode 100644
index db3a446d..00000000
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ /dev/null
@@ -1,229 +0,0 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label="ProjectConfigurations">
-    <ProjectConfiguration Include="Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label="Globals">
-    <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
-    <RootNamespace>openvpnserv</RootNamespace>
-    <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v143</PlatformToolset>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label="ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-  </ImportGroup>
-  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <ResourceCompile />
-    <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <SubSystem>Console</SubSystem>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include="common.c" />
-    <ClCompile Include="interactive.c" />
-    <ClCompile Include="service.c" />
-    <ClCompile Include="validate.c" />
-    <ClCompile Include="..\openvpn\block_dns.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="..\openvpn\ring_buffer.h" />
-    <ClInclude Include="service.h" />
-    <ClInclude Include="validate.h" />
-    <ClInclude Include="..\openvpn\block_dns.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="openvpnserv_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label="ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/openvpnserv_resources.rc
index 4ea453e1..ddd0cb83 100644
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
index fc5ecdaf..d38a6652 100644
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
index fe8ab2a5..69ea1611 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -22,11 +22,6 @@ include $(top_srcdir)/build/ltrc.inc
 
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
-EXTRA_DIST = \
-	tapctl.vcxproj \
-	tapctl.props \
-	tapctl.exe.manifest
-
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat
 
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index d76d553c..a946c2ca 100644
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
index 44fcdde5..5ae80443 100644
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
index 0257b9ff..00000000
--- a/src/tapctl/tapctl.props
+++ /dev/null
@@ -1,18 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ImportGroup Label="PropertySheets" />
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup>
-    <GenerateManifest>false</GenerateManifest>
-  </PropertyGroup>
-  <ItemDefinitionGroup>
-    <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;_WIN32_WINNT=_WIN32_WINNT_VISTA;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
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
index 6311d7fd..00000000
--- a/src/tapctl/tapctl.vcxproj
+++ /dev/null
@@ -1,205 +0,0 @@
-<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup Label="ProjectConfigurations">
-    <ProjectConfiguration Include="Debug|ARM64">
-      <Configuration>Debug</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|Win32">
-      <Configuration>Debug</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Debug|x64">
-      <Configuration>Debug</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|ARM64">
-      <Configuration>Release</Configuration>
-      <Platform>ARM64</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|Win32">
-      <Configuration>Release</Configuration>
-      <Platform>Win32</Platform>
-    </ProjectConfiguration>
-    <ProjectConfiguration Include="Release|x64">
-      <Configuration>Release</Configuration>
-      <Platform>x64</Platform>
-    </ProjectConfiguration>
-  </ItemGroup>
-  <PropertyGroup Label="Globals">
-    <VCProjectVersion>15.0</VCProjectVersion>
-    <ProjectGuid>{A06436E7-D576-490D-8BA0-0751D920334A}</ProjectGuid>
-    <Keyword>Win32Proj</Keyword>
-    <RootNamespace>tapctl</RootNamespace>
-    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
-    <ConfigurationType>Application</ConfigurationType>
-    <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v143</PlatformToolset>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
-    <SpectreMitigation>Spectre</SpectreMitigation>
-  </PropertyGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
-  <ImportGroup Label="ExtensionSettings">
-  </ImportGroup>
-  <ImportGroup Label="Shared">
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-    <Import Project="tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-    <Import Project="tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Debug.props" />
-    <Import Project="tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-    <Import Project="tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-    <Import Project="tapctl.props" />
-  </ImportGroup>
-  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\Release.props" />
-    <Import Project="tapctl.props" />
-  </ImportGroup>
-  <PropertyGroup Label="UserMacros" />
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <VcpkgEnabled>true</VcpkgEnabled>
-  </PropertyGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
-    <Link>
-      <CETCompat>true</CETCompat>
-    </Link>
-    <ClCompile>
-      <SDLCheck>true</SDLCheck>
-      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
-    </ClCompile>
-  </ItemDefinitionGroup>
-  <ItemGroup>
-    <ClCompile Include="error.c" />
-    <ClCompile Include="tap.c" />
-    <ClCompile Include="main.c" />
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="basic.h" />
-    <ClInclude Include="error.h" />
-    <ClInclude Include="tap.h" />
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="tapctl_resources.rc" />
-  </ItemGroup>
-  <ItemGroup>
-    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
-      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
-      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
-    </ProjectReference>
-  </ItemGroup>
-  <ItemGroup>
-    <Manifest Include="tapctl.exe.manifest" />
-  </ItemGroup>
-  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
-  <ImportGroup Label="ExtensionTargets">
-  </ImportGroup>
-</Project>
\ No newline at end of file
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index fc65b5a6..c49f82d8 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -19,8 +19,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#else
-#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>
 
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index a6fcf432..d74efaa1 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include <stdarg.h>
diff --git a/tests/unit_tests/openvpn/pkey_test_utils.c b/tests/unit_tests/openvpn/pkey_test_utils.c
index 7adaf33f..dd0a7311 100644
--- a/tests/unit_tests/openvpn/pkey_test_utils.c
+++ b/tests/unit_tests/openvpn/pkey_test_utils.c
@@ -24,8 +24,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 57e98f54..d96984f4 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index bff50567..8232f927 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index aec4e049..58eebc04 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 2150b77c..008f41c0 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -24,8 +24,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 5a8978d0..43ae96b6 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 0e52ea24..72a1c3b0 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 9b653a8b..90c67acd 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -24,8 +24,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index df5f8c7e..235cc43f 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -24,8 +24,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 736f1317..5a53f702 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 255067c7..335fca2d 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -24,8 +24,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 19ae29cc..8bed042f 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -23,8 +23,6 @@
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
 #endif
 
 #include "syshead.h"
-- 
2.34.1


