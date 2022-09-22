From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 22 Sep 2022 17:42:58 +0300
Message-Id: <20220922144258.432-1-lstipakov@...277...>
In-Reply-To: <20220922125822.313-1-lstipakov@...277...>
References: <20220922125822.313-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 release/2.5] msvc: add branch name and
 commit hash to version output
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Add a simple python script which generates header with
branch name and commit hash #defines.

While on it, fix filename in msvc-generate.vcxproj
and add proper copyright header to Makefile.mak.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2:

  - fix copyright year 2002 -> 2022
  - change "not-a-git-repo" to "unknown"

 build/msvc/msvc-generate/Makefile.mak         | 33 +++++++++++++-
 build/msvc/msvc-generate/git-version.py       | 45 +++++++++++++++++++
 .../msvc/msvc-generate/msvc-generate.vcxproj  |  2 +-
 config-msvc.h                                 |  2 +
 4 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 build/msvc/msvc-generate/git-version.py

diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-generate/Makefile.mak
index 1cb43102..ae8b0842 100644
--- a/build/msvc/msvc-generate/Makefile.mak
+++ b/build/msvc/msvc-generate/Makefile.mak
@@ -1,4 +1,27 @@
-# Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
 
 CONFIG=$(SOLUTIONDIR)/version.m4
 
@@ -14,7 +37,9 @@ OUTPUT_PLUGIN_CONFIG=version.m4
 INPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.rst
 OUTPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.html
 
-all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN)
+OUTPUT_MSVC_GIT_CONFIG=$(SOLUTIONDIR)/config-version.h
+
+all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN) $(OUTPUT_MSVC_GIT_CONFIG)
 
 $(OUTPUT_MSVC_VER): $(INPUT_MSVC_VER) $(CONFIG)
 	cscript //nologo msvc-generate.js --config="$(CONFIG)" --input="$(INPUT_MSVC_VER)" --output="$(OUTPUT_MSVC_VER)"
@@ -28,8 +53,12 @@ $(OUTPUT_PLUGIN): $(INPUT_PLUGIN) $(OUTPUT_PLUGIN_CONFIG)
 $(OUTPUT_MAN): $(INPUT_MAN)
     -FOR /F %i IN ('where rst2html.py') DO python %i "$(INPUT_MAN)" "$(OUTPUT_MAN)"
 
+$(OUTPUT_MSVC_GIT_CONFIG):
+    python git-version.py $(SOLUTIONDIR)
+
 clean:
 	-del "$(OUTPUT_MSVC_VER)"
 	-del "$(OUTPUT_PLUGIN)"
 	-del "$(OUTPUT_PLUGIN_CONFIG)"
 	-del "$(OUTPUT_MAN)"
+	-del "$(OUTPUT_MSVC_GIT_CONFIG)"
diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-generate/git-version.py
new file mode 100644
index 00000000..bf0891fe
--- /dev/null
+++ b/build/msvc/msvc-generate/git-version.py
@@ -0,0 +1,45 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2022-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+import os
+import sys
+
+def get_branch_commit_id():
+    commit_id = os.popen("git rev-parse --short=16 HEAD").read()[:-1]
+    branch = os.popen("git rev-parse --symbolic-full-name HEAD").read().split("/")[2][:-1]
+    return branch, commit_id
+
+def main():
+    try:
+        branch, commit_id = get_branch_commit_id()
+    except:
+        branch, commit_id = "unknown", "unknown"
+
+    name = os.path.join("%s" %  (sys.argv[1] if len(sys.argv) > 1 else "."), "config-version.h")
+    with open(name, "w") as f:
+        f.write("#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch, commit_id))
+        f.write("#define CONFIGURE_GIT_FLAGS \"\"\n")
+
+if __name__ == "__main__":
+    main()
diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
index dda8b051..eae94709 100644
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -150,7 +150,7 @@
   </ItemDefinitionGroup>
   <ItemGroup>
     <None Include="Makefile.mak" />
-    <None Include="msc-generate.js" />
+    <None Include="msvc-generate.js" />
   </ItemGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
diff --git a/config-msvc.h b/config-msvc.h
index e7479c86..47c5ba07 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -177,3 +177,5 @@ typedef uint16_t in_port_t;
     #define HAVE_INET_NTOP
     #define HAVE_INET_PTON
 #endif
+
+#define HAVE_CONFIG_VERSION_H 1
-- 
2.23.0.windows.1


