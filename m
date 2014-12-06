Date: Sat, 6 Dec 2014 14:57:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141206135719.GM17158@...1296...>
References: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ONmcTkPhtkbQYSLg"
Content-Disposition: inline
In-Reply-To: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] down-root plugin: Replaced system()
	calls with execve()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--ONmcTkPhtkbQYSLg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 16, 2014 at 03:31:02PM +0100, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> The system() call is prone to shell expansions and provides far more
> environments variables to the executable run than what is usually
> preferred.  By moving over to exevce() shell expansions are far more
> difficult to achieve and only the OpenVPN provided environment
> variables are available.

Since Steffan has ACKed it, I've committed it, but it would be nice if
you could send a followup patch addressing the remaining warnings in=20
down-root that Steffan pointed out - and maybe reformat these bits to
conform to whatever coding style we agreed to (which this is not :-))...

> +static int
> +run_script(char * const *argv, char * const *envp) {
> +  pid_t pid;
> +  int ret =3D 0;
> +
> +  pid =3D fork();
> +  if (pid =3D=3D (pid_t)0) { /* child side */
> +    execve(argv[0], argv, envp);
> +    fprintf(stderr, "DOWN-ROOT: Failed execute: %s\n", argv[0]);
> +    exit(127);  /* If execve() fails to run, exit child with exit code 1=
27 */
> +  } else if (pid < (pid_t)0 ) {
> +    fprintf(stderr, "DOWN-ROOT: Failed to fork child to run %s\n", argv[=
0]);
> +    return -1;

I think this is called "all-mashed-together" style or so :-)

thanks,=20

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ONmcTkPhtkbQYSLg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVIMLP6kuBuNlUUl1AQJ0MgP/fO6GnDl4oHjXn0ZTWrhuyRSHKIACZOYr
IQyimIxz99v7ziFqCXlyRKy6NcwTStpnBAJ7mts6Jt9oQN5lXe2rxllWupm8neTh
Sb0q7971nGqYYVr1iuf9cooptguDOUKnbuH+euheUdbRR2V770ybb9Uh3XsF0ZkD
bjgLsG09hK0=
=Fv2q
-----END PGP SIGNATURE-----

--ONmcTkPhtkbQYSLg--

