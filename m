From: Janne Johansson <jan.johansson@...1...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ag7Kbk/9U+F3QtpRjMbB"
Message-Id: <1017930178.2718.47.camel@...2...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Now it works far better on/against BSD.
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
Date: Thu Apr  4 06:25:23 2002
To: openvpn-devel@lists.sourceforge.net

--=-ag7Kbk/9U+F3QtpRjMbB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Ok, this is tested in cleartext tunnel mode, and ssl-with-preshared-key.

Both methods work if the Linux side has "--remote-bsd" on the command
line, and they do not work without it.
(Given that the remote IS bsd of course =3D)
Both machines were little-endian, I haven't tested BE machines yet.
(I have a BSD sparc that I can test with later)

I haven't tested lzo yet, nor certificate-based encryption, but I don't
think they will cause more problems now that SSL works.

It compiles cleanly on Linux2.4 and with 2 warnings on OpenBSD3.0.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
gcc -g -O2  -I/usr/local/include  -c openvpn.c
openvpn.c: In function `openvpn':
openvpn.c:777: warning: passing arg 5 of `tls_multi_process' from
incompatible pointer type
openvpn.c:780: warning: passing arg 3 of `interval_set_timeout' from
incompatible pointer type
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Weird.

Also, I'm not sure if the frame-extension stuff
(+sizeof(u_int32_t)  bytes if remote is bsd)
is 100% correct for all cases but at least pings work. =3D)
Please look over that part.

The line I used on Linux was: (got 10.0.0.2 for its address)
prompt> ./openvpn --local 1.2.3.4 --remote 2.3.4.5 --dev tun
--remote-bsd&
prompt> ifconfig tun0 10.0.0.2 pointopoint 10.0.0.1 mtu 1450 up

On BSD: (Which got 10.0.0.1 as the local tun-ip-address)
prompt> ./openvpn --local 2.3.4.5 --remote 1.2.3.4 --dev tun0 &
prompt> ifconfig tun0 10.0.0.1 10.0.0.2 mtu 1450 up
...
prompt> ifconfig tun0 delete

On BSD, the tun device is always refered to by number (tun0)
and it will not be brought down on openvpn exits like on Linux.
Apart from that, it's quite straightforward.

It should be easy(er) to make a Net/FreeBSD/Solaris port
now if anyone wants.

This patch is against a clean 1.0.3 and incorporates the
NULL-fix, and the de/encrypt() -> openvpn_de/encrypt() rename.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dcut here=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -ru openvpn-1.0.3/basic.h obsd-openvpn-1.0.3/basic.h
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
diff -ru openvpn-1.0.3/crypto.c obsd-openvpn-1.0.3/crypto.c
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
diff -ru openvpn-1.0.3/crypto.h obsd-openvpn-1.0.3/crypto.h
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
diff -ru openvpn-1.0.3/openvpn.c obsd-openvpn-1.0.3/openvpn.c
--- openvpn-1.0.3/openvpn.c	Fri Mar 29 01:43:12 2002
+++ obsd-openvpn-1.0.3/openvpn.c	Thu Apr  4 14:45:09 2002
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <signal.h>
 #include <stdio.h>
+#include <sys/socket.h>
=20
 #include "openvpn.h"
 #include "common.h"
@@ -91,6 +92,8 @@
   "                : 8 -- show all debug info\n"
   "--gremlin       : Simulate dropped & corrupted packets + network outage=
s\n"
   "                  to test robustness of protocol (for debugging only).\=
n"
+  "--remote-bsd    : If the remote system is using BSD tun devices that ad=
d\n"
+  "                  protocol info on each packet sent.\n"
 #ifdef USE_LZO
   "--comp-lzo      : Use fast LZO compression -- may add up to 1 byte per\=
n"
   "                  packet for uncompressible data.\n"
@@ -210,6 +213,7 @@
   o->verbosity =3D 1;
   o->bind_local =3D true;
   o->tun_mtu =3D DEFAULT_TUN_MTU;
+  o->remotebsd =3D false;
 #ifdef USE_LZO
   o->comp_lzo_adaptive =3D true;
 #endif
@@ -262,6 +266,7 @@
   SHOW_INT (nice);
   SHOW_INT (verbosity);
   SHOW_BOOL (gremlin);
+  SHOW_BOOL (remotebsd);
=20
 #ifdef USE_LZO
   SHOW_BOOL (comp_lzo);
@@ -426,6 +431,17 @@
=20
 static void frame_finalize(struct frame *frame, const struct options *opti=
ons)
 {
+  if (options->remotebsd)
+    {
+      frame->extra_frame +=3D 4;
+    }
+#ifdef __OpenBSD__
+  else
+    {
+      frame->extra_frame +=3D 4;
+    }
+#endif /* OBSD */
+
   if (options->tun_mtu_defined)
     {
       frame->mtu =3D options->tun_mtu;
@@ -836,6 +852,11 @@
 		   print_sockaddr (&from), PROTO_DUMP (&buf));
 	      if (buf.len > 0)
 		{
+
+#ifdef __OpenBSD__
+		  buf_advance(&buf, sizeof(u_int32_t));
+#endif /* OBSD */
+
 		  udp_socket_incoming_addr (&buf, &udp_socket, &from);
 #ifdef USE_CRYPTO
 #ifdef USE_SSL
@@ -845,7 +866,7 @@
 			interval_trigger(&tmp_int, current);
 		    }
 #endif
-		  decrypt (&buf, decrypt_buf, &crypto_options, &frame, current);
+		  openvpn_decrypt (&buf, decrypt_buf, &crypto_options, &frame, current);
 #endif
 #ifdef USE_LZO
 		  if (options->comp_lzo)
@@ -872,6 +893,10 @@
 	      check_status (buf.len, "read from tun");
 	      if (buf.len > 0)
 		{
+#ifdef __OpenBSD__
+		      buf_advance(&buf, sizeof(u_int32_t));
+#endif /* OBSD */
+
 #ifdef USE_LZO
 		  if (options->comp_lzo)
 		    lzo_compress (&buf, lzo_compress_buf, &lzo_compwork, &frame, current=
);
@@ -882,7 +907,7 @@
 		    tls_pre_encrypt (tls_multi, &buf, &crypto_options);
 #endif
=20
-		  encrypt (&buf, encrypt_buf, &crypto_options, &frame, current);
+		  openvpn_encrypt (&buf, encrypt_buf, &crypto_options, &frame, current);
 #endif
 		  udp_socket_get_outgoing_addr (&buf, &udp_socket,
 						&to_udp_addr);
@@ -905,6 +930,10 @@
 	  if (FD_ISSET (td, &writes))
 	    {
 	      int size;
+#ifdef __OpenBSD__
+	      u_int32_t af =3D htonl(AF_INET);
+	      buf_write_prepend(&to_tun, &af ,sizeof (u_int32_t));
+#endif /* OBSD */=09=20=20=20=20=20=20
 	      ASSERT (to_tun.len > 0 && to_tun.len <=3D MAX_RW_SIZE_TUN(&frame));
 	      size =3D write (td, BPTR (&to_tun), BLEN (&to_tun));
 	      check_status (size, "write to tun");
@@ -917,6 +946,12 @@
 	      socklen_t tolen =3D sizeof (to_udp_addr);
 	      int size;
=20
+	      if (options->remotebsd)
+		{
+		  u_int32_t af =3D htonl(AF_INET);
+		  buf_write_prepend(&to_udp, &af ,sizeof (u_int32_t));
+		}
+
 	      ASSERT (to_udp.len > 0 && to_udp.len <=3D max_rw_size_udp);
 	      ASSERT (ADDR (to_udp_addr));
 	      if (!options->gremlin || ask_gremlin())
@@ -1154,6 +1189,10 @@
       else if (streq (p1, "--nobind"))
 	{
 	  options.bind_local =3D false;
+	}
+      else if (streq (p1, "--remote-bsd"))
+	{
+	  options.remotebsd =3D true;
 	}
 #ifdef USE_LZO
       else if (streq (p1, "--comp-lzo"))
diff -ru openvpn-1.0.3/openvpn.h obsd-openvpn-1.0.3/openvpn.h
--- openvpn-1.0.3/openvpn.h	Sat Mar 30 03:24:00 2002
+++ obsd-openvpn-1.0.3/openvpn.h	Thu Apr  4 13:17:09 2002
@@ -53,6 +53,7 @@
   int nice;
   int verbosity;
   bool gremlin;
+  bool remotebsd;
=20
 #ifdef USE_LZO
   bool comp_lzo;
Only in obsd-openvpn-1.0.3: out
diff -ru openvpn-1.0.3/socket.c obsd-openvpn-1.0.3/socket.c
--- openvpn-1.0.3/socket.c	Fri Mar 29 01:20:16 2002
+++ obsd-openvpn-1.0.3/socket.c	Thu Apr  4 15:45:19 2002
@@ -27,7 +27,13 @@
=20
 #include <netdb.h>		/* gethostbyname */
 #include <netinet/in.h>		/* struct sockaddr_in */
-#include <linux/if.h>		/* inet stuff */
+
+#ifdef __OpenBSD__
+#include <net/if_tun.h>		/* inet stuff */
+#else
+#include <linux/if_tun.h>
+#endif /* OBSD */
+
 #include <stdlib.h>		/* system() */
=20
 #include "socket.h"
diff -ru openvpn-1.0.3/socket.h obsd-openvpn-1.0.3/socket.h
--- openvpn-1.0.3/socket.h	Thu Mar 28 20:13:14 2002
+++ obsd-openvpn-1.0.3/socket.h	Thu Apr  4 16:00:56 2002
@@ -26,7 +26,10 @@
 #ifndef SOCKET_H
 #define SOCKET_H
=20
+#include <netinet/in.h>
+#include <sys/socket.h>
 #include <arpa/inet.h>
+
 #include "buffer.h"
 #include "common.h"
=20
diff -ru openvpn-1.0.3/ssl.c obsd-openvpn-1.0.3/ssl.c
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
diff -ru openvpn-1.0.3/ssl.h obsd-openvpn-1.0.3/ssl.h
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
diff -ru openvpn-1.0.3/tun.c obsd-openvpn-1.0.3/tun.c
--- openvpn-1.0.3/tun.c	Sat Mar 23 16:56:41 2002
+++ obsd-openvpn-1.0.3/tun.c	Thu Apr  4 15:19:30 2002
@@ -25,12 +25,12 @@
=20
 #include "config.h"
=20
-#include <sys/socket.h>
 #include <sys/ioctl.h>
-#include <linux/if.h>
 #include <fcntl.h>
=20
 #ifndef OLD_TUN_TAP
+#include <sys/socket.h>
+#include <linux/if.h>
 #include <linux/if_tun.h>
 #endif /* OLD_TUN_TAP */
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3Dcut here=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-ag7Kbk/9U+F3QtpRjMbB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8rGHCNJYxu+mj1OkRAqodAKCtoYieiizlaCWwRMlyvrxsdSByMgCcDjoV
iapPGKLVRq9T1r2fbA0VpuY=
=yp/l
-----END PGP SIGNATURE-----

--=-ag7Kbk/9U+F3QtpRjMbB--


