Date: Mon, 12 Oct 2020 13:27:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201012112708.GA31798@...1296...>
References: <20201002175736.82609-1-gert@...1296...>
 <202010041602.094G2wrI048509@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <202010041602.094G2wrI048509@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix redirecting of IPv4
 default gateway if connecting over IPv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 04, 2020 at 06:02:58PM +0200, Gert Doering wrote:
> Patch has been applied to the master and release/2.5 branch.
>=20
> commit 23e11e591347080efa3b933beca7f620dd059d5c (master)
> commit 7b4f53095c761bde8c6b39cf645cade4c1c0c5d4 (release/2.5)
> Author: Gert Doering
> Date:   Fri Oct 2 19:57:36 2020 +0200
>=20
>      Fix redirecting of IPv4 default gateway if connecting over IPv6.

Turns out that 2.4 is also affected by the problem (because the=20
offending commit was applied to 2.4, because "bugfix").

Thus:

commit 4f6461b3dd79a4288580aeea0ba89e94e0251b06 (release/2.4)
Author: Gert Doering <gert@...1296...>
Date:   Fri Oct 2 19:57:36 2020 +0200

    Fix redirecting of IPv4 default gateway if connecting over IPv6.



sorry for not checking this right away.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfhD2LAAoJEB2Cnv7KVigSLzUMAJyWEe7I2m0UQuEWw2AYsvlf
2W4xOwCzoNaMdW2VIcUGHv+gULhr/9stTWS0hvvJnQyjC5izzSsXBqquQbSaSX9A
diGsC3tPsGhPnr4HdCKMdiyyv1Y9dRy1EwZtstVBvotk6Ey8n1GU6v3mXRh3svBd
COJbfO9KSB6ol/fKXm03cSm/Qx6FwCNqjeBdAss5JxvI3eWNnDD9y4x8NpNWl6F/
waSK5tjRKILLAU7YjzE5GahL0TJGFhUQXluZgrozK51j9EM2jJVcvnqYyrIcgZKz
sV/gm1SCVfxua2g5cojCAIH2uA5fWUCtAFxv3XGHVw/utdexZkuZCtaEbhkQibbC
UOAubysTzZfLRnnx2adMd5eSMqjPvGwttCa2H1VosfdoEe2d0wGv6IKHyPFKqJC3
iy+ViMWrkqUkrRKU9bAS023xQTDWCXUlGiCjNrORZ5F8N1AbYafB6OebF+VGYs4p
/U//oBsl99ZeBq2lKd65Xiehw0LR9eRECuHgK42Tuw==
=lRzE
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

