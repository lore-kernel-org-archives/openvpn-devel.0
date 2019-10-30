Date: Wed, 30 Oct 2019 11:31:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191030103148.GO40538@...1296...>
References: <201907221844.x6MIiHtw009666@...2054...>
 <1563892487-12063-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="72pTQ1Q5L511SwPT"
Content-Disposition: inline
In-Reply-To: <1563892487-12063-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 release/2.4] Fix broken
 fragment/mssfix with NCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--72pTQ1Q5L511SwPT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 23, 2019 at 05:34:47PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> This is the 2.4 backport of master patch (commit d22ba6b).
>=20
> NCP negotiation replaces worst cast crypto overhead
> with actual one in data channel frame. That frame
> params are used by mssfix.
>=20
> Fragment frame still contains worst case overhead.
> Because of that TCP packets are fragmented, since
> MSS value exceeds max fragment size.
>=20
> Fix by replacing worst case crypto overhead with
> actual one for fragment frame, as it is done for data
> channel frame.

Thanks for the backport.

Unfortunately, I can not reproduce the problem *without* the patch,
so I wonder if the issue got fixed by something else as side-effect?

If I do what you describe in the ticket:

run

 openvpn --fragment 1300 --mssfix

and grep out the MSS lines, I get (for IPv4, IPv6 numbers are -20 bytes):

with NCP:      MSS: 1460 -> 1203
--ncp-disable: MSS: 1284 -> 1211

... and the very same numbers from master...


OpenVPN versions tested:

OpenVPN 2.4.7 [git:release/2.4/416532f8e4125adb+]=20
OpenVPN 2.5_git [git:master/b5fe104ddbbdf59b+]


So, I'm wondering how to proceed here...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--72pTQ1Q5L511SwPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJduWaTAAoJEB2Cnv7KVigSdRUL/3fnABEiEz26zt8tveNcw68O
+WrKR8192QDsM+NHuZEXAJDoMktSnUhDsBQXDse2adESw56CM1N5XUhkOfPQUedY
ghFAWXs1UwAFGVKuQqW918va5GP1+5zTm/NyZNFWgtEsiQa/EGG8GkVH9BqN6Wtr
wxUCBgg5hTWHUkEFgSwbJxe/nvu36tlTaoxMvHn8S89DbFm33j1rLIAi/R+w3gV3
hvhJi/6yidxOcG7qYTc8nzELlksDS2qg5h+sX24f7eAIY4ffJFmevrvX52egrDNG
Lr/E2wXj9wbnVOORKpC5cweH6ZMKJBUZ0yur2r/ru8bTokACV/JK3pQS383b0F6M
k8kbGeHT+DAktSz1mEmeXwVwf5XByp8Bwtn2StPwErbBr5GX3c8Hxdx53b4uRdKo
x/qkBjfN5r6bTIC/mlgJJFbTnftreTmD2NycpqQNoKjNw35PMl4hSc+K1DQicgyK
SPJVVow9Pg842JSrOsTDjKvBNBG37RWvpzzDJB+5ew==
=TLhd
-----END PGP SIGNATURE-----

--72pTQ1Q5L511SwPT--

