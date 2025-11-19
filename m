From: Gert Doering <gert@...1296...>
Date: Wed, 19 Nov 2025 17:29:28 +0100
Message-ID: <20251119162934.15672-1-gert@...1296...>
In-Reply-To: <gerrit.1763565716000.I1633ee6207443e041434e9f0dda98afd5a22e1b4@...2715...>
References: <gerrit.1763565716000.I1633ee6207443e041434e9f0dda98afd5a22e1b4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Add macos-26 and remove OpenSSL 1.1
 builds on macOS
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

The new runner doesn't have OpenSSL 1.1 available anymore
via homebrew. The formula is also marked as "deprecated"
for older macOS versions. So I think it is okay to drop
it.

Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1382
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1382
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 96d2292..357072d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -210,9 +210,9 @@
     strategy:
       fail-fast: false
       matrix:
-        ssllib: [openssl@...2560..., openssl@...1554..., libressl]
+        ssllib: [openssl@...1554..., libressl]
         build: [normal, asan]
-        os: [macos-14, macos-15]
+        os: [macos-14, macos-15, macos-26]
         include:
           - build: asan
             cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"

