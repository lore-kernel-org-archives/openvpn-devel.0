Date: Wed, 16 Feb 2022 09:15:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YgyyjkHQdh9nxhcz@...1296...>
References: <20220215105407.3936338-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="41cnnLqF/qc1+ZY9"
Content-Disposition: inline
In-Reply-To: <20220215105407.3936338-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix checks of SHA256 in tls-crypt and
 auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, tincntech@...2282...

--41cnnLqF/qc1+ZY9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 15, 2022 at 11:54:07AM +0100, Arne Schwabe wrote:
> These checks were not correctly updated. The check in auth-token
> did nothing at all and the check in tls-crypt was the wrong check
> but that was hidden by the condition being inverted as well.

For the sake of the archives: Antonio's patch v2 fixes the same
thing, including the honorable mentioning of Richard's find.

So, setting this one to "Not Applicable" in patchwork.

(And both patches ignore the "--tls-crypt" warning in auth_token_kt() :-) )

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--41cnnLqF/qc1+ZY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiDLKOAAoJEB2Cnv7KVigS45oMAITmbgUt2H1w/EXPbDsGbCUY
OMX9GlVl6YLsyNZGdu7Yl6r/exN68q3W/oyFFZUbZiDKx3Km9ONSWX+sLmuCVX92
nYZL3kUW4miHyRPYg66d+tHAJdGpFjijQefJXTREX/gVjKhF6H7zmwWluFXFZBZb
xdff2MPjFq1FSo2fS6X+xHZPqL2PHSHJE5mDxUiYeAKT62bwk3KGhLRBvDzgYDSq
Mnt5UyY2U2UbUP/PBVheka31lXsJbaoUke441bYPOpCzIBjTOIflYbKYvNdp2XdT
C91X0LC8d2J9nD9eGzqt6IC52XleQGIwL7krxxjL005TX25RnK1DBDYvW8FHb8et
qiqYdiQ9cmbNe+0kViPyr93jrA89xx6rv4t5GFNpZQKgTYQ0BLMSn4RYxAyYZSvS
FLgDTF/Z49SUgaEPaiXqhWCqRHf6+AX3AorPhz24Vc5fwFEPaPgyTeWhpCfXiPM0
oMhnsR1GjouIjGObP22oyY5n8shsAJhS5JJuIe5XzA==
=G2B5
-----END PGP SIGNATURE-----

--41cnnLqF/qc1+ZY9--

