Date: Wed, 10 Oct 2018 09:14:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181010071451.GP962@...1296...>
References: <CABMULt+srvCfNqio3FTmh0MLahFDh0mjWCpPyxoJQnWw0Ee+6w@...278...>
 <20181009152342.GG962@...1296...>
 <CABMULtKW13+tS-o9bfaFw6ecO=CVMq9Q12oznH5iBQ6d=k8dRQ@...278...>
 <20181009184349.GJ962@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yOJWIPlLSoQhvV9Y"
Content-Disposition: inline
In-Reply-To: <20181009184349.GJ962@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN cipher issue?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alex K <rightkicktech@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

--yOJWIPlLSoQhvV9Y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

to copy the reply from Steffan over to openvpn-users...

On Tue, Oct 09, 2018 at 08:43:49PM +0200, Gert Doering wrote:
> (copying in openvpn-devel, as this is something Steffan will want to
> see...)
[..]
> Possibly this is when the first packet is sent by the client or when
> the first packet comes in for decryption - "man EVP_CipherUpdate" says
> that this is for encryption or decryption.

Steffan Karger:
> This very much sounds like an old OpenSSL bug for which we added a
> workaround in this commit:
> https://github.com/OpenVPN/openvpn/commit/13de0103e
>=20
> This typically occurred with the OpenSSL version shipped with Ubuntu
> 12.04, which had a buggy AEAD interface.
>=20
> Either upgrading your OpenSSL or your OpenVPN to a recent version should
> be sufficient to make it work.

-> so, upgrade to OpenVPN 2.4.6, or see if there is an Ubuntu upgrade
to OpenSSL.  Or upgrade to Ubuntu 14.04 or 16.04...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yOJWIPlLSoQhvV9Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbvabqAAoJEB2Cnv7KVigS6rsL/Ax9psJdNXIH4wGUToeAfk1z
nb4MS6ec6lkIsG66yFrsTIxUXSFS+jNBRc0BWywgqncNz4K3+URHxfP4Fm4jE4Vw
5yYie8UfQq620p87O84Ac+SD1T8RUIsE6ihru3lstx/46iumb4JSOXZD/3vkaT6k
yXtkUjV6lUH70Ekw3+VJgaBBmuz3xEtzGznIlZwXae76ROgMAE8gVFL8vN5Xixni
G4GS0x1/6uQh7iVrQ8COYYEGAiKghuqM4D5xN7v+znYgQW6lE9/vWVSRutmAy+QK
c56hv6GvXNi0ExvdMv2+QKb5SOX8gifT3w570vMZSL1kf41dWiwbrdSaVh770fTK
fsJXh6XlWCwQDKvbYG4hLtOsVFunhHkieN2lbH3O4e8K/EsZLWq/khvL2sdYQi0n
pClKP2MEUYnVyUlA4kXm2L34xJuYcqD2qstP+sthEwGYmLcCU/dJf90MLlR73T1X
9cp4Bj3fPfZR4mov3nOY3fy4hpxSjLVbmdL+ai8IKQ==
=bI1G
-----END PGP SIGNATURE-----

--yOJWIPlLSoQhvV9Y--

