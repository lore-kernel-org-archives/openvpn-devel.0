MIME-Version: 1.0
In-Reply-To: <AANLkTik4eydtMdKm7un1cbf6YvLUQi70OxjXaimqELR8@...278...>
References: <AANLkTik4eydtMdKm7un1cbf6YvLUQi70OxjXaimqELR8@...278...>
Date: Tue, 26 Oct 2010 21:00:01 -0700
Message-ID: <AANLkTi=dkqULV7Yyh=bKunrKAVohXjkPSM0QsskQ_hLu@...278...>
From: Blaise Gassend <blaise@...1426...>
Subject: [Openvpn-devel] Fwd: PATCH: floating-tls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

To allow seamless roaming of our robots at willowgarage
(http://willowgarage.com), I have put together a patch that allows TLS
connections to float. I would like to put this patch up for critique
and possible inclusion into mainline openvpn. The general approach has
been to prefix a few bytes at the start of each packet which contain
an opcode and a unique identifier (random number) for the session.
That identifier is used instead of the IP address for determining
which connection the packet belongs to.

Regards,
Blaise

--- a/configure.ac
+++ b/configure.ac
@@ -129,6 +129,12 @@
=A0 =A0[FRAGMENT=3D"yes"]
=A0)

+AC_ARG_ENABLE(floating-tls,
+ =A0 [ =A0--disable-floating-tls =A0Disable floating tls support (--floati=
ng-tls)],
+ =A0 [FLOATING_TLS=3D"$enableval"],
+ =A0 [FLOATING_TLS=3D"yes"]
+)
+
=A0AC_ARG_ENABLE(multihome,
=A0 =A0[ =A0--disable-multihome =A0 =A0 Disable multi-homed UDP server supp=
ort
(--multihome)],
=A0 =A0[MULTIHOME=3D"$enableval"],
@@ -791,6 +797,11 @@
=A0 =A0AC_DEFINE(ENABLE_HTTP_PROXY, 1, [Enable HTTP proxy support])
=A0fi

+dnl compile --floating-tls option
+if test "$FLOATING_TLS" =3D "yes"; then
+ =A0 AC_DEFINE(FLOATING_TLS, 1, [Enable floating-tls UDP server capability=
])
+fi
+
=A0dnl compile --multihome option
=A0if test "$MULTIHOME" =3D "yes"; then
=A0 =A0AC_DEFINE(ENABLE_MULTIHOME, 1, [Enable multi-homed UDP server capabi=
lity])
--- a/forward.c
+++ b/forward.c
@@ -39,6 +39,10 @@
=A0#include "occ-inline.h"
=A0#include "ping-inline.h"

+#ifdef FLOATING_TLS
+#include "ssl.h"
+#endif
+
=A0/* show event wait debugging info */

=A0#ifdef ENABLE_DEBUG
@@ -834,7 +838,11 @@
=A0 =A0 =A0 =A0*
=A0 =A0 =A0 =A0* Also, update the persisted version of our packet-id.
=A0 =A0 =A0 =A0*/
- =A0 =A0 =A0if (!TLS_MODE (c))
+ =A0 =A0 =A0if (!TLS_MODE (c)
+#ifdef FLOATING_TLS
+ =A0 =A0 =A0 =A0 =A0|| c->options.floating_tls
+#endif
+ =A0 =A0 =A0 =A0 =A0)
=A0 =A0 =A0 =A0link_socket_set_outgoing_addr (&c->c2.buf, lsi, &c->c2.from,
NULL, c->c2.es);

=A0 =A0 =A0 /* reset packet received timer */
@@ -1088,6 +1096,21 @@
=A0 =A0 =A0 =A0 =A0 =A0/* If Socks5 over UDP, prepend header */
=A0 =A0 =A0 =A0 =A0 =A0socks_preprocess_outgoing_link (c, &to_addr, &size_d=
elta);
=A0#endif
+
+#ifdef FLOATING_TLS
+ =A0 =A0 =A0 =A0 =A0 =A0if (c->c2.link_socket->info.proto =3D=3D PROTO_UDP=
v4 &&
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c->options.floating_tls &&
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c->options.tls_client)
+ =A0 =A0 =A0 =A0 =A0 =A0{
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (c->floating_tls_prefix =3D=3D 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RAND_bytes((uint8_t *) &c->floating_tls_pr=
efix,
sizeof(c->floating_tls_prefix));
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0struct buffer *buf =3D &c->c2.to_link;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t opcode =3D FLOATING_TLS_OPCODE |
sizeof(c->floating_tls_prefix);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0ASSERT (buf_write_prepend (buf,
&c->floating_tls_prefix, sizeof (c->floating_tls_prefix)));
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0ASSERT (buf_write_prepend (buf, &opcode, sizeo=
f (opcode)));
+ =A0 =A0 =A0 =A0 =A0 =A0}
+#endif
=A0 =A0 =A0 =A0 =A0 =A0/* Send packet */
=A0 =A0 =A0 =A0 =A0 =A0size =3D link_socket_write (c->c2.link_socket,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
&c->c2.to_link,
--- a/init.c
+++ b/init.c
@@ -1826,6 +1826,10 @@
=A0 to.disable_occ =3D !options->occ;
=A0#endif

+#ifdef FLOATING_TLS
+ =A0to.floating_tls =3D options->floating_tls;
+#endif
+
=A0 to.verify_command =3D options->tls_verify;
=A0 to.verify_x509name =3D options->tls_remote;
=A0 to.crl_file =3D options->crl_file;
--- a/mudp.c
+++ b/mudp.c
@@ -31,6 +31,10 @@

=A0#include "memdbg.h"

+#ifdef FLOATING_TLS
+#include "ssl.h"
+#endif
+
=A0/*
=A0* Get a client instance based on real address. =A0If
=A0* the instance doesn't exist, create it while
@@ -44,8 +48,36 @@
=A0 struct mroute_addr real;
=A0 struct multi_instance *mi =3D NULL;
=A0 struct hash *hash =3D m->hash;
+ =A0bool ret =3D false;
+
+#ifdef FLOATING_TLS
+ =A0// Check if this is a floating-tls packet
+ =A0if (m->top.c2.buf.len > 0)
+ =A0{
+ =A0 =A0uint8_t c =3D *BPTR (&m->top.c2.buf);
+ =A0 =A0if ((c & FLOATING_TLS_OPCODE_MASK) =3D=3D FLOATING_TLS_OPCODE)
+ =A0 =A0{
+ =A0 =A0 =A0int len =3D c & FLOATING_TLS_LENGTH_MASK;
+ =A0 =A0 =A0uint8_t *id =3D BPTR (&m->top.c2.buf) + 1;
+
+ =A0 =A0 =A0if (buf_advance(&m->top.c2.buf, len + 1))
+ =A0 =A0 =A0{
+ =A0 =A0 =A0 =A0int i;
+ =A0 =A0 =A0 =A0real.type =3D MR_ADDR_IPV4 | MR_WITH_PORT;
+ =A0 =A0 =A0 =A0real.netbits =3D 0;
+ =A0 =A0 =A0 =A0real.len =3D len;
+ =A0 =A0 =A0 =A0memcpy (real.addr, id, real.len);
+ =A0 =A0 =A0 =A0ret =3D true;
+ =A0 =A0 =A0}
+ =A0 =A0}
+ =A0}
+#endif
+
+ =A0// Not a floating-tls packet
+ =A0if (!ret)
+ =A0 =A0ret =3D mroute_extract_openvpn_sockaddr (&real, &m->top.c2.from.de=
st, true);

- =A0if (mroute_extract_openvpn_sockaddr (&real, &m->top.c2.from.dest, true=
))
+ =A0if (ret)
=A0 =A0 {
=A0 =A0 =A0 struct hash_element *he;
=A0 =A0 =A0 const uint32_t hv =3D hash_value (hash, &real);
--- a/openvpn.h
+++ b/openvpn.h
@@ -484,6 +484,10 @@
=A0 /* persistent across SIGHUP */
=A0 struct context_persist persist;

+#ifdef FLOATING_TLS
+ =A0uint64_t floating_tls_prefix;
+#endif
+
=A0 /* level 0 context contains data related to
=A0 =A0 =A0once-per OpenVPN instantiation events
=A0 =A0 =A0such as daemonization */
--- a/options.c
+++ b/options.c
@@ -126,6 +126,7 @@
=A0 " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Set n=3D\"infinite\" to retry inde=
finitely.\n"
=A0 "--float =A0 =A0 =A0 =A0 : Allow remote to change its IP address/port, =
such
as through\n"
=A0 " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DHCP (this is the default if --rem=
ote is not used).\n"
+ =A0"--floating-tls =A0: Allows floating in multi-tls sessions.\n"
=A0 "--ipchange cmd =A0: Execute shell command cmd on remote ip address ini=
tial\n"
=A0 " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setting or change -- execute as: c=
md ip-address port#\n"
=A0 "--port port =A0 =A0 : TCP/UDP port # for both local and remote.\n"
@@ -1334,6 +1335,10 @@
=A0 SHOW_BOOL (tls_exit);

=A0 SHOW_STR (tls_auth_file);
+
+#ifdef FLOATING_TLS
+ =A0SHOW_BOOL (floating_tls);
+#endif
=A0#endif
=A0#endif

@@ -1909,6 +1914,9 @@
=A0 =A0 =A0 MUST_BE_UNDEF (transition_window);
=A0 =A0 =A0 MUST_BE_UNDEF (tls_auth_file);
=A0 =A0 =A0 MUST_BE_UNDEF (single_session);
+#ifdef FLOATING_TLS
+ =A0 =A0 =A0MUST_BE_UNDEF (floating_tls);
+#endif
=A0 =A0 =A0 MUST_BE_UNDEF (tls_exit);
=A0 =A0 =A0 MUST_BE_UNDEF (crl_file);
=A0 =A0 =A0 MUST_BE_UNDEF (key_method);
@@ -2339,6 +2347,11 @@
=A0 =A0 =A0 =A0 =A0buf_printf (&out, ",no-iv");
=A0 =A0 =A0 }

+#ifdef FLOATING_TLS
+ =A0if (o->floating_tls)
+ =A0 =A0buf_printf (&out, ",floating-tls");
+#endif
+
=A0#ifdef USE_SSL
=A0 /*
=A0 =A0* SSL Options
@@ -5413,6 +5426,13 @@
=A0 =A0 =A0 VERIFY_PERMISSION (OPT_P_GENERAL);
=A0 =A0 =A0 options->single_session =3D true;
=A0 =A0 }
+#ifdef FLOATING_TLS
+ =A0else if (streq (p[0], "floating-tls"))
+ =A0 =A0{
+ =A0 =A0 =A0VERIFY_PERMISSION (OPT_P_GENERAL);
+ =A0 =A0 =A0options->floating_tls =3D true;
+ =A0 =A0}
+#endif
=A0 else if (streq (p[0], "tls-exit"))
=A0 =A0 {
=A0 =A0 =A0 VERIFY_PERMISSION (OPT_P_GENERAL);
--- a/options.h
+++ b/options.h
@@ -168,6 +168,10 @@
=A0 bool genkey;
=A0#endif

+#ifdef FLOATING_TLS
+ =A0bool floating_tls;
+#endif
+
=A0 /* Networking parms */
=A0 struct connection_entry ce;

--- a/ssl.c
+++ b/ssl.c
@@ -4160,7 +4160,12 @@
=A0#ifdef ENABLE_DEF_AUTH
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& !ks->auth_deferred
=A0#endif
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && link_socket_actual_match (from, &ks->r=
emote_addr))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (
+#ifdef FLOATING_TLS
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0multi->opt.floating_tls ||
+#endif
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0link_socket_actual_match (from, &k=
s->remote_addr)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0))
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* return appropriate data channel decry=
pt key in opt */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0opt->key_ctx_bi =3D &ks->key;
@@ -4403,7 +4408,11 @@
=A0 =A0 =A0 =A0 =A0 =A0 =A0/*
=A0 =A0 =A0 =A0 =A0 =A0 =A0 * Verify remote IP address
=A0 =A0 =A0 =A0 =A0 =A0 =A0 */
- =A0 =A0 =A0 =A0 =A0 =A0 if (!new_link && !link_socket_actual_match
(&ks->remote_addr, from))
+ =A0 =A0 =A0 =A0 =A0 =A0 if (!new_link
+#ifdef FLOATING_TLS
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& !multi->opt.floating_tls
+#endif
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& !link_socket_actual_match (&ks->rem=
ote_addr, from))
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg (D_TLS_ERRORS, "TLS Error: Received =
control packet from
unexpected IP addr: %s",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_link_socket_actual (from, =
&gc));
@@ -4468,7 +4477,11 @@
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ks->remote_addr =3D *from;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0++multi->n_sessions;
=A0 =A0 =A0 =A0 =A0 =A0 =A0}
- =A0 =A0 =A0 =A0 =A0 else if (!link_socket_actual_match (&ks->remote_addr,=
 from))
