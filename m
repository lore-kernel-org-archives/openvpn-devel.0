From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 10 Dec 2010 08:38:45 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EF3@...1436...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C5F@...1436...>
	<20101210062512.17827.qmail@...1287...>
In-Reply-To: <20101210062512.17827.qmail@...1287...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview [7/8]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Peter Stuge <peter@...1287...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks, I'll change the configure options when I rebase the patches to 2.2 =
. I'm a little more familiar with cmake, thanks for pointing that out.=20

About the whitespace: it's a tad difficult to split the patches now. Are yo=
u sure it wouldn't be acceptable this way?

Adriaan

> -----Original Message-----
> From: Peter Stuge [mailto:peter@...1287...]
> Sent: vrijdag 10 december 2010 7:25
> To: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview
> [7/8]
>=20
> Adriaan de Jong wrote:
> Content-Description: 07_polarssl_addition.patch.gz
> > Add PolarSSL support to OpenVPN
>=20
> > +++ b/configure.ac	Wed Dec 08 12:35:42 2010 +0100
> > @@ -273,14 +273,16 @@
> >  )
> >
> >  AC_ARG_WITH([ssl-type],
> > -   [  --with-ssl-type=3DTYPE  Build with the given SSL library, TYPE =
=3D
> openssl ],
> > +   [  --with-ssl-type=3DTYPE  Build with the given SSL library, TYPE =
=3D
> openssl or polarssl ],
> >     [case "${withval}" in
> >          openssl) SSL_LIB=3Dopenssl ;;
> > +        polarssl) SSL_LIB=3Dpolarssl ;;
> >          *) AC_MSG_ERROR([bad value ${withval} for --with-ssl-type])
> ;;
> >     esac],
> >     [SSL_LIB=3D"openssl"]
> >  )
> >  AM_CONDITIONAL([USE_OPENSSL], [test x$SSL_LIB =3D xopenssl])
> > +AM_CONDITIONAL([USE_POLARSSL], [test x$SSL_LIB =3D xpolarssl])
>=20
> Again, I think --with-polarssl may be more common.
>=20
>=20
> //Peter
>=20
> -----------------------------------------------------------------------
> -------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

