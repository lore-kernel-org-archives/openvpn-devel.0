Date: Sun, 5 Nov 2017 18:11:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171105171135.GL958@...1296...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <41c0e750-b27e-22ea-d5fb-b17fe391636d@...1147...>
 <689096e2-8bb8-95b8-5daf-22fd600a00ca@...515...>
 <da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
 <82ec1478-ec53-3980-05b1-4529a74aa789@...1147...>
 <20170717121451.GQ70062@...1296...>
 <a3d45ab2-63e9-2849-6118-775a8f43ec87@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dtsE+6jMZxJpedRo"
Content-Disposition: inline
In-Reply-To: <a3d45ab2-63e9-2849-6118-775a8f43ec87@...1147...>
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--dtsE+6jMZxJpedRo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 17, 2017 at 02:22:55PM +0200, Jan Just Keijser wrote:
> On 17/07/17 14:14, Gert Doering wrote:
> > Hi,
> >
> > On Mon, Jul 17, 2017 at 02:10:11PM +0200, Jan Just Keijser wrote:
> >> this problem is NOT present in OpenVPN 2.3.17; the same warning appear=
s (route gateway is ambiguous) but the route is added
> >> anyway. This seems to be a regression in 2.4.
> > Can we have a log, please?
> attached: config and log (with hostnames anonymized)

This indeed is a regression, or a "non-handled special case in the iservice"
(waking up Selva and Heiko).

2.3 is calling route.exe, which seems to just handle this case fine
("the given gateway address is present on two different interfaces",
which I find ambiguous myself :-) ).

2.4 in your setup is using the interactive service...

> Mon Jul 17 14:18:43 2017 us=3D1227 TEST ROUTES: 3/3 succeeded len=3D2 ret=
=3D1 a=3D1 u/d=3Dup
> Mon Jul 17 14:18:43 2017 us=3D1227 C:\Windows\system32\route.exe ADD 222.=
222.97.13 MASK 255.255.255.255 111.111.135.254
> Mon Jul 17 14:18:43 2017 us=3D1227 Warning: route gateway is ambiguous: 1=
11.111.135.254 (2 matches)
> Mon Jul 17 14:18:43 2017 us=3D1227 Route addition via service failed

... which notices that the gateway is ambiguous and refuses to cooperate.

Without checking the code, there's a few things here that are not good

 - that openvpn just goes ahead, while it "should" know that adding the
   "def1" default routes afterwards is going to make things explode
 - that we fail, instead of just installing the route (with warning) -
   which could either be "just pick an interface and log that" or "just
   pick no interface at all, and let windows routing figure this out"

> Mon Jul 17 14:18:43 2017 us=3D16827 Recursive routing detected, drop tun =
packet to [AF_INET]222.222.97.13:1194
> Mon Jul 17 14:18:44 2017 us=3D108829 Recursive routing detected, drop tun=
 packet to [AF_INET]222.222.97.13:1194

Now *this* is actually good news :-) - instead of blowing up your CPU,
we notice that we're stuck and log that.


As a workaround, what you might do instead...

 - connect over IPv6 - the IPv6 code is different and I'm curious what
   it will do :-)

 - use "--ip-win32 ipapi" (+ run gui as admin) to avoid using the=20
   interactive service

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dtsE+6jMZxJpedRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/0ZGAAoJEB2Cnv7KVigSpBoL/1bXgXZxe8tgWcaE4plOautM
gZNn5gtV/n3mJdJkzWtiDW+YIIJsNC51Ht9e0Nw/EZHJF4X6bpTiatU0kzSXlbjr
pHaGxhY0rGhfzNk3uU1Q2WfWOmQsN5gb9TLYRbS21qyXBkyU/7ogFrJzpQHimot4
Sf1OBsKEJ61O/rMVKmjJ9oWA4A93ErrjMbdspoLW0QBfQGnyY/S6nJk16aJOj/nK
Uf/ZZV0lWgF2EDW6+6lCiIJB038MVjAwA2TsYdgSIpS7pl1njr0Bjqq/4B2BRFit
26j5Z4fhWhMZO3/sYr1XN0IhAViTuVFL7jhT8oR1eDkp/K8JMx+rwmqiOO9OGsmR
7D33QGdZwVOSNqlfbyWNV6N/qsc5CzdSVkxP4nkSypVmcFLEMOwgaE8jmi+l6oS+
/vbCsEWc8NOWvKJ6nccVsI4e+bSxy3ykfE3YMm3Did7/p9OFqhYA+KdBpXhCN00/
cAQNZSD7B+33LzMsLsXPLE8RfwBBVhVy3QbVS8DA5Q==
=hxLw
-----END PGP SIGNATURE-----

--dtsE+6jMZxJpedRo--

