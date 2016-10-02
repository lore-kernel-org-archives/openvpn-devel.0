Date: Sun, 2 Oct 2016 19:48:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161002174852.GU78279@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
	<CAKuzo_jqgMNCqcbCHBLO7hHoa9aLDTj3Ed7UmJ446b2J++8BCw@...278...>
	<20160918065956.GY78279@...1296...>
	<CAKuzo_gNnXg+XZh+UCzyvHjN+_L5a6N+dQkO_dQxOdvoYQsKcg@...278...>
	<20160918201556.GA78279@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ShJiFmZFPUEMHaH+"
Content-Disposition: inline
In-Reply-To: <20160918201556.GA78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
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

--ShJiFmZFPUEMHaH+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 18, 2016 at 10:15:56PM +0200, Gert Doering wrote:
> On Sun, Sep 18, 2016 at 10:20:16AM -0400, Selva Nair wrote:
> > Yeah, to me that only confirms my feeling that #ifdef WIN32 is not
> > reliable. Much better to use _WIN32 which appears to be defined by all =
(?)
> > C compilers that support windows and doesn't require any particular hea=
der
> > to be included.
> > http://nadeausoftware.com/articles/2012/01/c_c_tip_how_
> > use_compiler_predefined_macros_detect_operating_system#
> > WindowsCygwinnonPOSIXandMinGW
[..]

trac #746

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ShJiFmZFPUEMHaH+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/FIhKkuBuNlUUl1AQJLjwP/R+QvqvOLRwHTPKZgNGJCiCYvoZTsHu0C
g5rWiv1DESVAulybPfSnEwG9glMB/7+mYYnqnqEq3Kgoa0sbVVbOjKJHGwDYRkQQ
S3ZAS/qRAXF2wXyu+MoehcwFwYJlyZDe2MrpxDkDllupFwgLAZp0WJNB7IM3ZvxD
5xCPZbKAhag=
=HLkl
-----END PGP SIGNATURE-----

--ShJiFmZFPUEMHaH+--

