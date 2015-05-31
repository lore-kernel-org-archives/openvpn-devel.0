Date: Sun, 31 May 2015 14:03:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150531120327.GE382@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NRg0qHkDgHfQnopc"
Content-Disposition: inline
Subject: [Openvpn-devel] trac#261 / fix for --redirect-private
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--NRg0qHkDgHfQnopc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

the following patch was posted to trac#261, and I intend to ACK it
(patches to track are a bit complicated regarding our standard policy
and --author :-/ - but it's simple enough, and while a very esoteric
corner case, fixing a real bug :-) - namely, --redirect-private in
combination with --dev tap)

Specifically, --redirect-private does half the work of --redirect-gateway,
namely "install a host route to the VPN server via the current default
gateway", but not the actual "... and then redirect everything else into
the VPN".  This can be useful if you push the same private network that
is used at the client site, but do *not* want to push a default route.

This normally works, unless used in tap mode with routes coming from a DHCP
server, where it complains about missing --route-gateway, which isn't
actually needed for *this* part of the work.

gert


diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index dd69d8e..df80286 100644
Index: src/openvpn/route.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -837,7 +837,7 @@ redirect_default_route_to_vpn (struct route_list *rl, c=
onst struct tuntap *tt, u
=20
   if ( rl && rl->flags & RG_ENABLE )
     {
-      if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT))
+      if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT) && (rl->flags & RG_RERO=
UTE_GW))
         {
           msg (M_WARN, "%s VPN gateway parameter (--route-gateway or --ifc=
onfig) is missing", err);
         }



--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NRg0qHkDgHfQnopc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVWr4jqkuBuNlUUl1AQLXxAQAqxXzras92nPG7AaUQxDta3voLZC3yqpg
y/ATtxvJ/0koDzJrqidvwTmmvd9sRIr5olXfYUs4ulENvLohU6mipgTq2HeqNg3K
byAq0wsRRaaYmFfKCAvO++kwi8BpmM3l+NdpffKSCFztg8yuFMnV7kd+XnZmQuoc
mzal58+PgEg=
=zLM+
-----END PGP SIGNATURE-----

--NRg0qHkDgHfQnopc--

