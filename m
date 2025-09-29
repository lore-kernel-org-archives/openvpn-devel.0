From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 29 Sep 2025 17:28:41 +0200
Message-Id: <20250929152841.177424-1-frank@...2641...>
In-Reply-To: <gerrit.1759135650000.I3b1243461ec9b6e85897f452f78dc4b05f7e126d@...2715...>
References: <gerrit.1759135650000.I3b1243461ec9b6e85897f452f78dc4b05f7e126d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco-win: fix broken ASSERT in dco_new_key
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

Commit

  e77c343 ("dco_win: In dco_new_key, document size assumptions for the integer casts")

has added an ASSERT on key-id, but didn't take into account that
key-id 0 is a perfectly valid value and is the first key-id. This
essentially broke dco-win.

Fix by adjusting ASSERT to >= 0.

Change-Id: I3b1243461ec9b6e85897f452f78dc4b05f7e126d
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1223
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1223
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 4dd307f..30307de 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -541,7 +541,7 @@
     ZeroMemory(&crypto_data, sizeof(crypto_data));
 
     crypto_data.CipherAlg = dco_get_cipher(ciphername);
-    ASSERT(keyid > 0 && keyid <= UCHAR_MAX);
+    ASSERT(keyid >= 0 && keyid <= UCHAR_MAX);
     crypto_data.KeyId = (unsigned char)keyid;
     crypto_data.PeerId = peerid;
     crypto_data.KeySlot = slot;

