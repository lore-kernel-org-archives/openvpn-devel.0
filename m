Date: Sat, 8 Feb 2020 09:45:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200208084558.GV1431@...1296...>
References: <20200207174818.21050-1-juliusz@...2525...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ijywFOGgtBfiIjQx"
Content-Disposition: inline
In-Reply-To: <20200207174818.21050-1-juliusz@...2525...>
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN master
 branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

--ijywFOGgtBfiIjQx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Juliusz,

please send patches out of a git tree, coming from a git commit with
"git commit -s", and having a somewhat relevant commit message.

Besides this, please do not

> --- a/sample/sample-config-files/loopback-client
> +++ b/sample/sample-config-files/loopback-client
> @@ -25,3 +25,4 @@ tls-auth sample-keys/ta.key 1
>  cipher AES-256-GCM
>  ping 1
>  inactive 120 10000000
> +cipher AES-256-CBC

... modify the sample config files (and *if* you do, do not just add
a second cipher line, which will confuse users quite a bit).

If WolfSSL does not support GCM, this needs to be documented, but our
sample config files contain the recommended cipher for the existing
crypto systems, and this is (and will continue to be for the time)=20
GCM - faster, and lower overhead.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ijywFOGgtBfiIjQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJePnVFAAoJEB2Cnv7KVigSu/AMAJWWSes3ipGtHdAtOYiABfzj
NZgRNFY5wJ3Dx1SvpAGXYr0xDjQmfEeHar8G245eyPi8L71546Vs/roribHtWZvj
2JevLI4lBjCe/SRxuVUDbVBGQHHH5EBvDpcm/sO9qYKxd7hUU/cJtSOExyExnvAL
rADwjrklTuGNWBn8DqB920ciE6R+8ls958e5NcKlAR0+YggchzCqPibW7vo9rukV
z3QHP+SUEu2n2wDCN51hK72snI3nmYXUi/IDic7c0gX+BV9KOHUboetzcwOT3vx9
bo0Tc8Yp5/+Yi+GGT8JpsrVMauD42YPJFEEBZT7kSXkuBeuE6gMsNo7Nbvw1BptK
09vUVRQSjHHV/pHu0eoB1yYOLMN2CWZxC9yER4IjLNAQHg1mV5C1SWAxWGrlFLyg
5bxFx7RaRPrE4XYaEahhnff/ksRS5oI14Meki/S/ZbpAqF0tbSakHXg4GYkcVcHG
L+x7/1NdB0dNPjC2U8GaO4Dd5zAxcnE7waeJvFrzkQ==
=Le4a
-----END PGP SIGNATURE-----

--ijywFOGgtBfiIjQx--

