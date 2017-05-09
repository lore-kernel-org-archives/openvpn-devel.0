From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 9 May 2017 12:50:32 +0200
Message-ID: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Always clear username/password from memory
	on error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

This issue was found by Quarkslab during the OSTIF-founded security audit
(issue 5.4), we agree with their analysis:

"There=E2=80=99s a special case where the client username and password are =
not
erased when the server is launched without an external script or
authentication plugin. While being invalid, this configuration does not
raise any error. If the client transmits its credentials and the session
is not established (for instance if the certificates chain has not been
verified), these credentials are not erased from memory by the server.

The likelihood of an occurrence of this issue in real life is exceptionally=
 low since an attacker
needs elevated privileges on the server to exploit this kind of information=
 leak. The severity of
this issue is rated as very low."


Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1033e58..abf5786 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2661,6 +2661,7 @@ key_method_2_read(struct buffer *buf, struct tls_mult=
i *multi, struct tls_sessio
=20
 error:
     secure_memzero(ks->key_src, sizeof(*ks->key_src));
+    secure_memzero(up, sizeof(*up));
     buf_clear(buf);
     gc_free(&gc);
     return false;
--=20
2.7.4


