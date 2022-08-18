Date: Thu, 18 Aug 2022 11:36:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv4IDgJe82jc/B1b@...1296...>
References: <20220813204224.22576-2-a@...2181...>
 <20220818092638.189632-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hqlnm4/6TqpoRn/T"
Content-Disposition: inline
In-Reply-To: <20220818092638.189632-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v102i 2/7] dco-win: check for
 incompatible options
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

--hqlnm4/6TqpoRn/T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 18, 2022 at 11:26:38AM +0200, Antonio Quartulli wrote:
> -#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
> -    o->tuntap_options.disable_dco =3D !dco_check_option_conflict(D_DCO, =
o)
> -                                    || !dco_check_startup_option_conflic=
t(D_DCO, o);
> -#endif
> +    o->tuntap_options.disable_dco =3D !dco_check_option_conflict(DCO_CHE=
CK_OPTION_LEVEL, o)
> +                                    || !dco_check_startup_option_conflic=
t(DCO_CHECK_OPTION_LEVEL, o);

Nah, this is not good.

This reads as "this is code which will always return, and will log with
some arbitrary log level" (how would a reader know that D_DCO and=20
DCO_CHECK_OPTION_LEVEL is not both coming from errror.h?).

Make it explicit, and explain why.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hqlnm4/6TqpoRn/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/ggOAAoJEB2Cnv7KVigStcUL/0zj+2XcTQtMzoyUOJ3cGT3C
v/yC9pBjrlsa9yKQWFbIh9wYLczuGuhNScb9za1KS7zTv3r1P/TOk0EIO+ZeK2BZ
ak5mHeY2Pw/qmx2YFZNvQhbSpumvnZBx/BkMLfZeFhEVnkXS+ck8zObDBrTI97Fp
6RW+xyMGnBSxlLJS7x30IfMxEALYliw2CwrmaiGadTaTaQtonlx205mRO2Dq32K1
fJOjtSAL7XtxvF0eMtJ6H0zYyPA2zSiUYzSU0CS2gXX+AJcz3JLg7Wgs9g2uS3yF
Y+PYM3Kq+ppdm+mLClIuyfO+NCJ179UDTVtY0h39GicBbOdeIY/MinxtkmX8WMu0
aEdFf51Lccw9WTG0OCNQZvQcss9VWxezVyMzYn1Mh31bTEqygPo2yMGbXpH/C5jl
JY/lr+uG/5u5Xq/pPTUjYoaQNGXGjfOoBXNsHokeaO4nZBcv7Ds+dYo+ZrngYGrR
ZUG1MqExIALxAL3gAVXYKMW0A8gIkx1Mb9omGO8P4Q==
=/FBb
-----END PGP SIGNATURE-----

--hqlnm4/6TqpoRn/T--

