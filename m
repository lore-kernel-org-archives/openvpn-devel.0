Subject: Re: [Openvpn-devel] More BSD TUN info.
From: Janne Johansson <jan.johansson@...1...>
In-Reply-To: <01d701c1dbba$1db49b20$1000000a@...4...>
References: <1017760165.9891.85.camel@...2...><008901c1da97$e4ce0b70$1000000a@...4...>
	<1017818817.1524.56.camel@...2...> <01ba01c1dbb5$2a3367a0$1000000a@...4...>
	<1017910625.1562.14.camel@...2...>  <01d701c1dbba$1db49b20$1000000a@...4...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ouWlfm/ZINGpeuvE7Ctr"
Message-Id: <1017915300.1563.18.camel@...2...>
Mime-Version: 1.0
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
Date: Thu Apr  4 02:16:02 2002
To: openvpn-devel@lists.sourceforge.net

--=-ouWlfm/ZINGpeuvE7Ctr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> >Yes, but since BSD wont let you choose if you want it or not, and the
> chance of changing Linux-TUN-drivers now is slim, I guess it has to be
> the application that takes care of this. I'll try to make a patch and
> test it, and send you the diff later.
>=20
> Some thoughts:
>=20
> * probably the best place to add/remove the AF_INET is by calling some
> routine in the main event loop in openvpn.c, conditional on --remote-is-b=
sd.
>=20
> * add and remove u_int_32 by manipulating struct buffer (see buf_prepend =
and
> buf_advance in particular).
>=20
> * remember that when you add a new buffer prepend item, you must modify t=
he
> appropriate struct frame which will contain the MTU parms, so that
> everything gets sized right.  For an example, see
> crypto_adjust_frame_parameters().

I have made an attempt but I must warn you, I'm no guru on pointers
and stuff, so I'd like you to check my calls to see that I'm on the
right track please:
I will test this asap and tell you if it works.

diff -ru openvpn-1.0.3/openvpn.c new_openvpn-1.0.3/openvpn.c
--- openvpn-1.0.3/openvpn.c	Fri Mar 29 01:43:12 2002
+++ new_openvpn-1.0.3/openvpn.c	Thu Apr  4 12:09:32 2002
@@ -91,6 +91,8 @@
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
@@ -210,6 +212,7 @@
   o->verbosity =3D 1;
   o->bind_local =3D true;
   o->tun_mtu =3D DEFAULT_TUN_MTU;
+  o->remotebsd =3D false;
 #ifdef USE_LZO
   o->comp_lzo_adaptive =3D true;
 #endif
@@ -262,6 +265,7 @@
   SHOW_INT (nice);
   SHOW_INT (verbosity);
   SHOW_BOOL (gremlin);
+  SHOW_BOOL (remotebsd);
=20
 #ifdef USE_LZO
   SHOW_BOOL (comp_lzo);
@@ -426,6 +430,11 @@
=20
 static void frame_finalize(struct frame *frame, const struct options *opti=
ons)
 {
+  if (options->remotebsd)
+    {
+      frame->extra_frame +=3D 4;
+    }
+
   if (options->tun_mtu_defined)
     {
       frame->mtu =3D options->tun_mtu;
@@ -872,6 +881,11 @@
 	      check_status (buf.len, "read from tun");
 	      if (buf.len > 0)
 		{
+		  if (options->remotebsd)
+		    {
+		      buf_advance(&buf, sizeof(u_int32_t));
+		    }
+
 #ifdef USE_LZO
 		  if (options->comp_lzo)
 		    lzo_compress (&buf, lzo_compress_buf, &lzo_compwork, &frame, current=
);
@@ -905,6 +919,13 @@
 	  if (FD_ISSET (td, &writes))
 	    {
 	      int size;
+
+	      if (options->remotebsd)
+		{
+		  u_int32_t af =3D htonl(AF_INET);
+		  buf_write_prepend(&to_tun, &af ,sizeof (u_int32_t));
+		}
+
 	      ASSERT (to_tun.len > 0 && to_tun.len <=3D MAX_RW_SIZE_TUN(&frame));
 	      size =3D write (td, BPTR (&to_tun), BLEN (&to_tun));
 	      check_status (size, "write to tun");
@@ -1155,6 +1176,10 @@
 	{
 	  options.bind_local =3D false;
 	}
+      else if (streq (p1, "--remote-bsd"))
+	{
+	  options.remotebsd =3D true;
+	}
 #ifdef USE_LZO
       else if (streq (p1, "--comp-lzo"))
 	{
diff -ru openvpn-1.0.3/openvpn.h new_openvpn-1.0.3/openvpn.h
--- openvpn-1.0.3/openvpn.h	Sat Mar 30 03:24:00 2002
+++ new_openvpn-1.0.3/openvpn.h	Thu Apr  4 11:16:46 2002
@@ -53,6 +53,7 @@
   int nice;
   int verbosity;
   bool gremlin;
+  bool remotebsd;
=20
 #ifdef USE_LZO
   bool comp_lzo;

--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-ouWlfm/ZINGpeuvE7Ctr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8rCekNJYxu+mj1OkRAhtBAKDGHKdf4x5iAhP2LkryVFljY7LkbwCgs91W
UCmMdCZf1UJSlMh5g1U22Ug=
=xJnZ
-----END PGP SIGNATURE-----

--=-ouWlfm/ZINGpeuvE7Ctr--


