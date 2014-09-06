Date: Sat, 6 Sep 2014 14:09:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140906120905.GB1118@...1296...>
References: <1409930731-15263-1-git-send-email-davids@...1347...>
	<1409930731-15263-4-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ucKxrLtqiGlSKUCp"
Content-Disposition: inline
In-Reply-To: <1409930731-15263-4-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Clean up the pipe closing in
	openvpn_popen()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davids@...1347...
Cc: openvpn-devel@lists.sourceforge.net, fcrozat@...1519...

--ucKxrLtqiGlSKUCp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 05, 2014 at 05:25:30PM +0200, davids@...1347... wrote:
> @@ -365,27 +365,30 @@ openvpn_popen (const struct argv *a,  const struct =
env_set *es)
>  		      pid =3D fork ();
>  		      if (pid =3D=3D (pid_t)0) /* child side */
>  			{
> -			  close (pipe_stdout[0]);
> +			  close (pipe_stdout[0]);  /* Close read end */
>  			  dup2 (pipe_stdout[1],1);
>  			  execve (cmd, argv, envp);
> +			  close (pipe_stdout[1]);
>  			  exit (127);

NAK, as that addition does not have any benefit.  Even if the execve()
fails, the next thing is an exit(), which will close all file descriptors
anyway.  It's just extra code that impairs reading.

The rest of the change would get an feature- and code-ACK, though :)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ucKxrLtqiGlSKUCp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAr5YakuBuNlUUl1AQJ2ngP/SVp0hpeS4fLf79Gym/QgOa1/tQQ7rsLq
n37u/8B1+/DOD726NXEOsrUcF1FQG+XhiqvRps5yqkZJ+O4n2/KsFtlO5D8M/rmF
5kTlwlTq79iZBdC9MjbJGkrJoWX6ek85x5ISyW8HodzVmVvY3gjkfOYJYDGFSwe4
k5zcgRt+tw0=
=DvCs
-----END PGP SIGNATURE-----

--ucKxrLtqiGlSKUCp--

