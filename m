Date: Mon, 1 Feb 2021 09:10:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210201081027.GI976@...1296...>
References: <20171205121952.13008-1-EngyCZ@...277...>
 <CAKuzo_g6YTkx+-3i=TEFn9b2yPjx9rBweTz=4H7uuOT8VokEdg@...278...>
 <CAHODtZSTyD8NOc8cVNaGaZ9z+HZrKK-+L6h_t0gqhAh3pJMk+w@...278...>
 <CAHODtZQRb48Aa8AsxXoSnUUSLE27u-EjCOWavFJj7nwZqPYd7w@...278...>
 <CAKuzo_g8KXGKN-A-egEonQEFpkro5wb5OigDbycg0j_Ae=5Tow@...278...>
 <CAHODtZThxjAUb-sZ4bA1Y238hPeK=zKGcSbU9d3nib+8rt0YMg@...278...>
 <CAKuzo_gb4Sdqa3WLb=34kdwqvz507mKeyVyfhKvY6RassZz7Mg@...278...>
 <47ebda81-a785-2512-e0f7-2b9179eade2e@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IvSzk2WfuLekX6bP"
Content-Disposition: inline
In-Reply-To: <47ebda81-a785-2512-e0f7-2b9179eade2e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add a warning for disabled DHCP media
 sense on Window
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--IvSzk2WfuLekX6bP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 13, 2020 at 03:53:04PM +0100, Arne Schwabe wrote:
> This on of the old patches that are still pending. It seems that the
> original submitter never replied. This is still something we want to
> merge or should we just "close" due to timeout? I am not too familiar
> with the DHCP problem to have a good opinion on that.

I am now going to close it.

This seems to be a fairly rare problem, and if "--dhcp-renew" fixes it
without extra code, this sounds like an acceptable solution.

If Jiri wants this to be merged, the process would be "re-send a v2,
rebased on current master, with the changes Selva suggested integrated".

(We do not do pull requests, so I have not looked, and will not look,
whether PR 97 has/had an updated patch already)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IvSzk2WfuLekX6bP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgF7dPAAoJEB2Cnv7KVigSCTsL/Ax1k/9X2Vlh9ZdqOayS5njS
yvLE7IhiSQKN26FmCV4mR6ZKhJ24EGmjjRgNco+2HY0iW5xHvNFx/ix1rvj6AWj0
p2gUFz3kEE0I7zgC++3EWGRIMaW2T9mZmmmS1bCtx27ow6Q758RIqCJ3qElkeNO6
QTjTgp+DMzGxqKPGtohpifP9tiVwLQUxRaeVL5g7YfwfyvciycCwnmsM7bP2lkTh
womwEzMP1mrl5/hxoBIyYpVpzv1Dbgk/D7vyNazPUr9oDnJ01TpDiHBFnqhne5ij
BYG/TsYulgfq9S4IIG9mV2c0drQIH689mE1hVR9mgiIUszH4aQNMLQs3IZQJkHc7
O12p/sXxO5+B+g9dBjtKOUVVyHuTzOcmz0AKYOWlDDi2nIxOr8XF2+CR5l8ThiHf
jjV2ZzFVFKIEfqpMmMea/xWFgT/QOvh+aFn3pilw+Y01fm0ORi/wbH/uKQ+VeGYF
0HtihI4JUj+82A2zXiebisqiguGCCqsp+OjBgDnNWQ==
=CAEv
-----END PGP SIGNATURE-----

--IvSzk2WfuLekX6bP--

