Date: Thu, 19 Jan 2017 14:45:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170119134542.GI78624@...1296...>
References: <b3afdbf7-ee12-3c1f-b8cd-c30cf3b0a025@...75...>
	<20170118193527.GT78624@...1296...>
	<fe421f51-e376-15e5-274c-fa6a62cc6dfe@...75...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T3QN4r+OPYJYSwpd"
Content-Disposition: inline
In-Reply-To: <fe421f51-e376-15e5-274c-fa6a62cc6dfe@...75...>
Subject: Re: [Openvpn-devel] NOTE: unable to redirect default gateway --
 Cannot read current default gateway from system
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--T3QN4r+OPYJYSwpd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 19, 2017 at 02:42:18PM +0100, Thomas Sch=E4fer wrote:
> > In case "def1" is not enough, please try "redirect-gateway def1 local",
> > which is a hack (but a documented one).  "local" signals "do not install
> > a host route pointing to the default gateway, because the VPN server is
> > in the same locally connected network" (think "university wifi").  So t=
hat
> > should make things succeed.
> This did not work. Same error as before.

This is a bit annoying.  It does not need the default gateway when it's
not going to use it.  *Flag as bug*.

> > If that is still not working, use brute force, and replace "redirect-ga=
teway"
> > with
> >
> >   route 0.0.0.0/1
> >   route 128.0.0.0/1
>=20
> This leads to:
>=20
> Thu Jan 19 14:10:43 2017 RESOLVE: Cannot resolve host address:=20
> 128.0.0.0/1: (Name or service not known)

Uh.  Sorry.  Forgot that this is still netmask-land.

> But
>=20
> route   0.0.0.0 128.0.0.0
> route 128.0.0.0 128.0.0.0
>=20
> works.

This is how the syntax should be.  Thanks for testing, happy to finally
reach a working solution :-) - and I'll put "rework that v4 stuff" on my
limitless TODO list...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--T3QN4r+OPYJYSwpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYgMMGAAoJEB2Cnv7KVigS+eYL/0V4Acp8AylTBpykR+Y1UBJ+
5sg2guvx2vxz8S/HlqCaiwd50fliJT2TSEAtVhliFJLmBAxB+MRpvBnaalN/McyO
TTLUC1evzmeAO7a7tM0IBnmQXNiUDnSF1ljZ/7lyMFiNbAs8ZXCF9xBLKzzzGYRg
/ul+GTFhuxo7mtHUJ+MH7sUBoxce4ZK2J2ZMdDvqJtSQfoirUO6vgBtSf4dIL2TK
+52gldcyKMc3YV4o9iw0O9QelbbT5rb/aZ3t5Uge0xNmCYF+5HPznns9gEjeBt9E
TXeu3JoEkWJKAN5Dholbp2RcUapXyTbqwKvIqKx1paSlYVxvJ5IlyZbMpzjs6DWt
QbK00BmjreByfFcX2aoZw00KW5QKtkQH1AQvGFaqMvp6nthiKxmCfIqKmF/Fy9Pp
HPh4la5+y8U6W3bt41Mb4UyjDLdAqzEhEbHUkJpNsCIXPU9hewA9VkE6rEeZ7PAL
y0N5k3d3WYmSJuD57K3GKcOtExUGO1pIOFP9Hb0FyA==
=UkAo
-----END PGP SIGNATURE-----

--T3QN4r+OPYJYSwpd--

