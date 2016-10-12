Date: Wed, 12 Oct 2016 15:06:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161012130610.GC28918@...1296...>
References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
	<CAEsd45Tkkmbp=qbgVZxAt-U3hkLBQemOxDGRjTucLCoJPM+bTg@...278...>
	<026a4dab-8aac-7edb-4f58-4fbacfe56795@...1227...>
	<CAEsd45QhH3=xo-0A3QZe0eqp4gBM7T9WOvJ0Bu4+GFKJbRrtUg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <CAEsd45QhH3=xo-0A3QZe0eqp4gBM7T9WOvJ0Bu4+GFKJbRrtUg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 12, 2016 at 08:53:02AM -0400, Jonathan K. Bullard wrote:
> What I should have asked is: with this patch will an OpenVPN client
> still send out IPv4 packets if there are no IPv6 options specified or
> pulled from the server?

Yes.   Basically, the tun interface is now always in "dual-stack mode"
on those platforms where it matters (some, like NetBSD, can have=20
"IPv4 only mode" or "dual stack mode", and the latter was "newly added"
some 10 years ago...).

IPv4 is not going to be broken :-)

The only user visible change *expected* by this change is that previously,
"ifconfig-ipv6" would be rejected unless "tun-ipv6" was also configured,=20
and now this dependency is gone - if you configure (or push) ifconfig-ipv6,
you get dual-stack v4+v6, if not, you get a dual-stacked tun interface
with only IPv4 active.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/41QqkuBuNlUUl1AQKwogP/UlPDKaGlZH7/wteFUpDoYhw9OtfXRb3k
1v2Bcrn6wInyZzsnPhlMS74UnfS7nPOtLFbKKUMDnP4avFnnqaQGEtzjF+vtiZno
lk4HpC6D65ycmSBGKKXmfZPRAkvgQZNe0o4jmJctXQkIaCc973KhtB+bJYP97Jud
RgksDVzW02I=
=e/Sn
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

