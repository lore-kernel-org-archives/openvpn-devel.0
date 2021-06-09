Date: Wed, 9 Jun 2021 08:26:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210609062656.GM976@...1296...>
References: <20210608152434.1403999-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sfFJ+71mmvzZlhKl"
Content-Disposition: inline
In-Reply-To: <20210608152434.1403999-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add github actions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--sfFJ+71mmvzZlhKl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 08, 2021 at 05:24:34PM +0200, Arne Schwabe wrote:
> +    steps:
> +      - name: Install dependencies
> +        run: sudo apt update && sudo apt install -y mingw-w64 libtool au=
tomake autoconf man2html unzip
> +      - name: Checkout ovpn-dco-win
> +        uses: actions/checkout@...2620...
> +        with:
> +          repository: OpenVPN/ovpn-dco-win
> +          path: ovpn-dco-win

I'm not totally happy with introducing a DCO dependency here while none
of the related code is in the tree... but since this is transient and
should not cause any issues (unless that repo disappears :-) ) it's
okayish.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sfFJ+71mmvzZlhKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgwF8dAAoJEB2Cnv7KVigS1UYL/3hOWGitlusGmo0zG8vmiuUE
8eAHGAG7kgw1/mMsJICMoWP/Wq1c8m28od/mPWXk4wUSPPp0xLSkV4HaoR6Pj6RL
vUW9Ro1fKMIOXSTy80eNBpfBuElWeeHaWF6z8W8i208gfDpbQby2hmEm8XAo5Was
JzwQmVc6X1/3uz9z1T+eDvEpjBGirTyIjfTVlfrYuHz9pQ8tRVInLQE5E80OGMhW
RkqPZC95u2bjtfrGBoXxY6v1QjGYz6W9Ia7/AFF+IyU1GlB94RZrjeWzY1hhsH+1
Kc5ttfXvIyYn6svliESPDtL1Ml5l764kfoWEQvLCY2pC6bOJw+tsv2Z9zF8ZCJWT
+saF2VPYJlMgziigH4tsv16w7FKD4Fq/QxSf/qTQJNtUcF7ElubIqf9oKctydPhH
73cAEgmCE/QTqeCZlLLMLccEx5q5OzezDdiLsaywkFNpSGqJh39jnqGmdmSenWqj
CXT3NWVqPC028HpIynstxBVvIPMcFHpQ0ZPjviUzKQ==
=+qGm
-----END PGP SIGNATURE-----

--sfFJ+71mmvzZlhKl--

