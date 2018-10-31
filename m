From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 31 Oct 2018 11:22:57 +0100
Message-ID: <1540981377-22752-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tls-crypt-v2: clarify --tls-crypt-v2-genkey
 man page section
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

As kitsune1 mentioned in IRC, this section should explain that
"--tls-crypt-v2-genkey client" requires the user to supply the server
key using "--tls-crypt-v2".

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/openvpn.8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 94b5cc4..f38fba9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5314,6 +5314,11 @@ If no metadata is supplied, OpenVPN will use a 64\-bit unix timestamp
 representing the current time in UTC, encoded in network order, as metadata for
 the generated key.
 
+A tls\-crypt\-v2 client key is wrapped using a server key.  To generate a
+client key, the user must therefore supply the server key using the
+.B \-\-tls\-crypt\-v2
+option.
+
 Servers can use
 .B \-\-tls\-crypt\-v2\-verify
 to specify a metadata verification command.
-- 
2.7.4


