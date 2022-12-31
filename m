Date: Sat, 31 Dec 2022 17:40:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7BmEYJj+935Ow5v@...1296...>
References: <OpenVPN/openvpn-gui/issues/9@...1714...>
 <OpenVPN/openvpn-gui/issues/9/403117394@...1714...>
 <CAKuzo_jDCHm=VLc2wuKYJaf48Duy_4dHnbvHx4StVV6PjDausw@...278...>
 <CAEsd45Q87G=UTjt-PE29a41MFQU90_NJxmmux9=ZS=S7j=9E9A@...278...>
 <CAKuzo_iNcK+B2Tg0a7LS+251JSnfHXd++Gy243+gtWOZx7VC=g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/zv+D4LiKFr+Ak3y"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iNcK+B2Tg0a7LS+251JSnfHXd++Gy243+gtWOZx7VC=g@...278...>
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] UI showing green
 connected status despite not beeing able to create a route (#9)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "Jonathan K. Bullard" <jkbullard@...277...>, Gert Doering <gert@...1296...>

--/zv+D4LiKFr+Ak3y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 17, 2022 at 07:09:34PM -0500, Selva Nair wrote:
> tldr: Can we get CONNECTED,ERROR instead of CONNECTED,SUCCESS on route
> errors?

I think this makes sense.  Not sure how complicated it is, and if we
can make this before 2.6.0 ("some time in January").

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/zv+D4LiKFr+Ak3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjsGYRAAoJEB2Cnv7KVigSxH4L/1GQD8iIFruaF6E3En9ozSZx
wrSgrZBnWhjiKQLXzpgi/ozACk/l+B7brwH8r9swmHQKTd1RyE8QhjMjTeTToeUr
pWM+1LarmYyjU78SBcQSAfEeKtIfEWcmkLUEQQxxkflRtrs4azqipb5Lt56a0bmV
mcdZs8inlxSd/qumFY6XLurRQ1s0pEtxw4Ro7J9UikLirxdichaA9H1i7yUcu7Xi
aBEEpILTtZuLW/AVwK0pwf5GE9v9CJLr+iUMJbmtb7/2axzHRszhK3Jd5eewZyx3
/64FlFu95PNsqDsYXRz3hRmQIc2s6MpyXTN57wCs3pWWFdw6ORg+QdTHqZjbFTKn
rcnjodVdd18PAUTBdtQFXGiZ/3mneQa5zxtSSxN0NDnIwwP4oKCO+ZECebo2hiHO
fwh7uWKWXHMA3aBJk7mddxOhE0L0uA2d00Q2wOjXtdHu32g39fnIv4xlwOmM1MDM
tgP2z5Ux6iZgqOkVUEfC5FMyAP0/g1pc75F9EwPdOQ==
=KTRC
-----END PGP SIGNATURE-----

--/zv+D4LiKFr+Ak3y--

