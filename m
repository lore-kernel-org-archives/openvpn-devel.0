Date: Mon, 23 Feb 2015 16:47:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150223154722.GM8134@...1296...>
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>
	<20150215220144.GP8134@...1296...>
	<20150223080402.GA5068@...2009...> <54EAE4AF.8010009@...1227...>
	<20150223090035.GL8134@...1296...>
	<CAEsd45QKyS8N7Vdg9MQ7EE6g4_h4w7ZC8kNuDsdJ88dpdexNyg@...278...>
	<20150223144011.GA6378@...2009...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UHwWMNIfNKl+QsP"
Content-Disposition: inline
In-Reply-To: <20150223144011.GA6378@...2009...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vasily Kulikov <segoon@...2008...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--1UHwWMNIfNKl+QsP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 23, 2015 at 05:40:11PM +0300, Vasily Kulikov wrote:
> > I agree -- the argument to --needs-external-cert should be optional.
>=20
> Note: Arne said about 'macos-keychain' prefix in the argument being
> optional, not the argument itself being optional.  Acually, I don't
> think making the argument optional is a good idea -- its parsing would
> be ambiguous unless it is the last argument in argv.

Oh, *that* is something our config parser does all the time :-)

The question to me is "if we don't want to specify anything particular,
because there is only one cert anyway, how would we do it?" - or is the
assumption that we better should specify it always?

[..]
> > I'm not sure exactly how to add an argument to RSA_SIGN and
> > NEEDS-CERTIFICATE without breaking existing management interface
> > software but assume that is possible. (Also, the argument may need to
> > be escaped when it is passed to RSA_SIGN or NEEDS-CERTIFICATE if it
> > contains characters that are used as delimiters.)
>=20
> IMNSHO don't change rsa-sign at all and have no API breakage.

That sounds like a reasonable approach to me.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1UHwWMNIfNKl+QsP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVOtLiakuBuNlUUl1AQIIwgP8D6zQc9B8te7Diw8qfGMxvDOi+A9YC/KW
1LF1041YBpUsJh0Y69y2mkHLxPZ3SiyI9OphyUVll0wyxwUgDvOc6Fs+VboC0mL4
1zrcnC9v/TemgcAL/2AiIY6dhRoyfiOLPayFXgYWLU0Tu8yEeP2ap8DcYl336U/C
wb/4R1Wf73k=
=u6BL
-----END PGP SIGNATURE-----

--1UHwWMNIfNKl+QsP--

