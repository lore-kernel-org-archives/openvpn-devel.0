Message-ID: <20100820162406.21059.qmail@...1287...>
Date: Fri, 20 Aug 2010 18:24:06 +0200
From: Peter Stuge <peter@...1287...>
References: <4C6E73E4.6060300@...515...>
	<20100820153536.14097.qmail@...1287...>
	<20100820154817.GC23371@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20100820154817.GC23371@...1296...>
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

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gert Doering wrote:
> The app is cross-compileable today - but to make that work requires that=
=20
> all relevant Windows APIs are exported in mingw headers *and libraries*.

Sure. You emphasize libraries, but MinGW is not so much a library as
it is a wrapper for the standard runtime from MS.


> Windows APIs have the nasty habit of changing over time,

I know this. I also do win32 development. With MinGW.


> so if mingw stops updating their libraries etc., OpenVPN would be
> sort of stuck to the old APIs - which might turn into a problem.
> Or might not.  We don't know...

What could happen is that OpenVPN wants to use a brand new API which
was introduced in e.g. Windows 7, and if MinGW doesn't yet support
this, then it can't be used.

First of all, I'm not sure that will happen, since we want OpenVPN to
be backwards compatible for older Windows systems too.

But if it really is neccessary, then maybe that API can be added to
MinGW with very little effort, since MinGW is just a wrapper.


> > libusb-win32 can already compile their driver using MinGW.
>=20
> To be able to cross-compile the driver would certainly be nice.=20
> Need to check how libusb-win32 does this...

They've switched to depending on the WDK (supercedes the DDK) out of
preference and stopped supporting MinGW builds. Rev 212 from May is
the last that cross-compiles without problems.

svn co -r 212 https://libusb-win32.svn.sourceforge.net/svnroot/libusb-win32=
/trunk/libusb libusb-win32
cd libusb-win32/
make host_prefix=3Di686-mingw32 libusb0.sys

(You may need another prefix.)


//Peter

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFMbqwmhR3Q0dhIfEgRAjg4AJ9neP61wzmQza50DUyuTaurZNYgZACfRzQl
87dvM+tu/f6t2rzy6zmKsJQ=
=P/HH
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

