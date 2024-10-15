From: Gert Doering <gert@...1296...>
Date: Tue, 15 Oct 2024 22:56:27 +0200
Message-ID: <20241015205627.25644-1-gert@...1296...>
In-Reply-To: <gerrit.1728995699000.Ibaa591904095a824df2c0c5aaff73687e0af24fe@...2715...>
References: <gerrit.1728995699000.Ibaa591904095a824df2c0c5aaff73687e0af24fe@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Update macOS runners
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

From: Frank Lichtenheld <frank@...2641...>

Remove macos-12, not supported anymore.
Add macos-15, runner is available in Beta status.

Change-Id: Ibaa591904095a824df2c0c5aaff73687e0af24fe
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/780
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 1bc250d..fdd133e 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -213,16 +213,16 @@
       matrix:
         ssllib: [ openssl11, openssl3, libressl]
         build: [ normal, asan ]
-        os: [macos-12, macos-13, macos-14]
+        os: [macos-13, macos-14, macos-15]
         include:
            # macos14 and newer runners use ARM CPUs and homebrew uses /opt/homebrew/
            # on ARM instead of /usr/local/
-          - os: macos-12
-            homebrew: /usr/local/opt
           - os: macos-13
             homebrew: /usr/local/opt
           - os: macos-14
             homebrew: /opt/homebrew/opt
+          - os: macos-15
+            homebrew: /opt/homebrew/opt
           - build: asan
             cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
             ldflags: -fsanitize=address,undefined -fno-sanitize-recover=all

