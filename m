Date: Sat, 2 Feb 2013 14:47:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130202134710.GJ953@...1296...>
References: <alpine.DEB.2.02.1301291154270.3577@...1804...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1301291154270.3577@...1804...>
Subject: Re: [Openvpn-devel] #172: NTLM auth does not work with SQUID proxy
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Joerg Willmann <joe@...1803...>
Cc: openvpn-devel@lists.sourceforge.net

--bKyqfOwhbdpXa4YI
Content-Type: multipart/mixed; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 29, 2013 at 11:55:25AM +0100, Joerg Willmann wrote:
> I was just faced with the problem described in trac issue #172.
> I was trying to use ntlm authentication against a bluecoat proxy server.
> Since the reply string of the bluecoat proxy was too long the same proble=
m=20
> occurred as described in #172:
>=20
> "NTLM Proxy-Authorization phase 3 failed: received corrupted data from=20
> proxy server"
>=20
> The patch attached to #172 solved my problem and seems to be reasonable.
>=20
> I'm just wondering what it takes to make this issue being accepted. (Sorr=
y=20
> I didn't find a description of this process in=20
> wiki/DeveloperDocumentation).
> Does it just take time or is some input required?

Thanks for bringing this to our attention again.  We've seemed to be
a bit lazy on going through trac tickets...

Anyway, for the sake of the archives, I'll append the patch below,
and if nobody NACKs it, I'll take Joerg's comment here and Chris' ack
in the trac ticket as "sufficient ACKs to go forward".

I won't claim to understand NTLM auth, but the explanation given makes
sense and the patch is harmless enough - the buf2 buffer is only used
in one other place, called "phase_2" there, and being base64-decoded
into a new buf2 which is char[128], so the extra byte is guaranteed
not to overflow anything.

inside ntlm_phase_3():

  char buf2[128]; /* decoded reply from proxy */
  ret_val =3D openvpn_base64_decode( phase_2, (void *)buf2, -1);


gert



--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6-ntlm-fix.patch"
Content-Transfer-Encoding: quoted-printable

--- openvpn-2.2.1.org/proxy.c	2011-04-27 11:52:59.000000000 +0200
+++ openvpn-2.2.1-pre-eap/proxy.c	2012-01-24 16:17:27.000000000 +0100
@@ -519,7 +519,7 @@
 {
   struct gc_arena gc =3D gc_new ();
   char buf[512];
-  char buf2[128];
+  char buf2[129];
   char get[80];
   int status;
   int nparms;
@@ -642,7 +642,7 @@
=20
               openvpn_snprintf (get, sizeof get, "%%*s NTLM %%%ds", (int) =
sizeof (buf2) - 1);
               nparms =3D sscanf (buf, get, buf2);
-              buf2[127] =3D 0; /* we only need the beginning - ensure it's=
 null terminated. */
+              buf2[128] =3D 0; /* we only need the beginning - ensure it's=
 null terminated. */
=20
               /* check for "Proxy-Authenticate: NTLM TlRM..." */
               if (nparms =3D=3D 1)

--DKU6Jbt7q3WqK7+M--

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUQ0Y3akuBuNlUUl1AQLSdAP/S8EQnJqctKkm+MFymqJ1bSxV40hPBxI7
4jm8LLcdEEwwLEPtS8zhfSqicG2JQgJbzmuEp3yq2QjBEZz0B1jFFejwHv7euuSx
S1OpdBgi2Bi+7CehS7PUr266ptCgYjzkC+kURtoK1JZJaMkpqftFId/8tz4ENAFS
ThNbFbmsg+o=
=nY7/
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

