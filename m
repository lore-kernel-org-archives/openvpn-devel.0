Date: Thu, 22 Jun 2017 20:05:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170622180512.GI97029@...1296...>
References: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
	<20170621211043.6490-1-steffan@...1856...>
	<20170622133102.GC31123@...2287...>
	<CAKh=nwF7UfzoDaUWM1RNfx8tULmMVyP_wn69ZGORztx6qMYWWQ@...278...>
	<20170622160805.GD31123@...2287...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N9dE88m3/9rHioVI"
Content-Disposition: inline
In-Reply-To: <20170622160805.GD31123@...2287...>
Subject: Re: [Openvpn-devel] [PATCH v2] Move adjust_power_of_2() to integer.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Emmanuel Deloget <logout@...260...>, openvpn-devel@lists.sourceforge.net

--N9dE88m3/9rHioVI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 23, 2017 at 12:08:05AM +0800, Antonio Quartulli wrote:
> yeah...not sure we need to make some code a bit "obscure" if there is=20
> really no need.

It's only obscure if you forget that 2^0+2^1+2^(n-1) =3D (2^n)-1... :-)

(Admittedly, it needed quite a bit of thinking at first glance)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--N9dE88m3/9rHioVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZTAbXAAoJEB2Cnv7KVigSAKIL/26f/rbG+l2TAykRK1K62rm5
Dfm8i6j8Kjs88YNmQnfM0I3oIt09VqlRa5Bu4NefyrY6m+g9cFKyWjHTFBCLaJd9
/JsWp/p45mdlT2bsP7WUXMDnrneAhX/1aQiHv71rNA0EM1baqHMmuME8qnvAwq20
JqtssYxgXXztgHbm81CA/RW68/iC1KUwpoKMNiRp5ZJW+1AsCPdBlE7GvQrN1wYQ
OBb5xguF7QEFYx0Q6lv7A5HAixPk5rmzoMZQtB0Ln5ZCNpj+bS0cHCTCdtteGlEM
Ip4XinZFoykHzxoC6Os+Yq/UhGUJNhwV6C0gStbrreLIXmAukFa6fyp5omMHdYM9
PhvsrPdvTxIkW+7kApUEXcCF+OyrWdXOQfG89edbNEo1Vb5X9pU3c/5QZDse0X6O
6W/X4MvOL6+1i3ZbcbKP4gpyZFv6ev/Ut/zlTfARYVVMewGQvglNRinsuZ8souc+
G9PoUvZdgSxaVrUQL91lxsEwZPUpFuUPdoR+OmyUTA==
=y0eR
-----END PGP SIGNATURE-----

--N9dE88m3/9rHioVI--

