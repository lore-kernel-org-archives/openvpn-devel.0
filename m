Date: Fri, 22 Jul 2022 23:38:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtsY4AowFaIEgRqZ@...1296...>
References: <CAGyAFMWSHhzpTzEe+TJXD6jasv+w+vGCYygH6uXjEm1k4L0qxQ@...278...>
 <20220503002840.295-1-lstipakov@...277...>
 <YtrND9EAUEoe4Lvv@...1296...>
 <CAKuzo_gcZH=+igQ4dYpT4Gn1TRUJc6yYqOCA8H=EDCE0BRu4UA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wxZuPdJHdRU/wy/G"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gcZH=+igQ4dYpT4Gn1TRUJc6yYqOCA8H=EDCE0BRu4UA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix M_ERRNO behavior on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--wxZuPdJHdRU/wy/G
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 22, 2022 at 04:34:40PM -0400, Selva Nair wrote:
> This one is tricky -- though the patch appeared to be a no-op for
> non-Windows, in error.c:x_check_status(), it did move down  the line
> my_errno =3D openvpn_errno() and thus potentially lose the original error=
. At
> that time it looked like a good move (pun intended), though. So much for
> C99 style..

;-)

Thanks for your analysis and patch.  I'll stare at it a bit tomorrow
and test (and then send the patch I had been working on, to get rid
of the setsockopt() error message on IPv4-only sockets...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wxZuPdJHdRU/wy/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi2xjgAAoJEB2Cnv7KVigSnJgL/0Qe++fS+A30j8diwkdz6StE
N4fhI9Y9eZnKLPH4+bWkPtYgzSudFB7GPeyLBw/fkvQM89maC84/C/Gg68kyklDw
PT2I/i3BrOXbCnDOdmxvPD8lvzleEzwByx7iWcQuVkqBa8Z1InvJ8Q1nlYly+ui1
R/BcnuKRAWOnczpC+KEZSa300Wl+KTrZ9xy8QUZp/C/pklMVgSF+AEoTq7Y6KHqI
wVRX3tCBQWuqiNlc98Q86AwaqpzGHUMQfFwAVNHEPTo/R3hxeTbeMZCmZujqsGm/
5/K4rXnlgyG5RsjDrbp2jKB2MtAo9g5102ZkPDKtZWx0AGRvU4jiMbOk8d6U2aAL
44jTuTUXdcdJ1nDc9ah/LZ21WZeiXPuk5qqY946Igpxh2vV93/yMqQoBrB0GcFxF
5RU3XY12iCwwKbQlrQbnThRVcgX7QjxTxebYb8y0n+fKvZVAaK3ytZD5uxi2W2rD
+0tzRQpCZoMRpoBcC0no981kNEN8IlJvBGpETDclkw==
=MXIG
-----END PGP SIGNATURE-----

--wxZuPdJHdRU/wy/G--

