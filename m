Date: Thu, 10 Dec 2015 09:46:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151210084614.GA24952@...1296...>
References: <1449691435-5928-1-git-send-email-gert@...1296...>
	<CAKuzo_iHtJjJRfubaBbSCn1=sTa9R_WUFR68JLj4p9as71_EDA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VgSl7ZiUY2n5sQix"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iHtJjJRfubaBbSCn1=sTa9R_WUFR68JLj4p9as71_EDA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix isatty() check for good.
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

--VgSl7ZiUY2n5sQix
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 10, 2015 at 02:43:44AM -0500, Selva Nair wrote:
> Thanks for this fix. Systemd-ask-password now works!

Thanks :-)

> On Wed, Dec 9, 2015 at 3:03 PM, Gert Doering <gert@...1296...> wrote:
>=20
> > +  if ( !isatty(0) && !isatty(2) )
> > +    {
> > +      int fd =3D open( "/dev/tty", O_RDWR );
> > +      if ( fd < 0 )
> >
>=20
> This doesn't allow for reading passwords from pipes -- not relevant if
> getpass doesn't fall back to a non-tty stdin if /dev/tty open fails -- do=
es
> it? Not saying pipes should be supported --- whatever is consistent with
> getpass should be fine.

I'm not sure this is a use case we actually have - to trigger this, you'd
need to run openvpn like this

  echo mypass | openvpn 2>/dev/null

(so isatty(2) fails) *and* run it from an RC script or something else that
does not have a controlling tty.

Given that we broke this in 2.3.8 already, and the only complaints we heard
was "systemd is not working anymore" (apologies!), I think that scenario is
somewhat unlikely.


> > +       { msg(M_FATAL, "neither stdin nor stderr are a tty device and y=
ou
> > have neither a controlling tty nor systemd - can't ask for '%s'.  If you
> > used --daemon, you need to use --askpass to make passphrase-protected k=
eys
> > work, and you can not use --auth-nocache.", prompt ); }
> > +      close(fd);
> >
>=20
> The error message is still incomplete/confusing when the triggered by
> auth-user-pass
> without a filename (i.e stdin), and not by a passphrase-protected key. In
> the former case a reference to the need for management-query or a
> username-password
> file is helpful.
>=20
> Other than that, the patch does the right thing, and works well. Tested
> using git- master with and without systemd. ACK from me.

Given these two comments, shall we merge it "as it is", or do you want to=20
suggest different text?  I'm fine with changing the text, but have no=20
good suggestions.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VgSl7ZiUY2n5sQix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmk71akuBuNlUUl1AQJebQP+M2cMn1//oNOaYshxpz0EguPx0l/QDvII
UTyy+QHJzBQ/wQF8nrB22+AADGh/328BARGEBuWYLFKriZNGX5jYE/5HPAw4gqNn
gOQDGx84cE1Wv2uHrsd7NU53ZLASFIK2nJiubsOrh7cr/2ocmAI0PsEAwQwWDJaA
5cS0wZleRp8=
=a622
-----END PGP SIGNATURE-----

--VgSl7ZiUY2n5sQix--

