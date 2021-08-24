From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 Aug 2021 16:46:41 +0300
Message-Id: <20210824134641.154-1-lstipakov@...277...>
In-Reply-To: <20210824091058.93-1-lstipakov@...277...>
References: <20210824091058.93-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] Add building man page on Windows
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

Use rst2html to build html from rst. Ignore errors,
this is not fatal and affects only MSI build.

Modify MSVC GitHub Actions to install python3/rst2html
and add html man page to artifacts.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2:
  - change implementation to support GitHub Actions

 .github/workflows/build.yaml          | 9 +++++++++
 build/msvc/msvc-generate/Makefile.mak | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5d7dd37b..4cb2f4cc 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -206,6 +206,14 @@ jobs:
       - name: Add MSBuild to PATH
         uses: microsoft/setup-msbuild@...2621...
 
+      - name: Set up Python
+        uses: actions/setup-python@...2620...
+        with:
+          python-version: '3.x'
+
+      - name: Install rst2html
+        run: python -m pip install --upgrade pip rst2html
+
       - name: Restore artifacts, or run vcpkg, build and cache artifacts
         uses: lukka/run-vcpkg@...2622...
         with:
@@ -227,3 +235,4 @@ jobs:
           path: |
             ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.exe
             ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll
+            doc/openvpn.8.html
diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-generate/Makefile.mak
index 59fc9f0e..4924a6ce 100644
--- a/build/msvc/msvc-generate/Makefile.mak
+++ b/build/msvc/msvc-generate/Makefile.mak
@@ -11,7 +11,10 @@ OUTPUT_PLUGIN=$(SOURCEBASE)/include/openvpn-plugin.h
 INPUT_PLUGIN_CONFIG=version.m4.in
 OUTPUT_PLUGIN_CONFIG=version.m4
 
-all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN)
+INPUT_MAN=$(SOURCEBASE)/doc/openvpn.8.rst
+OUTPUT_MAN=$(SOURCEBASE)/doc/openvpn.8.html
+
+all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN)
 
 $(OUTPUT_MSVC_VER): $(INPUT_MSVC_VER) $(CONFIG)
 	cscript //nologo msvc-generate.js --config="$(CONFIG)" --input="$(INPUT_MSVC_VER)" --output="$(OUTPUT_MSVC_VER)"
@@ -22,7 +25,11 @@ $(OUTPUT_PLUGIN_CONFIG): $(INPUT_PLUGIN_CONFIG)
 $(OUTPUT_PLUGIN): $(INPUT_PLUGIN) $(OUTPUT_PLUGIN_CONFIG)
 	cscript //nologo msvc-generate.js --config="$(OUTPUT_PLUGIN_CONFIG)" --input="$(INPUT_PLUGIN)" --output="$(OUTPUT_PLUGIN)"
 
+$(OUTPUT_MAN): $(INPUT_MAN)
+    -FOR /F %i IN ('where rst2html.py') DO python3 %i "$(INPUT_MAN)" "$(OUTPUT_MAN)"
+
 clean:
 	-del "$(OUTPUT_MSVC_VER)"
 	-del "$(OUTPUT_PLUGIN)"
 	-del "$(OUTPUT_PLUGIN_CONFIG)"
+	-del "$(OUTPUT_MAN)"
-- 
2.23.0.windows.1


