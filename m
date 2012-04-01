Date: Sun, 1 Apr 2012 14:05:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120401120555.GA1359@...1296...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-2-git-send-email-alon.barlev@...277...>
	<20120401113759.GZ1359@...1296...>
	<CAOazyz0eBQK2iSwHrZmt1GA7BtfGi5b+yvQXe6Ug2514vJamzw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mixpuywmQk4RxeDV"
Content-Disposition: inline
In-Reply-To: <CAOazyz0eBQK2iSwHrZmt1GA7BtfGi5b+yvQXe6Ug2514vJamzw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] cleanup: avoid using ~0 - generic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--mixpuywmQk4RxeDV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 01, 2012 at 02:52:46PM +0300, Alon Bar-Lev wrote:
> On Sun, Apr 1, 2012 at 2:37 PM, Gert Doering <gert@...1296...> wrote:
> > There is a similar bit of code in the win32 section, in
> > get_default_gateway_row():
> >
> > get_default_gateway_row (const MIB_IPFORWARDTABLE *routes)
> > {
> > =A0struct gc_arena gc =3D gc_new ();
> > =A0DWORD lowest_metric =3D ~0;
> >
> > ... which might also be a candidate for this change. =A0As I'm not sure
> > whether UINT_MAX is appropriate for a DWORD, I'm not proposing anything
> > particular for this occurance.
>=20
> Right... I need to modify the patch.

Let's get this one in first, as it is (to follow the current workflow),=20
and let one of the Windows guys look into the other part.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mixpuywmQk4RxeDV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3hEo6kuBuNlUUl1AQJ+6wQAwwaBwagsleS6+qsd8ziVV3WSB6f2vz7q
8lz154YxpmVeLXNMzF3QB+LV7uOYJs2zGEG0Rx8vsxRFSGnR4BF+NRdPiA1VTjUi
gOUMc38GxTp95rESM+zw2vQXu7s5JnvlGGMzzLDPNvkIFEC5rB6vJSuq2GEzUIR/
xNp7jwW1lK8=
=HhMQ
-----END PGP SIGNATURE-----

--mixpuywmQk4RxeDV--

