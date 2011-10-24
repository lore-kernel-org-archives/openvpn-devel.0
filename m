From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 24 Oct 2011 10:58:04 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B90127CB75804@...1436...>
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
	<1319445962-21686-3-git-send-email-dejong@...1435...>
	<4EA52800.4080205@...1147...>
In-Reply-To: <4EA52800.4080205@...1147...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
 PolarSSL to AES-128, as BF is not supported
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
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Unfortunately BF isn't supported in PolarSSL though.=20

Do you have any other suggestions? I'm open to most ideas other than "imple=
ment blowfish" :)

Adriaan

> -----Original Message-----
> From: Jan Just Keijser [mailto:janjust@...1147...]
> Sent: maandag 24 oktober 2011 10:55
> To: Adriaan de Jong
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
> PolarSSL to AES-128, as BF is not supported
>=20
> I'd NACK this patch : the default behaviour of OpenVPN should be
> independent of the SSL implementation.
>=20
> JJK
>=20
> Adriaan de Jong wrote:
> > Signed-off-by: Adriaan de Jong <dejong@...1435...>
> > ---
> >  options.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/options.c b/options.c
> > index 39e7a57..d917072 100644
> > --- a/options.c
> > +++ b/options.c
> > @@ -810,7 +810,12 @@ init_options (struct options *o, const bool
> init_gc)
> >    o->server_poll_timeout =3D 0;
> >  #endif
> >  #ifdef USE_CRYPTO
> > +#ifdef USE_OPENSSL
> >    o->ciphername =3D "BF-CBC";
> > +#endif
> > +#ifdef USE_POLARSSL
> > +  o->ciphername =3D "AES-128-CBC";
> > +#endif
> >    o->ciphername_defined =3D true;
> >    o->authname =3D "SHA1";
> >    o->authname_defined =3D true;
> >


