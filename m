From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 9 May 2017 20:32:44 +0200
Message-ID: <1494354764-19354-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <8f79c477-9952-fea3-3f55-2a3d4541760a@...1435...>
References: <8f79c477-9952-fea3-3f55-2a3d4541760a@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Always clear username/password from
	memory on error
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
(issue 5.4), we are with their analysis:

"There=E2=80=99s a special case where the client username and password are =
not
erased when the server is launched without an external script or
authentication plugin. While being invalid, this configuration does not
raise any error. If the client transmits its credentials and the session
is not established (for instance if the certificates chain has not been
verified), these credentials are not erased from memory by the server.

The likelihood of an occurrence of this issue in real life is
exceptionally low since an attacker needs elevated privileges on the
server to exploit this kind of information leak. The severity of this
issue is rated as very low."

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: only clear up if it is non-null

 src/openvpn/ssl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4fca283..21c9d6f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2492,7 +2492,7 @@ key_method_2_read(struct buffer *buf, struct tls_mult=
i *multi, struct tls_sessio
=20
     struct gc_arena gc =3D gc_new();
     char *options;
-    struct user_pass *up;
+    struct user_pass *up =3D NULL;
=20
     /* allocate temporary objects */
     ALLOC_ARRAY_CLEAR_GC(options, char, TLS_OPTIONS_LEN, &gc);
@@ -2654,6 +2654,10 @@ key_method_2_read(struct buffer *buf, struct tls_mul=
ti *multi, struct tls_sessio
=20
 error:
     secure_memzero(ks->key_src, sizeof(*ks->key_src));
+    if (up)
+    {
+        secure_memzero(up, sizeof(*up));
+    }
     buf_clear(buf);
     gc_free(&gc);
     return false;
--=20
2.7.4


