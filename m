From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 11 Nov 2022 13:12:12 +0100
Message-Id: <20221111121212.25167-1-frank@...2641...>
In-Reply-To: <20221111111619.21415-1-frank@...2641...>
References: <20221111111619.21415-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] msvc: always call git-version.py
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

There is no way to detect whether this information
is outdated in nmake itself. So leave it up to the
Python script to decide.

While here, change some leading whitespace to tabs as
expected in Makefile.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Lev Stipakov <lev@...515...>
---
 build/msvc/msvc-generate/Makefile.mak   |  9 ++++++---
 build/msvc/msvc-generate/git-version.py | 21 ++++++++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

v2: incorporate changes to git-version.py by Lev

diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-generate/Makefile.mak
index ae8b0842..1c1c4bab 100644
--- a/build/msvc/msvc-generate/Makefile.mak
+++ b/build/msvc/msvc-generate/Makefile.mak
@@ -51,10 +51,13 @@ $(OUTPUT_PLUGIN): $(INPUT_PLUGIN) $(OUTPUT_PLUGIN_CONFIG)
 	cscript //nologo msvc-generate.js --config="$(OUTPUT_PLUGIN_CONFIG)" --input="$(INPUT_PLUGIN)" --output="$(OUTPUT_PLUGIN)"
 
 $(OUTPUT_MAN): $(INPUT_MAN)
-    -FOR /F %i IN ('where rst2html.py') DO python %i "$(INPUT_MAN)" "$(OUTPUT_MAN)"
+	-FOR /F %i IN ('where rst2html.py') DO python %i "$(INPUT_MAN)" "$(OUTPUT_MAN)"
 
-$(OUTPUT_MSVC_GIT_CONFIG):
-    python git-version.py $(SOLUTIONDIR)
+# Force regeneration because we can't detect whether it is outdated
+$(OUTPUT_MSVC_GIT_CONFIG): FORCE
+	python git-version.py $(SOLUTIONDIR)
+
+FORCE:
 
 clean:
 	-del "$(OUTPUT_MSVC_VER)"
diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-generate/git-version.py
index b6037e1e..814dc86a 100644
--- a/build/msvc/msvc-generate/git-version.py
+++ b/build/msvc/msvc-generate/git-version.py
@@ -41,10 +41,25 @@ def main():
     except:
         branch, commit_id = "unknown", "unknown"
 
+    prev_content = ""
+
     name = os.path.join("%s" %  (sys.argv[1] if len(sys.argv) > 1 else "."), "config-version.h")
-    with open(name, "w") as f:
-        f.write("#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch, commit_id))
-        f.write("#define CONFIGURE_GIT_FLAGS \"\"\n")
+    try:
+        with open(name, "r") as f:
+            prev_content = f.read()
+    except:
+        # file doesn't exist
+        pass
+
+    content = "#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch, commit_id)
+    content += "#define CONFIGURE_GIT_FLAGS \"\"\n"
+
+    if prev_content != content:
+        print("Writing %s" % name)
+        with open(name, "w") as f:
+            f.write(content)
+    else:
+        print("Content of %s hasn't changed" % name)
 
 if __name__ == "__main__":
     main()
-- 
2.38.1.windows.1


