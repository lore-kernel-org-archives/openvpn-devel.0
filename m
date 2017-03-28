Date: Tue, 28 Mar 2017 08:04:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170328060459.GM93896@...1296...>
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JJKOhZVZ8d05tF05"
Content-Disposition: inline
In-Reply-To: <5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--JJKOhZVZ8d05tF05
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 27, 2017 at 11:40:49PM +0200, David Sommerseth wrote:
> > On Sat, Mar 25, 2017 at 05:21:18PM +0500, Ilya Shipitsin wrote:
> >> [src/openvpn/options.c:1163]: (warning) %x in format string (no. 1) re=
quires 'unsigned int *' but the argument type is 'signed int *'.
> >=20
> > Please use "uint8_t" then, and also adapt the "ret[i] =3D (uint8_t)byte"
> > line - the cast would then be obsolete.
>=20
> I would normally agree to use uint8_t ... but the man page for sscanf()
> on Linux says:
>=20
>    "Matches an unsigned hexadecimal integer; the next pointer must be a
>     pointer to unsigned int."
>=20
> And stdint.h declares: typedef unsigned char           uint8_t;
>=20
> AFAIR, char is defined as 8 bits (hence uint*8*), while unsigned int are
> 32 bits on my system.

Yeah, you're right.  I confused this discussion with our standard
"char vs. signed char vs. unsigned char" warning.

(See how dangerous "fixing compiler warnings" is?  :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JJKOhZVZ8d05tF05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY2f0KAAoJEB2Cnv7KVigSM6ML+wbxJDNCpPdchiexTDadIV48
GynpPq3aW5D3A6gbGQci9hXvKe8pAn09kE9RCLcavTHXU0LFCB/XgNjLRiNY8jZ3
Op81yccMSDN/w8rn/q4Quebv+dLE/CSV/ostoGHmnQLeI4NEAR3l3R0N/sf7xMwz
buC7C16y+ztDa53iy0VTm2m5Bj1CRmM4gCXiV0P9LVaFhiwsHxrrPZW72bE43DnU
3sW1+9Uf53xUdC+yBapQSaw/ZW2MS7l5YR5WPWdy9iu4q1J6l9k/qs9aS8SocK0M
sIthFQ6QfDkGa5aTlNboKMO60hsDfFV3IS/f7dc98BMtjbY3mI0vVVgNx7IXvMSy
Dv+2mgUYN0qIAe1fG61G1a4wmGHNVNs4ZhpHPOKWDH6DtiErmOChMa3/FCGQzR5j
RuYW5vSxTQl6ejJEEe1ld/rT8MU0TMs42UGLQIdziQ8NUSCDWFUIRpYe9rteSut9
sHPxqxp3km8chZVdIfE3ZV667vqUgI6DC7RPOcYl9A==
=qHNI
-----END PGP SIGNATURE-----

--JJKOhZVZ8d05tF05--

