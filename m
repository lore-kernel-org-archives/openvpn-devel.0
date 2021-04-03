Date: Sat, 3 Apr 2021 18:53:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210403165313.GY976@...1296...>
References: <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
 <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
 <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
 <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
 <20210403095640.GW976@...1296...>
 <5f61a142d6c8fc91223af9b89cf2772b.squirrel@...2556...>
 <768c58ba-e87b-4e96-0403-61fece8297d0@...2181...>
 <704cc498609f9451a1af5010669452b4.squirrel@...2556...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8turLCVm3e8QpkLN"
Content-Disposition: inline
In-Reply-To: <704cc498609f9451a1af5010669452b4.squirrel@...2556...>
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--8turLCVm3e8QpkLN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 03, 2021 at 03:07:11PM +0200, Simon Matter wrote:
> Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-compress bytes,833300152
> Apr  3 15:00:30 gw-X1 openvpn[1477]: post-compress bytes,796650159
> Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-decompress bytes,343572096
> Apr  3 15:00:30 gw-X1 openvpn[1477]: post-decompress bytes,510118472

This is indeed fairly significant - and if WAN circuits are full and/or
cost money per Gbyte, compression is still a win.

I'm more of a compression fan than not :-) - so this will be interesting
discussions indeed.

(Still, having "compress migrate" is a useful feature so if a VPN admin
decides "I want to disable this for my road warrior VPN users", he can,
without user complaints about "I HAVE THIS OCC WARNING IN THE LOG NOW!" -
more of a commercial support issue than anything else)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8turLCVm3e8QpkLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgaJ14AAoJEB2Cnv7KVigS3vsL/1u1XAD5kdxd6y89VJ0IlHWf
l3eYj6lcz9ugxd+XdCeaeFZTg/DWywwCiN9wOULa4ZQiHQI/MeO6Buw0nw11ROj2
MB7myz1NEBYxmTsyNUCR5wknA03UhpFWjB+KXC73dFzvP7uqNGz86JLm8kGL6YwO
40sws6r1U3Y91VLaWYxulpg7quByfwUO+f8UUM+nnXH2C8OZbMksBeYY57r8GF6S
36hdDz2doC+F3GHWjEyCMVqZBFEEE7YdQOWqtV/JLYnWmowTr7ORNTLFZlONPFg5
HFd9Hue5wYUKqxgu3cEuiDIirrexvvhwep1ADCmb3BIylm39u9k9zLeqTUQjKLmt
IE27h2O4aE5j5ly2eVFcCPTn+/F82M06YSSJSiOdDns09E7BIBv2QO1ozCl/g+yB
oAF430Ezve085Kzn1lb01otORd8JkxDeH8iSOUA6R5r7IitwA9h5WJ1A6hi10twn
i9eg4fKTmjrNWUH6ApouKtXMNB3iH9jmkVYefw9DFQ==
=pvRK
-----END PGP SIGNATURE-----

--8turLCVm3e8QpkLN--

