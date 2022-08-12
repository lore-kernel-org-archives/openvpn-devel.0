Date: Fri, 12 Aug 2022 20:32:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvacqICTVasVJKi3@...1296...>
References: <20220812130657.29899-1-a@...2181...>
 <20220812130657.29899-3-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eGKwTSAn3iFg9rUf"
Content-Disposition: inline
In-Reply-To: <20220812130657.29899-3-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v100 02/10] dco-win: introduce low-level
 code for handling ovpn-dco-win in Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--eGKwTSAn3iFg9rUf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2022 at 03:06:49PM +0200, Antonio Quartulli wrote:
>  	mbuf.c mbuf.h \
>  	memdbg.h \
>  	misc.c misc.h \
> +	ovpn-dco-win.h \

Can we please make this ovpn_dco_win.h, with underscores?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--eGKwTSAn3iFg9rUf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi9pyoAAoJEB2Cnv7KVigSlgEL/1QJpA0DgSf5vnHFc2PYPHZV
utUVP56I0b5ALlinhxkwY8NRFmeBc4Pygy7bZB/Vddy+N6ZWLpfo8Gea03FBKRof
VKvLg7joBSkGZfMiVvuQnMDT+Oq44KK+M52THstQ3PuRO9bqQOHcjyqZtJ4vhB7T
7n0zT9cWElmKqmHlATcKltNu6Rl4dd4ORxaN1oILtjikhgXIMhaMIUSWtqCm9aBr
UmUHCSRDv/TeUe1/vlGHzaiSQx7vBszkdqAtVn/YHfHL9qo0TufRhfP28zwwQPlE
fysourJWinCzsD4mPSHcRytkscYqtLn24pNU572DDHs7S4l5s8s9+Yf5f1v1wenh
NbowySsmK/wN+N45Vbk9xl4fG4Xd8OnD9at7c1G0frbEyDWUk+Gsfrc/aA+cV0aU
J9Znar9xY/4d448/smicRODUEiWT8h7VH39iXlZU018xT+d8jJgF+f4KXO3K6W73
3W4lRmFUJNhJ6j6W+oR2ORAd+vQQgpYsPHWxdIm6pw==
=DFdj
-----END PGP SIGNATURE-----

--eGKwTSAn3iFg9rUf--

