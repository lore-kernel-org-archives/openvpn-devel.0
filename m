Date: Wed, 30 Nov 2016 10:15:19 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161130101519.0cdce781@...1799...>
In-Reply-To: <a856d529-7825-4a03-1cfc-19fb0e58735e@...1435...>
References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
	<a856d529-7825-4a03-1cfc-19fb0e58735e@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/.JeSM8KSID/GgwtFGXqPKUI";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running
 from systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/.JeSM8KSID/GgwtFGXqPKUI
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Steffan Karger <steffan.karger@...1435...> on Wed, 2016/11/30 10:06:
> Hi,
>=20
> On 30-11-16 09:59, Christian Hesse wrote:
> > --- a/src/openvpn/init.c
> > +++ b/src/openvpn/init.c
> > @@ -926,6 +926,13 @@ bool
> >  possibly_become_daemon (const struct options *options)
> >  {
> >    bool ret =3D false;
> > +
> > +#ifdef ENABLE_SYSTEMD
> > +  /* return without forking if we are running from systemd */
> > +  if (sd_notify(0, "READY=3D0") > 0)
> > +    return ret;
> > +#endif
> > +
> >    if (options->daemon)
> >      {
> >        ASSERT (!options->inetd);=20=20
>=20
> Does this mean I cannot run openvpn --config bla.conf --daemon from the
> command line any more on a systemd system?  This would be a deal-breaker
> for me.

No. That means openvpn knows when it is run from within a system service.
Daemonization is refused there as we we start with "Type=3Dnotify".

sd_notify() is a no-op when run from command line. So everything works as
usual.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/.JeSM8KSID/GgwtFGXqPKUI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlg+mKcACgkQiUUh18yA
9HbyUgf/UMbPe18zKandpssIjZ1aKjf+p0vsJaZ0cD+mq3IOAJ6a8QG5u1WUaLqQ
jzXzRg3PiLLKUOKMOY0V6PaFlMzGxcTGwAJBkCHtaPC8lqj0uVVzdq7RNnh623PO
eNAB5f5km0YqAmpBLVQt8tN1z/2OPowlGb6G+FcEdCggo9+yKsbDpeWFWQa/UwzN
6L8pPFmbQNPhp7PO4XdYI0Wa4hnALSgJj0U+/a+/Y42mnVxdnQs344jZbb/X5xxQ
cz3BOMYhxbAJ6np0o19WgitbJz/QdUrOXpMFFTqM4wmylX5DpjVvEH2S4OTGJC11
aWwow66YWZr7UcGy4fog4/LHwfbgaw==
=PAj5
-----END PGP SIGNATURE-----

--Sig_/.JeSM8KSID/GgwtFGXqPKUI--

