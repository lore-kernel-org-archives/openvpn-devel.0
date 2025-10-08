From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 15:10:54 +0200
Message-ID: <20251008131101.21498-1-gert@...1296...>
In-Reply-To: <gerrit.1759928297000.I7d9ffdc7d109b3fcbd91543506f16d23000fb136@...2715...>
References: <gerrit.1759928297000.I7d9ffdc7d109b3fcbd91543506f16d23000fb136@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GHA: Run options_parse test for MinGW
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

Github: #859
Change-Id: I7d9ffdc7d109b3fcbd91543506f16d23000fb136
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1257
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1257
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 1cef154..e068f58 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -114,7 +114,7 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
 
     runs-on: windows-2025
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"

