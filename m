Date: Mon, 22 Nov 2021 22:37:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZwNiBRC+V/E9OeI@...1296...>
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="l8KlC5rkfD31xJVX"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l8KlC5rkfD31xJVX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 22, 2021 at 04:33:36PM -0500, Selva Nair wrote:
> I think setting env vars would give us extra protection as we can detect
> the actual location of Program Files or executable's path at run time.

Indeed.

(Also, the PR isn't exactly proceeding smoothly... no idea why the
vcpkg maintainer does not want to see why Lev's PR is an improvement
of the situation)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--l8KlC5rkfD31xJVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhnA2IAAoJEB2Cnv7KVigSFeML/j4LnJw1aQcItRWOf+BmlEwX
wEAO7DIfHou0pHEbmVcf3D7rIj7RTw+Yt8A+8QPdr/qq4/A75zWx6EsL+JAIezQS
Zg+JDT6sU5w3/PEtBOc1J2Zhu11t6b21+5CdwFqmttVcQ+Oj1Ots7IYcjXbUX7Mw
M66vRTajr/ElAqlVqQSO23G6e3W1oavzsya51KLgmGQrp9x1ZiN9OgfeUY03ulwx
ukFmxsfDXqUT1qxdhACmIQxGo+Y7jPMWb1BPMwcGScFnA7lMaBI0SING3LtiO/tG
JMDQdbzQ2KYTzMP2s8TwJB0kzXBpqSCD2SpoiAbEhj0rUgWyw0U7OKOSefTUSkWy
533eY8Ghw4m/Wp0dlGhKAn8wY9ZFjikSYuotx7a/hZciaswkWH0d+2rkbSEB2GPH
VS+iU18Eu/OVfcXqvUcFlwoEzMCNVXF1GCg6YM+qNHdrpl47S4vPu4eLyfCoryaf
r2f321GuYCX4HLZqbU+uAuf0n2uRfnkD3ZIvr2mvvw==
=F+Eb
-----END PGP SIGNATURE-----

--l8KlC5rkfD31xJVX--

