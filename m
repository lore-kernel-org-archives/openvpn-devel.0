Date: Thu, 28 Nov 2019 20:43:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191128194320.GM40538@...1296...>
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UjTPyfxZRWWsQMwo"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Steffan Karger <steffan.karger@...2507...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UjTPyfxZRWWsQMwo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Thu, Nov 28, 2019 at 11:56:34AM -0500, Selva Nair wrote:
> I think the correct fix here is to remove -Werror from travis build.
> I have tried and failed to lobby for this earlier, but one more try
> can't hurt, I suppose :)

Can we restrict -Werror to gcc builds, for the time being?

If not, I agree with you, and it needs to go...

Valid (and unambiguous) C statements shouldn't cause warnings, and we
shouldn't add patches just because an old version of a certain compiler
is silly.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UjTPyfxZRWWsQMwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJd4CNYAAoJEB2Cnv7KVigSgI4MAJp0LgFkGmHcnX0N4DkIpC1g
fg2rhobUKXL7d5653LG5yZSMPxWzxCB32Keol0UKu3qfr2BZ81thTGbVZZt54dQV
sdVM0wtLoaMIotn+Vr4crvAEXj8KUbkp7QudHSIWkacGBkz5m8uROLloTHqOXCeo
rkkTd37GA+aUf9xsUzwAj/Bkqxn/e3T9+TMYaNkBcKz21bKnM4QBBM1cF7+xyKA6
uGNTBgsGNW1rB5cJBI+HJLG5OsaYPVel6WtutW44vdeFF8a+lulYGTbn5jDgSmi9
dvWwm/9Nj87dcR8vPLagpffn13PXQCrST+73yeCyHTiTipELXSdPGYB3bVp/JFem
YxqBZMBn0zrKxjvzxhZNK7dhtgwgEw+ag07rlJggQrAIeh1/ZXDm79NOUUzNGTt7
xG/fab3aV387ir4ID9K1dbJ+6Og8LLocoIwVcOPrL6PZ2+RiswR22jLo39ZwvRjb
5sGs7/d4052/Cm35UALs6JZ4vcXpnPTrp94NgtHGkw==
=jw37
-----END PGP SIGNATURE-----

--UjTPyfxZRWWsQMwo--

