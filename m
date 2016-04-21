Date: Thu, 21 Apr 2016 19:25:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160421172555.GI53051@...1296...>
References: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
	<CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
	<A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO+9/CRZBGNspxuY"
Content-Disposition: inline
In-Reply-To: <A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
Subject: Re: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
 supplied data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--SO+9/CRZBGNspxuY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 21, 2016 at 08:51:27AM +0200, Jens wrote:
> > This is without a doubt an improvement, but it still leaves an
> > opportunity open to achieve a buffer overflow through an integer
> > overflow.  Consider a tosearch with len 11, and a replacewith with len
>=20
> [???]
>=20
> Good point. Patch attached.

While this looks totally reasonable, it does not compile...  both in
master and release/2.3, both on linux and FreeBSD, I get

libtool: compile:  cc -DHAVE_CONFIG_H -I. -I../../../../openvpn/src/plugins=
/auth-pam -I../../.. -I../../../include -I../../../../openvpn/include -g -O=
2 -MT auth-pam.lo -MD -MP -MF .deps/auth-pam.Tpo -c ../../../../openvpn/src=
/plugins/auth-pam/auth-pam.c  -fPIC -DPIC -o .libs/auth-pam.o
../../../../openvpn/src/plugins/auth-pam/auth-pam.c:141:53: error: use of
      undeclared identifier 'SIZE_MAX'
  bool is_potential_integer_overflow =3D  (templen =3D=3D SIZE_MAX) || (tem=
ple...

... you need to #include <stdint.h> to get that symbol...

Steffan: for the sake of "avoid yet another full loop and a v3", could=20
you just ACK this change as well?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SO+9/CRZBGNspxuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVxkNIqkuBuNlUUl1AQIf1wP/cnU9/5Em+QnpdLMFEY/El15y7su5wC2c
V9nLQ9PRfjTBVkKxAIfkDx7Z7/Oa8r0wgKBW6gY62fSBFGTStCJixdNKUZ1zk+IT
a0fVYgO+fTuM9SYXl8i4iKvmc2S1TS/m0O+7EN4F2skDXLgvnAWGa7Isbppsfl66
3hakevr4Ei4=
=E+0+
-----END PGP SIGNATURE-----

--SO+9/CRZBGNspxuY--

