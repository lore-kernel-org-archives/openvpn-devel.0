From: Janne Johansson <jan.johansson@...1...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-NfpQi4HunKaAbxICP3Dd"
Message-Id: <1017748504.1524.36.camel@...2...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenBSD diffs.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Tue Apr  2 04:02:47 2002
To: openvpn-devel@lists.sourceforge.net

--=-NfpQi4HunKaAbxICP3Dd
Content-Type: multipart/mixed; boundary="=-NmMz+LAY/T8EkEcZNASg"

--=-NmMz+LAY/T8EkEcZNASg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have made some diffs to make it compile under OpenBSD 3.0.

This does not mean that I have tested it remotely yet, since I'm still
at the "more README" stage on openvpn, but I know my way around
makefiles and includes. =3D)

In short, the diff fixes these things:

* NULL is already defined on my openbsd, #ifndef'ed it away.

* linux-specific include-files changed to fit obsd.
  These will need #ifdef's of course. I added and changed until it
  compiled, nothing more.

* the functions encrypt() and decrypt() are already defined by obsd-libc
  so they were renamed to openvpn_{en|de}crypt().


On the "I haven't tested" part, it does start and run if given
--dev tun0, and gives me 4 lines of output that says "ok so far",
so I guess it's at least close to working.


--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-NmMz+LAY/T8EkEcZNASg
Content-Disposition: attachment; filename=obsd-diff
Content-Type: text/x-patch; name=obsd-diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

diff -u openvpn-1.0.3/basic.h obsd-openvpn-1.0.3/basic.h
--- openvpn-1.0.3/basic.h	Sat Mar 23 16:56:41 2002
+++ obsd-openvpn-1.0.3/basic.h	Tue Apr  2 11:50:27 2002
@@ -37,6 +37,8 @@
 /* clear an object */
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
=20
+#ifndef NULL
 #define NULL ((void *)0)
+#endif /* NULL */
=20
 #endif
diff -u openvpn-1.0.3/crypto.c obsd-openvpn-1.0.3/crypto.c
--- openvpn-1.0.3/crypto.c	Thu Mar 28 07:50:45 2002
+++ obsd-openvpn-1.0.3/crypto.c	Tue Apr  2 12:59:00 2002
@@ -79,7 +79,7 @@
   do { msg (D_CRYPT_ERRORS, "%s: " format, error_prefix, args); goto error=
_exit; } while (false)
=20
 void
-encrypt (struct buffer *buf, struct buffer work,
+openvpn_encrypt (struct buffer *buf, struct buffer work,
 	 const struct crypto_options *opt,
 	 const struct frame* frame,
 	 const time_t current)
@@ -186,7 +186,7 @@
 }
=20
 void
