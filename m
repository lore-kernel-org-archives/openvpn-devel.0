From: Gert Doering <gert@...1296...>
Date: Tue, 10 Feb 2026 16:20:30 +0100
Message-ID: <20260210152035.1273-1-gert@...1296...>
In-Reply-To: <gerrit.1770732547000.Ie35099b114c510e55292090c34b9d950b1f03947@...2715...>
References: <gerrit.1770732547000.Ie35099b114c510e55292090c34b9d950b1f03947@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] crypto: Do not claim we will remove
 support for BF-CBC in 2.7
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

Change-Id: Ie35099b114c510e55292090c34b9d950b1f03947
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1511
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1511
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e3d1fa5..9a4269c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -863,7 +863,7 @@
             " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
             "using a --cipher with a larger block size (e.g. AES-256-CBC). "
             "Support for these insecure ciphers will be removed in "
-            "OpenVPN 2.7.",
+            "OpenVPN 2.8.",
             ciphername, cipher_kt_block_size(ciphername) * 8);
     }
 }

