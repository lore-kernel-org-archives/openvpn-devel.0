From: wgh@...2548...
Date: Wed, 25 Mar 2020 15:26:24 +0300
Message-Id: <20200325122624.3142017-1-wgh@...2548...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] docs: Add reference to
 X509_LOOKUP_hash_dir(3)
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
Cc: WGH <wgh@...2548...>

From: WGH <wgh@...2548...>

This is probably the best description of the rather confusing
capath directory structure OpenSSL manual has to offer.
---
 doc/openvpn.8 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 864f94e8..74638cf3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4767,8 +4767,10 @@ option of
 .B \-hash
 option of
 .B openssl x509
-and
+,
 .B openssl crl
+and
+.BR X509_LOOKUP_hash_dir (3)
 for more information.
 
 Similarly to the
-- 
2.24.1


