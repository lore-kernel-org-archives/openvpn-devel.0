Date: Fri, 24 Jul 2020 20:24:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200724182420.GI1431@...1296...>
References: <20200724112631.195-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xfNO0BElwiDU8PoS"
Content-Disposition: inline
In-Reply-To: <20200724112631.195-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Remove unused no-op function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--xfNO0BElwiDU8PoS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 24, 2020 at 02:26:31PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> Body of check_subnet_conflict() was commented out
> (#if 0) back in 2011, so it is safe now to completely
> elimitate this function, including all calls to it.

I'm a bit sceptical about that one.  Can we make it *work* instead?

It's a good idea, and I've seen support calls with "hey, openvpn is
not working, why?" due to RFC address conflict - so having an indication
in the log might be helpful.

I agree that with "#if 0" this is just dead code.

Any indication in the commit why it was commented out?  Not working
right?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xfNO0BElwiDU8PoS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfGydTAAoJEB2Cnv7KVigShiIL/iaP9oElWamI20IosqcxSLmS
xCjh8xoz5RDMaoOe3w13gBnTjn8LsbAAGV4/sM/G0OdmikFeGVd8BEBVUZP8pAg6
UfzxzifrO37vnvMxhvzZgeYklEOlzBJWVb9c8WUwGSfBm+0bKwiyczc/bWcMBOow
2OiarB46Wgl2jwv1Kne4jwa2K53QPRB/TNtK3P/Nzwqpho1maaZznDfM2qvvoq8m
3krI/C5kHANfKLM5QQr2KwAkwwkML0dauuIQHt0UoYWTaYlSSj7iL7gUF+PNtuUj
p1K0wQH/T3Pum+igw318rPSqYgCQt4cE9K7lKVfXwVhgu7lo0T/LHHtoMmlMPEuW
kQ/S6E50yQmzqfrLg+NiKwpp+f3DwGX8Ve+zaLA3BLZNp53KwRrAqLCxxhWIHX2s
T6uKQ05dGCBtN55hm1Ob3p4bG3GHPhCSepQymuomaoiZAlKpZM1g6ESX6cPx196v
sHnnQz9ilnklFBOZ1RhmdtBr0Op0cjA2EizkKiSH1g==
=gROp
-----END PGP SIGNATURE-----

--xfNO0BElwiDU8PoS--

