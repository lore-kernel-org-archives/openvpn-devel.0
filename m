Date: Thu, 15 Dec 2022 13:55:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5sZXUkGpQ/jOsxX@...1296...>
References: <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
 <Y5pEEhAGyKzbNn8u@...1296...>
 <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
 <CAKuzo_imcQLV60uJN9mXTR8ti7gctgR=iZVpi+2AvDvSTJ_x0g@...278...>
 <CAKuzo_jVnAUeKM9=x1vU_DztqPrwYJfHe=YTy5AS8PKF2_Tv1g@...278...>
 <CAGyAFMVkMAUmiNZCbp3xwognY-5d7-ZGEH9v=S17YBogfx2vnA@...278...>
 <4c416e69-07b6-b7e0-25aa-0b3fb3ce5ac4@...2181...>
 <CAKuzo_gSYJdi8oJ3AaFK3gHv2k-YVOYzdW5mLnR89C_ZrtPDvg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/73FgbBDVhiYaV19"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gSYJdi8oJ3AaFK3gHv2k-YVOYzdW5mLnR89C_ZrtPDvg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--/73FgbBDVhiYaV19
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 15, 2022 at 07:49:53AM -0500, Selva Nair wrote:
> Possibly we can merge the current patch
> for openvpn.exe and then improve it later in bug-fix releases of 2.6?

This was my thinking as well - so the patch is in, and provides at
least some statistics, and room for improvements :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/73FgbBDVhiYaV19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmxldAAoJEB2Cnv7KVigSGe0L/0rk0LbVK9VUL5zvsTWPAw4S
ENiBY3tVyGCveD6vOJ/iRR85jiCLRFNTX85JkqYIYoZ0ZJ2gzZANrNID5K21n74e
AqzSl4ESaISBoCAlRKSGBA/qTWAyfjNCzP31Zx6sKr6BVR9vUUSIE+v4vjvCn/HC
lY13OTST8ovXxJcf11U5kw8T7qwZTTpaBxKgfyPNDBOLBGox36Y+fXAz+rbcm99H
daw9zDBMRfR0/OTUbLxFJfIH3+EeJk8oNtBL/A1JSm/37+tN9G047uw/attqxIBg
QR4AB9XjTC55lQ6aCd6E5vsfyBReQoZH5SYiQPIJqHa/o32RW9Ji3soHxLFW6WJL
jWrIRJcO0nUd7dhg8oRd8vRe49+o6uH3Ro6lJM32qyODM19bLW/M3Gwo61FW+lMY
jSXeaveCLhlRtGIaEvCtPfROcRBlA22r8IJHFObQkE0C6gRH7dJ9DF8Enzw1qVD7
8eq2Jzb8kex4CehLXPhFbrCGBfkHHlvHvVmSNHzzwg==
=xgTA
-----END PGP SIGNATURE-----

--/73FgbBDVhiYaV19--

