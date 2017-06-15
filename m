From: Steven Haigh <netwiz@...2277...>
Date: Fri, 16 Jun 2017 02:11:48 +1000
Message-ID: <1649446.B7buzjzcZ2@...2279...>
In-Reply-To: <20170615074739.GI97029@...1296...>
References: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
	<20170615074739.GI97029@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5851761.iXEvlbOE7a";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] Bug or Feature? Username in environment in
 auth-user-pass-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart5851761.iXEvlbOE7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, 15 June 2017 5:47:39 PM AEST Gert Doering wrote:
> Hi,
>=20
> On Thu, Jun 15, 2017 at 12:50:40PM +1000, Steven Haigh wrote:
> > I'm just trying to figure out if its expected behaviour to have the
> > 'username' set in the environment when using the auth-user-pass-verify
> > script.
>=20
> The code in question (ssl_verify.c) is older than the involvement of
> any of the currently-active developers... but JJK or Ecrist might know.
>=20
> Anyway, what the code *says* is:
>=20
> ssl_verify.c, about line 1095:
>=20
> verify_user_pass_script(...)
> {
> ...
>         /* Set environmental variables prior to calling script */
>         if (session->opt->auth_user_pass_verify_script_via_file)
>         {
> ... (no setenv here)
>         }
>         else
>         {
>             setenv_str(session->opt->es, "username", up->username);
>             setenv_str(session->opt->es, "password", up->password);
>         }
>=20
>=20
> so, yes, that is what it *does* - "username" is only ever set together
> with "password", and that's only setenv'ed if you do not use "via-file".
>=20
> Now, that is about calling the --verify-auth-user-pass, but I think the
> "es" (environment set) being affected here is the global per-connection
> es (not something local to this function), so that would affect
> --client-connect as well.
>=20
> [..]
>=20
> > The auth-user-pass-verify documentation states:
> > If method is set to "via-env", OpenVPN will call script with the
> > environmental variables username and password set to the
> > username/password strings provided by the client. Be aware that this
> > method is insecure on some platforms which make the environment of a
> > process publicly visible to other unprivileged processes.
>=20
> This "some platforms" actually something we should eventually verify
> and clearly spell-out - because Linux and all recent BSDs do *not* show
> the environment to other unprivileged users.
>=20
> [..]
>=20
> > No mention of the username env variable when using via-file - but this
> > gives me the impression that the username should *not* be set in the
> > environment - but it should be in the file.
> >=20
> > So - bug or feature?
>=20
> Username and Password are always handled in tandem when talking about
> --auth-user-pass-verify, so "both in environment" or "none of them".
>=20
> Now, if you use a *plugin* (or the management interface), the code will
> always set both in the es, and delete the password(!) afterwards, leaving
> the username intact...
>=20
>=20
> Looking from a given distance, I'd say that this is a bug, and "username"
> should propably be always visible in the es (if present), while password
> should not.
>=20
>=20
> If you want to experiment: go to ssl_verify.c, and move the line 1123
> (master) outside the else {} block:
>=20
> old:
>=20
>         else
>         {
>             setenv_str(session->opt->es, "username", up->username);
>             setenv_str(session->opt->es, "password", up->password);
>         }
>=20
> new:
>=20
>         else
>         {
>             setenv_str(session->opt->es, "password", up->password);
>         }
>         setenv_str(session->opt->es, "username", up->username);
>=20
> ... then it should show up in client-connect as well.

I managed to track this down today.

It seems the pam plugin sets the environment variable. As such, as soon as =
I=20
add the following line to the server config, the username variable appears=
=20
back in the environment for auth-user-pass-verify:
	plugin /usr/lib64/openvpn/plugins/openvpn-plugin-auth-pam.so openvpn

After commenting this line out and restarting the daemon, the username env=
=20
variable is gone.

That still poses the question, is a plugin supposed to be able to alter the=
=20
environment presented to the auth-user-pass-verify script?

If so, should these changes also be in the client-connect script?

If not, the environment might need a reset before the auth-user-pass-verify=
=20
script is called?

--=20
Steven Haigh

=F0=9F=93=A7 netwiz@...2277...	=F0=9F=92=BB http://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090	=F0=9F=93=B1 0412 935 897=

--nextPart5851761.iXEvlbOE7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAllCscUACgkQQa811Xp9
Mdy5gw//Re4TDGjM5vXRCqgiVOTQXe418IWpsbIHYp49PgxFw67xawTTTDtOUa1+
Pn0mhXlARpd9uSKlazI2aU2nq7p82LnKFsOIzjRKPXavOiTebr/vigjf08F5s6At
OYZTPQmKJV4Nj5z9Iz2YTRM4XuRQ8aerQHGhi6YoGSg097o0M+sFLnKI105zTedp
X/Tt8qVawxJIq0cii/kDbY+74KLIv0KnXi3AzBTN/8vQtrm24lJcv1pDzpTn2azF
6M+LQuyCf+jHI8kUMzc/6E+h2WSOXXTfzIi3lFoY/tx/5Gw31nLHm8HA4hWjudO0
ewax5Du3cHBqRzC1aKl/1ozhaDL8avcZEN1e84psbrRW0k56+HWgzDKoytlUjZFz
RO1b0xTuv+XLZSiIRWdVXdSM089YQdVKwmrP1Ln/VY7x6OkVRdEa9ZW8w+jzC0T+
btznq6AhnxzHkEUpX6QWY26vYpDk2oBQ80QeNOwcWnxB25LA9UNeRRt+kUG291+u
UEFlz3SfRIGfXO89kgzjwnCJdQCFLKvv93Kvj+0aqmNpA6H32GqlQxgjYjHlcyq3
hZ4/M/7yL2WXjXXweCQEaR6emyxarEBP1mNl4KjjNXp2lzptAlkcMccQ6zAvEuYd
Lt4anJR89757DarlGsm3NNjtM93mP5U6DRDH4gJcw/Tflk7EUKs=
=zZ9+
-----END PGP SIGNATURE-----

--nextPart5851761.iXEvlbOE7a--


