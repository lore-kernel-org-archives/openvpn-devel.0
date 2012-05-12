Date: Sat, 12 May 2012 10:10:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120512081025.GC1359@...1296...>
References: <CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<20120511185641.GZ1359@...1296...>
	<4FAD8A16.6020303@...1400...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sERRIhpDjaMjVTrQ"
Content-Disposition: inline
In-Reply-To: <4FAD8A16.6020303@...1400...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <schwabe@...1400...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--sERRIhpDjaMjVTrQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 11, 2012 at 11:52:22PM +0200, Arne Schwabe wrote:
> Am 11.05.12 20:56, schrieb Gert Doering:
> > Changing the build environment to build a shared library out of openvpn
> > is something I do not fully understand yet, though - and don't view
> > a particular useful goal right now.
> The shared library is not used as real shared library. I build
> libopenvpn as complete library and then build a miniature executable
> that calls the main method of the shared library and therefore exactly
> behaves like openvpn as executable.
>=20
> The reason for this is that libraries are managed by the android package
> system. For executables I have to carry them as data files and write
> them to a cache partition. By putting the main  code into the library I
> can minimise the amount of data that is written twice to the /data
> parition on Android.

I'm still not sure I fully understand what Android is doing there - but
I don't need to :-) - so that explanation is good enough for me.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sERRIhpDjaMjVTrQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT64a8KkuBuNlUUl1AQLafwQAiapAfTvpw0JXTbVQwwXZBQpqLXFMKqbp
RcPbmLxmDACmwEkgdUU4r9CAN/2yOjnS37T1sDu0qJIMkNQhCS7nqovxko39daKv
PcCsQgjNh0DPDWDYBm4cZAh2dzjmNv6i9H2aVRkP9/hc3M/VQSORnYRaiGzsYftx
/2JOUVDbvqw=
=ZIbh
-----END PGP SIGNATURE-----

--sERRIhpDjaMjVTrQ--

