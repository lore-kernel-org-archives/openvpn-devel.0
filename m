Date: Sat, 2 Feb 2013 16:43:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130202154307.GK953@...1296...>
References: <1359815797-23262-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <1359815797-23262-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix assertion if environment es is null
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--at6+YcpfzWZg/htY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 02, 2013 at 03:36:37PM +0100, Arne Schwabe wrote:
> The construct_name_value eventually call gc_malloc with NULL as gc which =
will trigger an assertion
[..]
> -      char *str =3D construct_name_value (name_tmp, val_tmp, NULL);
> +      char *str =3D construct_name_value (name_tmp, val_tmp, &gc);
>        if (platform_putenv(str))
>        {
>          msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);

NAK!

platform_putenv() calls putenv() on non-windows platforms, and that one
will just add a pointer to the string passed to it to envp[] (at least
that's how I read the manpage: "The string pointed to by string becomes=20
part of the environment, so altering the string changes the environment").

So your environment now points to a garbage buffer, which is then=20
destroyed again.

I think there needs to be a strdup() here...

(And I seem to remember that "some of the buffer functions" did exactly
this when &gc was NULL, but maybe we threw this out last year... David?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUQ00C6kuBuNlUUl1AQKsdgP/fCE/4TX0NOcd+AZmVjWYpzbEKhaf5oHN
+HOXfx3AcwAdp/urmsBSODEoW0MyX/Dn3HPM3nmcy3f/WG3myu5FPSeQvX/FXn17
bkii/5RdEHB8vlxCWyyxuTuIVfo/10R1IfhI25Ikb7enNA5F7MP1F0sQEAUAM8sO
V8BNwQVwqaM=
=Fogr
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

