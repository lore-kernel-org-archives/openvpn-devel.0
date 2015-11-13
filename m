Date: Fri, 13 Nov 2015 16:27:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151113152758.GS24952@...1296...>
References: <1447382487-26031-1-git-send-email-selva.nair@...277...>
	<20151113073802.GK24952@...1296...>
	<CAKuzo_iCjV9sa=7=+2cz7JLxYNQ6-K6QYFgv67u31=aV-fQrmQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W18qbkTAGYos9/y6"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iCjV9sa=7=+2cz7JLxYNQ6-K6QYFgv67u31=aV-fQrmQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not hard-code windows systemroot in
 env_block
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

--W18qbkTAGYos9/y6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 13, 2015 at 10:21:12AM -0500, Selva Nair wrote:
> > OTOH, I'm not sure if this is going to work - win_sys_path is (unless
> > set from options.c) initialized via
> >
> >   GetEnvironmentVariable (SYS_PATH_ENV_VAR_NAME, buf, sizeof(buf)
> >   set_win_sys_path (buf, es);
> >
> > ... and that is likely to contain more than "c:\windows", but "a number
> > of path elements"...  so it's not really "sysroot".
>=20
> SYS_PATH_ENV_VAR_NAME is "SystemRoot" so that will set win_sys_path to
> %SystemRoot% (aka "C:\\windows" for most people).

AAAH!  I assumed it is just "PATH".  Yes, this should work perfectly
fine then.  (Obviously I did not test this, sorry)

> > What am I missing?
>=20
> However, if the user specifies --win-sys some_cruft, win_sys_path will
> get set to that "some_cruft" (in options.c). User is the king.

Yes.  In this case, I do not worry at all - "you get what you ask for".

> Having said that --the man-page description of win-sys is confusing
> and its value is set as win_sys_path without any sanity checks. If
> win_sys_path is not a single base directory name, many other things
> will break; for example in route.c we construct the command line for
> route.exe as
>=20
> argv_printf (&argv, "%s%sc ADD %s MASK %s %s",
>          get_win_sys_path(),
>          WIN_ROUTE_PATH_SUFFIX, <---- defined as "\\system32\route.exe"
>                  network,
>                  netmask,
>                  gateway);

Yeah.  "Put garbage in, get interesting problems out".

I should have looked at this example myself - it makes fairly clear that
I was looking at the wrong environment variable.

Thanks again.  ACK, and merging ASAP.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--W18qbkTAGYos9/y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkYBfakuBuNlUUl1AQIrFQP+K9JpxwbJPE6sNU8UToox51F4GV5a3Ll3
e7MQvwTIRPpdWICbvFMdIHcPVUouz5pfJn3kab6Jf1QTzNcbySgVoBe4DS3XA65P
+TrOFobxh2NHqDpk4qwaHMA25H5sgmUl4kx6UnINAWlI4h63NmvA+/31MtCCSgU8
uGxUQNLotF0=
=aiA5
-----END PGP SIGNATURE-----

--W18qbkTAGYos9/y6--

