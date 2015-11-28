Date: Sat, 28 Nov 2015 15:07:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151128140744.GA12133@...1296...>
References: <1448456220-2042-1-git-send-email-heiko.hund@...1489...>
	<201511281341.tASDfilE011918@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <201511281341.tASDfilE011918@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: extend management interface
 command state
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Sat, Nov 28, 2015 at 02:41:44PM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 2191c4716537b3d3e81b0e746f666dd365b65abd
> Author: Heiko Hund
> Date:   Wed Nov 25 13:57:00 2015 +0100

... and while it works nicely on Linux, it blows off all the BSDs...

+init.o init.c
init.c: In function 'initialization_sequence_completed':
init.c:1296: error: 'struct in_addr' has no member named 'ipi_spec_dst'
*** Error code 1

socket.c suggests that there are two variants of this; IP_PKTINFO and
IP_RECVDSTADDR, and ipi_spec_dst belongs to IP_PKTINFO...

            case AF_INET:
                {
                  struct openvpn_sockaddr sa;
                  CLEAR (sa);
                  sa.addr.in4.sin_family =3D AF_INET;
#ifdef IP_PKTINFO
                  sa.addr.in4.sin_addr =3D act->pi.in4.ipi_spec_dst;
                  if_indextoname(act->pi.in4.ipi_ifindex, ifname);
#elif defined(IP_RECVDSTADDR)
                  sa.addr.in4.sin_addr =3D act->pi.in4;
                  ifname[0]=3D0;


(don't we all love socket programming?)

can you send a followup patch, or shall I tackle this (having the BSDs to
test)?  How can I see if this actually works?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlm046kuBuNlUUl1AQJ06wQAhY2iGGl4X9yw6ee/Kg6nCJflovKrOSw5
/fkLdoRkCq4SG8u2Ux2gkJs/7J09tkl2pLoL+AU6bzVyZzzT3yTX8DVM8+epYGSb
y7Gx5Tua1VaXItQRtbFVv2SqaECldclbbOQxNbSqR4QAWvfF7UVDqlb1ic+lUY5A
VFGRuy5CtGg=
=CHqh
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