-decrypt (struct buffer *buf, struct buffer work,
+openvpn_decrypt (struct buffer *buf, struct buffer work,
 	 const struct crypto_options *opt,
 	 const struct frame* frame,
 	 const time_t current)
diff -u openvpn-1.0.3/crypto.h obsd-openvpn-1.0.3/crypto.h
--- openvpn-1.0.3/crypto.h	Sun Mar 24 04:18:02 2002
+++ obsd-openvpn-1.0.3/crypto.h	Tue Apr  2 12:59:15 2002
@@ -97,12 +97,12 @@
 void init_key_ctx (struct key_ctx *key_ctx, struct key *key,
 		   const struct key_type *kt, const char *prefix);
=20
-void encrypt (struct buffer *buf, struct buffer work,
+void openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      const struct crypto_options *opt,
 	      const struct frame* frame,
 	      const time_t current);
=20
-void decrypt (struct buffer *buf, struct buffer work,
+void openvpn_decrypt (struct buffer *buf, struct buffer work,
 	      const struct crypto_options *opt,
 	      const struct frame* frame,
 	      const time_t current);
diff -u openvpn-1.0.3/openvpn.c obsd-openvpn-1.0.3/openvpn.c
--- openvpn-1.0.3/openvpn.c	Fri Mar 29 01:43:12 2002
+++ obsd-openvpn-1.0.3/openvpn.c	Tue Apr  2 12:59:57 2002
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <signal.h>
 #include <stdio.h>
+#include <sys/socket.h>
=20
 #include "openvpn.h"
 #include "common.h"
@@ -845,7 +846,7 @@
 			interval_trigger(&tmp_int, current);
 		    }
 #endif
-		  decrypt (&buf, decrypt_buf, &crypto_options, &frame, current);
+		  openvpn_decrypt (&buf, decrypt_buf, &crypto_options, &frame, current);
 #endif
 #ifdef USE_LZO
 		  if (options->comp_lzo)
@@ -882,7 +883,7 @@
 		    tls_pre_encrypt (tls_multi, &buf, &crypto_options);
 #endif
=20
-		  encrypt (&buf, encrypt_buf, &crypto_options, &frame, current);
+		  openvpn_encrypt (&buf, encrypt_buf, &crypto_options, &frame, current);
 #endif
 		  udp_socket_get_outgoing_addr (&buf, &udp_socket,
 						&to_udp_addr);
diff -u openvpn-1.0.3/socket.c obsd-openvpn-1.0.3/socket.c
--- openvpn-1.0.3/socket.c	Fri Mar 29 01:20:16 2002
+++ obsd-openvpn-1.0.3/socket.c	Tue Apr  2 12:01:10 2002
@@ -27,9 +27,10 @@
=20
 #include <netdb.h>		/* gethostbyname */
 #include <netinet/in.h>		/* struct sockaddr_in */
-#include <linux/if.h>		/* inet stuff */
+#include <net/if_tun.h>		/* inet stuff */
 #include <stdlib.h>		/* system() */
=20
+#include <sys/socket.h>
 #include "socket.h"
 #include "fdmisc.h"
 #include "error.h"
diff -u openvpn-1.0.3/socket.h obsd-openvpn-1.0.3/socket.h
--- openvpn-1.0.3/socket.h	Thu Mar 28 20:13:14 2002
+++ obsd-openvpn-1.0.3/socket.h	Tue Apr  2 13:04:30 2002
@@ -26,7 +26,9 @@
 #ifndef SOCKET_H
 #define SOCKET_H
=20
-#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+
 #include "buffer.h"
 #include "common.h"
=20
diff -u openvpn-1.0.3/ssl.c obsd-openvpn-1.0.3/ssl.c
--- openvpn-1.0.3/ssl.c	Fri Mar 29 01:43:10 2002
+++ obsd-openvpn-1.0.3/ssl.c	Tue Apr  2 13:03:08 2002
@@ -943,7 +943,7 @@
   *header =3D ks->key_id | (opcode << P_OPCODE_SHIFT);
   if (session->tls_auth.key_ctx_bi->encrypt.hmac_defined)
     {
-      encrypt (buf, null, &session->tls_auth, NULL, current); /* no encryp=
tion, only write hmac */
+      openvpn_encrypt (buf, null, &session->tls_auth, NULL, current); /* n=
o encryption, only write hmac */
       ASSERT (swap_hmac (buf, &session->tls_auth, false));
     }
   *to_udp_addr =3D ks->remote_addr;
@@ -970,7 +970,7 @@
=20
       /* authenticate only (no decrypt) and remove the hmac record
          from the head of the buffer */
-      decrypt (buf, null, co, NULL, current);
+      openvpn_decrypt (buf, null, co, NULL, current);
       if (!buf->len)
 	{
 	  msg (D_TLS_ERRORS,
diff -u openvpn-1.0.3/ssl.h obsd-openvpn-1.0.3/ssl.h
--- openvpn-1.0.3/ssl.h	Thu Mar 28 10:16:53 2002
+++ obsd-openvpn-1.0.3/ssl.h	Tue Apr  2 13:04:00 2002
@@ -28,6 +28,7 @@
 #include <openssl/ssl.h>
 #include <openssl/bio.h>
 #include <openssl/rand.h>
+#include <netinet/in.h>
 #include "basic.h"
 #include "crypto.h"
 #include "packet_id.h"
diff -u openvpn-1.0.3/tun.c obsd-openvpn-1.0.3/tun.c
--- openvpn-1.0.3/tun.c	Sat Mar 23 16:56:41 2002
+++ obsd-openvpn-1.0.3/tun.c	Tue Apr  2 12:01:55 2002
@@ -25,9 +25,7 @@
=20
 #include "config.h"
=20
-#include <sys/socket.h>
 #include <sys/ioctl.h>
-#include <linux/if.h>
 #include <fcntl.h>
=20
 #ifndef OLD_TUN_TAP

--=-NmMz+LAY/T8EkEcZNASg--

--=-NfpQi4HunKaAbxICP3Dd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8qZwYNJYxu+mj1OkRAjZKAKDosxUC6Jn3yyS6SKIiqoXNyyPTYACggApX
7bOThYikU6GXAO4o1OqzGVE=
=GNd1
-----END PGP SIGNATURE-----

--=-NfpQi4HunKaAbxICP3Dd--


