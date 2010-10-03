Date: Sun, 3 Oct 2010 21:34:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101003193455.GN10703@...1296...>
References: <000001cb632c$a2bb8420$e8328c60$@soto@...1413...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D90rafnCA5jqK2oI"
Content-Disposition: inline
In-Reply-To: <000001cb632c$a2bb8420$e8328c60$@soto@...1413...>
Subject: Re: [Openvpn-devel] Variable common_name can be blank in
	client-connect script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Carlos Soto <carlos.soto@...1413...>
Cc: openvpn-devel@lists.sourceforge.net

--D90rafnCA5jqK2oI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 03, 2010 at 08:56:06PM +0200, Carlos Soto wrote:
> If a server is configured with auth-user-pass-optional and
> username-as-common-name it is possible that the auth-user-pass-verify scr=
ipt
> will validate a connection with no username as it is optional. It that ca=
se
> the common_name becames blank and client-connect script may fail because =
it
> does not have a value for the common name. I think that the common name
> should never be blank so in cases where the username is blank and the
> username-as-common-name option is enabled, the common_name should keep its
> original value.

I'd NAK that.  This would be surprising behaviour - if the admin configures
"username-as-common-name" he doesn't want "sometimes user name, sometimes
common name".

If the user name is blank, it's blank, and if that's copied to common_name,
a blank "common_name" field is the behaviour I would expect to see.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--D90rafnCA5jqK2oI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTKja36kuBuNlUUl1AQJ2YAQAms0tawD5KuU37j9iRcSWQtyE0bgtxRD6
7DGQIBRoODk5VC3JV1sXmXxoA89nMCe2HE7OhFn046vscBPKi1Gt5o3HqdU5DcpE
fGEhTSZhnWIHJ4U2TDQ/ekIos9uSvAynjodkyuOmEvB1SvVncWKJhWPwfnI0TLW+
ZdVFVyDcK0M=
=XTkx
-----END PGP SIGNATURE-----

--D90rafnCA5jqK2oI--

