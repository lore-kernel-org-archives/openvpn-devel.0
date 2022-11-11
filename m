From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 11 Nov 2022 12:16:19 +0100
Message-Id: <20221111111619.21415-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] msvc: always regenerate config-msvc.h
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

There is no easy way to detect whether this information
is outdated. One possible optimisation would be in the
Python code to actually only rewrite the file if it has
changed. Although VC is already pretty good in detecting
whether the code has actually changed so this might not
be worth the additional complexity.

While here, change some leading whitespace to tabs as
expected in Makefile.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 build/msvc/msvc-generate/Makefile.mak | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Note: this patch applies to both master and release/2.5 cleanly and
should be pushed to both.

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
-- 
2.34.1


