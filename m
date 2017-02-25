Date: Sat, 25 Feb 2017 22:36:32 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170225143632.GZ12961@...2182...>
References: <20170225020229.17287-1-davids@...515...>
	<CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
	<40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
	<CAFHpkQEOCkqj0yHAH0gqJgmjpfSL-0ZgGLBPoeFnwoViY-sKow@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KqBSqvdnnccM6+Kg"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEOCkqj0yHAH0gqJgmjpfSL-0ZgGLBPoeFnwoViY-sKow@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
 functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--KqBSqvdnnccM6+Kg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, Feb 25, 2017 at 06:45:36PM +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
> 2017-02-25 16:49 GMT+05:00 David Sommerseth <
> openvpn@...2080...>:
>=20
> > On 25/02/17 10:42, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > > there are two another unused functions in misc.c
> > >
> > > [src/openvpn/misc.c:661]: (style) The function 'env_set_print' is nev=
er
> > > used.
> >
> > This one is useful for debugging purposes, so I let this one stay.  I
> > did consider an #if 0 around it, to make it more explicit.  But I
> > thought we have enough of those.  It could make some compiler warnings
> > go away though disabling it.
> >
>=20
>=20
> it is good idea to put "#if 0" around debug items (that are not used
> generally)

Not sure if there is something similar in the code right now, but wouldn't =
be
better to have this kind of code surrounded by some "#ifdef DEBUG" that can=
 be
enabled upon configuration ?

Cheers,


--=20
Antonio Quartulli

--KqBSqvdnnccM6+Kg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYsZZsAAoJEJ6F1zG2JyOso2kP/RNjirEVC1wEw5P6nHeZ2f95
kp68pzVUulb92++q3tRvqXWga/IRNP9mdjHZLfXGhTU7KLKWliqRWI1yFLF1HGAR
ReQf5uH0bZEydv4LEqCeRmjgeCIRQmbuEXb957OT9sMySIqCRy9sJKaCN+ZZzMyl
VEsGcL0uYX3Sr3STzo/v8IIxcFwhiUiP/WulBmlgCrpILRJGEEKAdKdcHwNxLE64
xgvv16fh9496jyYNYnD5Hedh1qCAR3rukKDRuqi0VQ/FlvlDKqGke3YTtO0N9qZC
BBTI4WxzdNgbS2PrWoSpayjx6bszU/4k7merlNWeHclCV2i7Ydq7ldLvyYv2fJHV
v/yMbp7nbA+R36DQ21bDEF0mSzu8zBD2j8RQfhBHPyMJEIQQh0Z6ucpuTclTSE9k
acidAd+Ad0OJIB6C03azJggL8/mSUo1VwsFCwkMeBt6dlyhtKSI8uuCYzs8UuxFb
XRLIWqxcczXiAZ03GzpoLjDeWXgKin4BDkxxhwJ+8RIsbCmdA1rdrmB6Of2GbLJy
PRxEf3yYXFeKiME4XP/iwD1+NHEqENeCfr0opoKBWR/os5im4WE4r8dKeiGj/0Mq
/sjFEtXHxw8KILz1LAYMEE4c6x83wAEutxJKmFfO8Q6XVq0XnoDLPlZTQESxkUPR
lZytCT3u4Hcs0ui7Fcft
=0M93
-----END PGP SIGNATURE-----

--KqBSqvdnnccM6+Kg--

