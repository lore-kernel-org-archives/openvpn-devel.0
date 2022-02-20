Date: Sun, 20 Feb 2022 15:10:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YhJLvgQ8wOTgEbzz@...1296...>
References: <20220107145359.311-1-lstipakov@...277...>
 <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
 <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
 <CAFHpkQE-LBkt-Lyz97vLdgQFt7VPLmedw8ogNojVy2p3GsdaiQ@...278...>
 <CAGyAFMWQLs2=BoF6fhUcG6gLN5LvPA9xHZ8JRocdH5-DL5LW_w@...278...>
 <CAFHpkQHURwN2x=AC_RK38tjwD8kGgHhSbq==espXJHSM33L6ZA@...278...>
 <CAGyAFMWN-4rLAjPEwUbDqE79gs3bUWWSFLSnzz9QaTgiQSKQHA@...278...>
 <YhJKbnyZYeuTk0Fd@...1296...>
 <CAFHpkQFBr0-0j89q77pHFkc26LrcBGfA+T1qvHsW24hCK6vKtg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3nSohPIqEl8gMVJT"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFBr0-0j89q77pHFkc26LrcBGfA+T1qvHsW24hCK6vKtg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2.5] msvc: adjust build options to
 harden binaries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3nSohPIqEl8gMVJT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 20, 2022 at 07:07:15PM +0500, ???????? ?????????????? wrote:
> pdb patch

Whatever that is... a commit ID in master would be much easier for
me to cherrypick.

(In any case, *this* patch can't go into 2.5 before the *master* patch
has an ACK - for patches for "master + 2.5", master always comes first,
then release branch)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3nSohPIqEl8gMVJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiEku+AAoJEB2Cnv7KVigS2XEMAIxKF3Mw6ChBRyN0rt00rIMk
HqBDOyRQDRSVAYJAz/sGQXjqAZzMk5FNXhztu56MoOkIm2+p4SLAapa0EuNuTODR
iRxuU8wrlCjUApbFrWjxyrUJX7pPyR8ERq6KjNC3JxtT7BX/P4QGLUVHUnRca/N1
y31FN1nM57lsLyyBa0nDibThvyP8TzN+xJIE7NHvVsv9MOgJHm3vVsJJQVq3Hz53
08xnDjtjVA2UMNEmk0mhCOrG2I44Etl9U7LAnmSKowhzs1U6iS9igkPyayYmPjt9
PRiEadnw9jSqae5X8nSlBglg/8WggMWJSu1olIt1PK+m4woA5rlEVZJ13m27vO3E
my/ul2c1s5puEplcwO1AKwa3T7d3zMVr4+C53pjTI5O66cX0klJhVjPMMAdyLvLi
yyEUup0LLHKdc9q83GY8zGgAHunRoKz6bl1dS4UNfRl0GFj6+iSKw9oipbohzCfq
JiZzY+FXfRQFRGM/UZdXew9Fm+8ffCg4jIfTMjhzLA==
=+ZVB
-----END PGP SIGNATURE-----

--3nSohPIqEl8gMVJT--

