Date: Fri, 20 Aug 2010 18:41:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100820164140.GB10703@...1296...>
References: <4C6E73E4.6060300@...515...>
	<20100820153536.14097.qmail@...1287...>
	<20100820154817.GC23371@...1296...>
	<20100820162406.21059.qmail@...1287...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20100820162406.21059.qmail@...1287...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (19th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 20, 2010 at 06:24:06PM +0200, Peter Stuge wrote:
> Gert Doering wrote:
> > The app is cross-compileable today - but to make that work requires tha=
t=20
> > all relevant Windows APIs are exported in mingw headers *and libraries*.
>=20
> Sure. You emphasize libraries, but MinGW is not so much a library as
> it is a wrapper for the standard runtime from MS.
[..]
> > so if mingw stops updating their libraries etc., OpenVPN would be
> > sort of stuck to the old APIs - which might turn into a problem.
> > Or might not.  We don't know...
>=20
> What could happen is that OpenVPN wants to use a brand new API which
> was introduced in e.g. Windows 7, and if MinGW doesn't yet support
> this, then it can't be used.

Yes, this was what I understood James to be worried about.

> First of all, I'm not sure that will happen, since we want OpenVPN to
> be backwards compatible for older Windows systems too.

It might be necessary if "the API that we currently use" stops working
on Win8 or so...  (and yes, that would require different #ifdef=20
branches for "old windows" and "new windows" - nasty, but sometimes
unavoidable)

> But if it really is neccessary, then maybe that API can be added to
> MinGW with very little effort, since MinGW is just a wrapper.

Now that's good news.  I had the assumption that they are basically
providing "re-engineered" versions of the windows libraries etc.
(as WINE does for the runtime environment).  That would have been
much more work.

> > > libusb-win32 can already compile their driver using MinGW.
> >=20
> > To be able to cross-compile the driver would certainly be nice.=20
> > Need to check how libusb-win32 does this...
>=20
> They've switched to depending on the WDK (supercedes the DDK) out of
> preference and stopped supporting MinGW builds. Rev 212 from May is
> the last that cross-compiles without problems.
>=20
> svn co -r 212 https://libusb-win32.svn.sourceforge.net/svnroot/libusb-win=
32/trunk/libusb libusb-win32
> cd libusb-win32/
> make host_prefix=3Di686-mingw32 libusb0.sys
>=20
> (You may need another prefix.)

Will check this out - not that I have any realy understanding how windows
device driver building really works, but I've done "build tap with
WDK" (because you can't download DDK any longer), so maybe it's enough
to put the pieces togehter.

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTG6wRKkuBuNlUUl1AQL9/AP/fabegluAm7iM5LyqyX2LxKUR4D29eLyv
w80Vfg3wCx9SnFI2GY3vu+7vP7KDYVu00kfURFU19dd8W7vgbKCJrI5D+9Vmr704
LHkilAp+vRQgjsVFEPvXlTQtmGjKvezSak15iKr0VHttJsjUwlDTounAC7X3l6uz
HFjVRMzsns4=
=siGh
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