+ =A0 =A0 =A0 =A0 =A0 else if (
+#ifdef FLOATING_TLS
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!multi->opt.floating_tls &&
+#endif
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!link_socket_actual_match (&ks->remote_add=
r, from))
=A0 =A0 =A0 =A0 =A0 =A0 =A0{
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg (D_TLS_ERRORS,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "TLS Error: Existing session contro=
l channel packet from
unknown IP address: %s",
--- a/ssl.h
+++ b/ssl.h
@@ -221,6 +221,13 @@
=A0#define P_FIRST_OPCODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
=A0#define P_LAST_OPCODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08

+/* Extra opcodes for floating TLS */
+#ifdef FLOATING_TLS
+#define FLOATING_TLS_OPCODE_MASK 0xF0
+#define FLOATING_TLS_OPCODE 0xF0
+#define FLOATING_TLS_LENGTH_MASK 0x0F
+#endif
+
=A0/* key negotiation states */
=A0#define S_ERROR =A0 =A0 =A0 =A0 =A0-1
=A0#define S_UNDEF =A0 =A0 =A0 =A0 =A0 0
@@ -416,6 +423,10 @@
=A0 int key_method;
=A0 bool replay;
=A0 bool single_session;
+#ifdef FLOATING_TLS
+ =A0bool floating_tls;
+#endif
+
=A0#ifdef ENABLE_OCC
=A0 bool disable_occ;
=A0#endif
--- a/openvpn.8
+++ b/openvpn.8
@@ -573,6 +573,10 @@
=A0option.
=A0.\"*********************************************************
=A0.TP
+.B \-\-floating-tls
+Allows tls connections to float.
+.\"*********************************************************
+.TP
=A0.B \-\-ipchange cmd
=A0Execute shell command
=A0.B cmd

