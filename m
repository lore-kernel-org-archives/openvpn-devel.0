Date: Thu, 15 Jun 2017 09:47:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170615074739.GI97029@...1296...>
References: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2DaOLMAxYzwSqmPk"
Content-Disposition: inline
In-Reply-To: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
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
To: Steven Haigh <netwiz@...2277...>
Cc: openvpn-devel@lists.sourceforge.net

--2DaOLMAxYzwSqmPk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 15, 2017 at 12:50:40PM +1000, Steven Haigh wrote:
> I'm just trying to figure out if its expected behaviour to have the=20
> 'username' set in the environment when using the auth-user-pass-verify=20
> script.

The code in question (ssl_verify.c) is older than the involvement of
any of the currently-active developers... but JJK or Ecrist might know.

Anyway, what the code *says* is:

ssl_verify.c, about line 1095:

verify_user_pass_script(...)
{
...
        /* Set environmental variables prior to calling script */
        if (session->opt->auth_user_pass_verify_script_via_file)
        {
... (no setenv here)
        }
        else
        {
            setenv_str(session->opt->es, "username", up->username);
            setenv_str(session->opt->es, "password", up->password);
        }


so, yes, that is what it *does* - "username" is only ever set together
with "password", and that's only setenv'ed if you do not use "via-file".

Now, that is about calling the --verify-auth-user-pass, but I think the
"es" (environment set) being affected here is the global per-connection=20
es (not something local to this function), so that would affect=20
--client-connect as well.

[..]
> The auth-user-pass-verify documentation states:
> If method is set to "via-env", OpenVPN will call script with the=20
> environmental variables username and password set to the=20
> username/password strings provided by the client. Be aware that this=20
> method is insecure on some platforms which make the environment of a=20
> process publicly visible to other unprivileged processes.

This "some platforms" actually something we should eventually verify
and clearly spell-out - because Linux and all recent BSDs do *not* show
the environment to other unprivileged users.

[..]
> No mention of the username env variable when using via-file - but this=20
> gives me the impression that the username should *not* be set in the=20
> environment - but it should be in the file.
>=20
> So - bug or feature?

Username and Password are always handled in tandem when talking about
--auth-user-pass-verify, so "both in environment" or "none of them".

Now, if you use a *plugin* (or the management interface), the code will=20
always set both in the es, and delete the password(!) afterwards, leaving=20
the username intact...


Looking from a given distance, I'd say that this is a bug, and "username"
should propably be always visible in the es (if present), while password
should not.


If you want to experiment: go to ssl_verify.c, and move the line 1123
(master) outside the else {} block:

old:

        else
        {
            setenv_str(session->opt->es, "username", up->username);
            setenv_str(session->opt->es, "password", up->password);
        }

new:

        else
        {
            setenv_str(session->opt->es, "password", up->password);
        }
        setenv_str(session->opt->es, "username", up->username);

... then it should show up in client-connect as well.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2DaOLMAxYzwSqmPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZQjuaAAoJEB2Cnv7KVigSw5wMAIStS89+Zy0Rq1VScQqf9H1Q
8i6A3oVApGgfh12REs6GpkoWBuDZvSHCAwdaJPmqKllpdLkWIKZ5eqF14VQb77Si
YDMGOTVr0d4ZFrE6+/NFTxx9MomCNn4qgO4k2OzC06FwLT33ex5zfVhfJu/Uysey
oWHegnfM0HgW+AIGMjMWFllfQ3j6keXbodrZhtEnF2m3CyWp5a6DIg9LDqhBfC6e
Nz7l0Ac9k15OgYEq58gB0gbBBBkoZXf1yclCWbYYurylgrOuqjNkFLEdBnFiQbH5
r8CnfuEzYpBax9Oh6f48qukOgdem0CRU9uh+g7KVBoKzVPSUKaVwKDln2bIh9t6U
sAtrXROX40l7gJ2XVF3z30eUEYpGO6/WfjpzqaPjlbnDlfKPAM81/J/6/vcYSHUG
yepgaEnxOGWRqR1jqIjEXiLlv5FXVwge3Z2GDclJDzrBreJE4cZAtJHJUaCpltCS
xUyUtgW5oETO2Ul7aBCu4sNsEZG1ZKjqAgTbsqXWVw==
=aM9Q
-----END PGP SIGNATURE-----

--2DaOLMAxYzwSqmPk--

