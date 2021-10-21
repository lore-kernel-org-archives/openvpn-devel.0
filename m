Date: Thu, 21 Oct 2021 08:11:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YXEEe5/EuW6P4Ia2@...1296...>
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-4-arne@...1227...>
 <CAKuzo_jOdVxYE4OOA+cjXCpi0PkgQqt_WHGtZT0X0vdAkJ7MXw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bv1t/m5NNhq0acN/"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jOdVxYE4OOA+cjXCpi0PkgQqt_WHGtZT0X0vdAkJ7MXw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 03/21] [OSSL 3.0] Implement DES ECB
 encrypt via EVP_CIPHER api
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bv1t/m5NNhq0acN/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 21, 2021 at 01:09:14AM -0400, Selva Nair wrote:
> PS: can't we just get rid of the use of DES altogether?

Is there a newer NTLM auth variant that does not use DES?

Otherwise it's "keep NTLM auth =3D> keep DES"...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bv1t/m5NNhq0acN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhcQR7AAoJEB2Cnv7KVigSK6oL+QHjxSDSoVVy+G6mawl8BOme
vDNlh4JDbMPsSvdxhk1y4PAbVEamkzFrCF+9pR7VqtowdzJkMW7R35V6bgBuIUMr
nNqQR2Inw4DMR/XvPKrcJ/e9XJm5ZX39UNiFIBmln6lQ5KfjfxH0wSA/fzGFw+mB
ibx4jDQObHtIF9abSQ7ubeOxlus8zyXO0wzWJuCLehqQ5bOoO31kcivZOf3oQqB0
pSpDH+KE9fw8tRBZv9qlMISemmsrlGPQwGbVxBPKxirxaEYZn1/lRL5EJBYq2lm4
DE28CD7mPnIbfRk94KDGT0OHgpCe6T27A7nMac/p0FqyngpcQWsyi1IYnlKDWFug
PaB6VLIsBYm5DPhXOEciw5ZwXEmhXCoCAWjlh5ezMH1onavaIZzXfRwAfrMdG6n+
c4KjMB/cr4LWzn90/bRZ4POnQf3Nh7pytVCgXKE3GgRRp/8SY9qU3EdrAYigm8wX
4/uyer0E59GmWt/B37yb3GdkOntONlDF43Dim+UxSA==
=ehn2
-----END PGP SIGNATURE-----

--bv1t/m5NNhq0acN/--

