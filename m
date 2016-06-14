Date: Tue, 14 Jun 2016 09:13:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160614071342.GR62247@...1296...>
References: <1465871689-13533-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H2kTGx6mr3R59oXC"
Content-Disposition: inline
In-Reply-To: <1465871689-13533-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Promptly close the netcmd_semaphore
 handle after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--H2kTGx6mr3R59oXC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 13, 2016 at 10:34:49PM -0400, Selva Nair wrote:
> @@ -759,6 +762,8 @@ void
>  netcmd_semaphore_release (void)
>  {
>    semaphore_release (&netcmd_semaphore);
> +  /* netcmd_semaphore has max count of 1 - safe to close after release */
> +  semaphore_close (&netcmd_semaphore);
>  }

This should work, but it is more "aggressive" than I had in mind - releasing
the semaphore afer every single call, so when setting up lots of routes with
netsh.exe, we might end up opening and closing the semaphore "dozens" of
times.

How expensive / slow is this?  Has this significant impact?

My idea was to close the semaphore when the initialization phase is over,
like in init.c, initialization_sequence_completed(), in the existing
WIN32 block

#ifdef WIN32
  netcmd_semaphore_close();			/* release handles */
  fork_register_dns_action (c->c1.tuntap);
#endif

or something like that.  Keeping your change to the "lock" call so it
is then reopened at tunnel teardown, but is not open while openvpn is
running in steady state.

But I'm open to "semaphores are cheap, we can just open/lock/release/close
it on every call" arguments :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H2kTGx6mr3R59oXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1+upqkuBuNlUUl1AQKC3QP/d3BUHzvBYIixBKv8Sj5t+57CFtMsbs8f
CcRul5pCbFnarZjjM3VZsvJw5sYIgWEn+UAqsBWEjgVL1nYbTSxe5hpPlp43Hmzx
/fJAf0uBJ1/isewZIH8d8lamkDNvcGfc3cMGi3/q53UgwdBO/m2pCFI3Dyusa835
n1PTecFGWDQ=
=vQZ4
-----END PGP SIGNATURE-----

--H2kTGx6mr3R59oXC--

