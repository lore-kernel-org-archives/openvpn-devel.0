Date: Mon, 12 Dec 2022 19:04:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5dtJ17ef45i5WlP@...1296...>
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
 <20221126162648.150678-2-maximilian.fillinger@...2507...>
 <Y5cYjSu0D5P4QMIZ@...1296...>
 <3406b66c-81a3-9db5-1e65-7038ba81da14@...1227...>
 <c90d03a235d24004bf46367a0d341f6e@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="v6m2z+sESm86YqjG"
Content-Disposition: inline
In-Reply-To: <c90d03a235d24004bf46367a0d341f6e@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long
 tls-crypt-v2 metadata
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--v6m2z+sESm86YqjG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 12, 2022 at 05:06:47PM +0000, Maximilian Fillinger wrote:
> Well, now that my solution is acked, we can just go with it.

It got an after-NAK, as there is an off-by-one... so feel free to
send a v2 either way :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--v6m2z+sESm86YqjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjl20nAAoJEB2Cnv7KVigSgMML/07TBu9G4WDlbl2p+Sg4XzYN
fa4Nv2nOF5WwNbc7kEjQzX4jJgEGS7D7y9TcXAKIgUs1GObTV/9GogQkYcih5tgj
6kckDhamVNpBFeFoQ69aewtt6518xNMu3IOoOlFECMtb5CI8sZ5CweFenS4sHOub
UKITdGoooDivcx6jih6IxPjcfXeGClu6oIFcHA8riIwxu8NlBmBc05yeszCYD3t/
NYCUQhxtKy9H+c1nflmJShxxS/awsYLi5LWfzlnNjiKjlvc9gbqfJAGB4C+6MdUR
DDBjKfxp79sl0IN1IWimL5/qVVeDZrCIw2j0i/tqlPsUar+Iw5koLwiPI8Lo0Q5r
XNh3z+77cdxoWPYwAkXC2pUa9bgrUqDVK+qU3NeUYMZtQQraNZqcRyNW0qBMvVGG
T24KfIxXZzQs2fpWAg2e/lqCr+qImxQMYRKnU0eaj4OgVRWAwVZNxPmgcS9RG/Lj
CFz8UUgjV+eOG5ZHCUGfS6xSzNMcNeXPS3HlgY4Hng==
=XkuH
-----END PGP SIGNATURE-----

--v6m2z+sESm86YqjG--

