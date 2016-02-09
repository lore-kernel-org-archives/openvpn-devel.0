Date: Tue, 9 Feb 2016 10:28:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160209092821.GH24952@...1296...>
References: <20160208213929.GA20623@...2120...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q4WxCQx2XCrgJ/td"
Content-Disposition: inline
In-Reply-To: <20160208213929.GA20623@...2120...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

--Q4WxCQx2XCrgJ/td
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 08, 2016 at 10:39:29PM +0100, Samuel Thibault wrote:
> Is there a reason for not being allowed to set route / route-ipv6
> options in the ccd?

"Nobody has implemented it yet" - plain and simple...

So - someone would need to implement this (including route/route-ipv6=20
cleanup at client disconnect), someone else needs to review and test it...

I've run into this myself and cursed - and then used --client-connect to
achieve the same result (if not exactly pretty).  Alternatively, using
--learn-address might actually be much easier than --client-connect, as
it will already tell you which networks are "new for this client" - from
the description, I'm fairly sure it handles iroute/iroute-ipv6 as well,
but for whatever reason I've never actually used this combination...
(I use --learn-address to enable statically-addressed clients to connect
to different OpenVPN processes, but these do not have subnets routed)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Q4WxCQx2XCrgJ/td
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrmxNakuBuNlUUl1AQIWtQP/cm76ZNeaQzDtObpCZxwd1QHSwv0ThTTh
1v/aA3D7DoRcDS6YGYkD9OaDoEkXCHqKRF012KpPfknpo2JDCW5+SGKaW0g7fg9L
fq0aIDi2qqONPNfifZ0sr9KdRgSJMBnDrsb5Z+4JMCXqKd+7t5d3bdF4bHviO/7A
KjmAkN+4qm4=
=tKLO
-----END PGP SIGNATURE-----

--Q4WxCQx2XCrgJ/td--

