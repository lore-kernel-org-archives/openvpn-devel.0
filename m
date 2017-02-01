Date: Wed, 1 Feb 2017 11:04:55 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170201030455.GN12187@...2182...>
References: <20170131182241.10590-1-a@...2181...>
	<CAKuzo_h69pmh=+jG=xPdprDSPLxR0Z9QhBnD_eM5bh1PUYsKYw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <CAKuzo_h69pmh=+jG=xPdprDSPLxR0Z9QhBnD_eM5bh1PUYsKYw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] reload HTTP proxy credentials when
 moving to the next connection profile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f5QefDQHtn8hx44O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Selva,

thank you very much for your feedback!

On Tue, Jan 31, 2017 at 03:02:33PM -0500, Selva Nair wrote:
> Hi,
>=20
> On Tue, Jan 31, 2017 at 1:22 PM, Antonio Quartulli <a@...2181...> wrote:
>=20
> > iff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> > index b0ed3279..27f34bed 100644
> > --- a/src/openvpn/proxy.c
> > +++ b/src/openvpn/proxy.c
> > @@ -256,7 +256,16 @@ username_password_as_base64(const struct
> > http_proxy_info *p,
> >  static void
> >  get_user_pass_http(struct http_proxy_info *p, const bool force)
> >  {
> > -    if (!static_proxy_user_pass.defined || force)
> > +    /*
> > +     * in case of forced (re)load, make sure the static storage is set=
 as
> > +     * undefined, otherwise get_user_pass() won't try to load any
> > credential
> > +     */
> > +    if (force)
> > +    {
> > +        static_proxy_user_pass.defined =3D false;
> > +    }
> >
>=20
> While unsetting the define attribute appears to have no unintended side
> effects,  purge_user_pass(&static_proxy_user_pass, true) would be cleaner.
>=20

yeah, I Was thinking about that too, but I was not sure. I will re-check, it
might really be cleaner.

>=20
> > +
> > +    if (!static_proxy_user_pass.defined)
> >      {
> >          unsigned int flags =3D GET_USER_PASS_MANAGEMENT;
> >          if (p->queried_creds)
> >
>=20
> That said, there is one issue with this approach. Looks like SIGUSR1
> restarts will now always prompt for proxy password, which is not proper.

Right! Thanks for pointing this out!

> If
> so, a more nuanced fix that preserves the current behaviour for a single
> proxy credentials is required. May be, do the "purge proxy pass" in init.c
> only if the connection entry has http-proxy specified?
>=20
> I think the intent of the original code/man page is to have proxy password
> work the same way as auth-user-pass with an implicit auth-nocache assumed.
> Then multiple credentials is not expected, but could still work if the
> proxy password is purged when an authentication error happens instead of
> when the remote changes.
>=20

I am thinking that maybe I could just restructure the way the user/pass are
stored. Right now there is one static variable and I am trying to hack arou=
nd it
to make it work with multiple http proxies....but why not just storing one
user/pass object per proxy? (like we currently do with the other proxy data)

That would probably be much cleaner, but will require a more intrusive chan=
ge.


> Finally, socks credentials may also be affected.

I am not sure, because they use a different object/code-path. But I will
re-check that too


Thanks a lot!

Cheers,

--=20
Antonio Quartulli

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYkVBUAAoJEJ6F1zG2JyOsvAUQAL/KK4ijzfO1rHZDFELHz2YF
sDFuT7wIdEZ7BpLV66wrZBKskUtgCw4MeKvZQMAU5aRu5O+msFVxj8BbOYr7afEL
nAavjmicbI5QxfqxVSqCNbtjiS11kJ5doWx/23xfgN+1ZHL0tKSFWHqUXByFkfny
fdtovtrRJJj6biu7vG8xx576rHLfOtjovU/1hmoz0lLGf5CZoRNN+QX7bIEn1YAZ
lGPk+8qxdYfGBw046iGZkgyEFsmYU0j1Hpkg3NEXgDperutanOCc6baIchhUyRBI
cUAKcd0XBUupOk8cGzxUmh8sCaZ9Ut5WvKeCZkW2Mje8isHGwQiIYk5UzcbXxzY6
84MKgz3kMFw1BML3zixSIX1JoomJE8nARWTDvpP/yLE58fluDh5IPNHsmU2RccC1
KR1sVBqoTFDWJDAoxI/AUSI8QOSUpTreIOhyLvqvuRYW0sPaGWocx4qatWKmNiIK
dED0E3eG0vsKl4l/jBOQZKMSf4BmkF1lxkJlD/oQZMGhdgT0GbVFInqP268uqcGe
/DxtVTXXGQL3o2AwopoUQb6DlYetfxHF/Xx9fr+/Lxro0j11i5OcSK1r1kJeKp8E
n49EyOJa5BURxIEDkSegKeDMNn7XP182vkPDRCd3GdKyeTyg/Bc6uBafpxmMWpdz
3K+c8jMEY30TgpzSx3j8
=1UnJ
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--

