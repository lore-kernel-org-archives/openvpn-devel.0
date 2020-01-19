Date: Sun, 19 Jan 2020 16:51:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200119155108.GG1431@...1296...>
References: <20191004171246.26343-1-davids@...515...>
 <20191004171246.26343-2-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Thv7PGoFpDPJ7Oar"
Content-Disposition: inline
In-Reply-To: <20191004171246.26343-2-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--Thv7PGoFpDPJ7Oar
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 04, 2019 at 07:12:43PM +0200, David Sommerseth wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> The previous implementation had the problem that it was not fully
> compatible with printf() and could only detect % format directives
> following a space character (0x20).

Events have overtaken this one.

Namely, tun.c has been changed in many places due to the windows
refactoring / wintun work by Lev and Simon, so this patch does not
apply "as is" anymore.

The changes to tun.c are trivial ("%s%sc" --> "%s%s"), but according to
custom, I do not do code changes while applying - at least not without
asking :-)

David, shall I just amend the patch, or do you want to resend a v3?

(The other 3 of the set should be fine, as they do not touch tun.c)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Thv7PGoFpDPJ7Oar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeJHrrAAoJEB2Cnv7KVigSPwQMAKxP4OAvH2B974jnf/esc8WX
rZy82dUwvjC5N1kLHLF4hr9Juz+nuvLc/7efCNjS4fC18a+tjG0uISkpnHk+Nqj/
Quv9O95HcGJTR3A0YHiViAdwgCnfqcsMVG2wCpuJPTkHb1fdxUSlduq1atql+bnr
oLLUAPniPist9fjJ4wsaol7K6uOPMpQk6WiLgWuoo5tavnpPhJ0DrRBNyMZUnxwa
GVv4AbYh2RIfbItI7y2QMPv+f9Mx6JXb15UNn02DuOySgG86g0dOPwzF5gKX+6n3
Kubj8WgHqcKvUCAIkzz3FM79z/bOHevEbXL6P5hMqNByran5hdEyvjpEk8DfBOEY
3p6YQsRe9uccDmCpHnOsXUwZ1iljNILnbPhGw4TZDEzS/niPu+1YJhfYhMg5Ydne
Y5XCMX0ssMFXNfkM2T1ddP07Zci3HmYDmodCovAU1PguTe7jEWVck/ygaS2mwD0q
RiJCdA7SrXOEBwzNpwuRvvETL3soC++gthetrG0GcA==
=KyU1
-----END PGP SIGNATURE-----

--Thv7PGoFpDPJ7Oar--

