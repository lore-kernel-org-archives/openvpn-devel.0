Date: Fri, 2 Oct 2020 18:34:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201002163444.GG976@...1296...>
References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H7BIH7T1fRJ3RGOi"
Content-Disposition: inline
In-Reply-To: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
Subject: Re: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--H7BIH7T1fRJ3RGOi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 02, 2020 at 03:26:29PM +0200, Fran=E7ois Kooman wrote:
> The log shows this "NOTE": 2020-10-02 06:20:07 NOTE: unable to redirect=20
> IPv4 default gateway -- Cannot obtain current remote host address

I have a patch for that one already, which is fairly obvious:

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d75aa5f4..490d6d51 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1015,10 +1015,6 @@ redirect_default_route_to_vpn(struct route_list *rl,=
 const struct tuntap *tt,
         {
             msg(M_WARN, "%s Cannot read current default gateway from syste=
m", err);
         }
-        else if (!(rl->spec.flags & RTSA_REMOTE_HOST))
-        {
-            msg(M_WARN, "%s Cannot obtain current remote host address", er=
r);
-        }
         else
         {
 #ifndef TARGET_ANDROID
@@ -1041,7 +1037,8 @@ redirect_default_route_to_vpn(struct route_list *rl, =
const struct tuntap *tt,
                 /* route remote host to original default gateway */
                 /* if remote_host is not ipv4 (ie: ipv6), just skip
                  * adding this special /32 route */
-                if (rl->spec.remote_host !=3D IPV4_INVALID_ADDR)
+                if ((rl->spec.flags & RTSA_REMOTE_HOST)
+                    && rl->spec.remote_host !=3D IPV4_INVALID_ADDR)
                 {
                     add_route3(rl->spec.remote_host,
                                IPV4_NETMASK_HOST,


... but it's incomplete, as the "if there is no ipv4 gateway at all"
case is also broken (Thomas Sch=E4fer reported this).

This is just a HEADS UP ("I am working on it, and if you want, you can
comment on the solution I found"), a proper patch will follow tonight.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--H7BIH7T1fRJ3RGOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfd1akAAoJEB2Cnv7KVigSNTEL/2XT0iBlYlGZM47c7n0Ei6PT
/nm2lou8TScjCYmo2dw03j0WqnKMAXQ47igjEsi8NgFPVwEHFETgSY6iUvZFw60H
w+uNETdOM8vYCzD3gsoi0+hPL+aFLojA2in4VFvvF2hhnVIw8iArxgabUGVtbnAK
eHJqVO4+o3cHPNgLWqt/WiDSA/WKzHeiAhUYo+tz7ysGrA2hXg82riMcFqUnYrJN
zRIWZ3cXieWC71IXWD71cKZTHnER1vvBNmaZ32OhaVDVPZBNyFvg+rx6ebTGg0pI
CwBjKx7EtIgeSEU3PCawi+aMvDuyTPq9qECWjXKbEglPp/NmYPvMo6TGcX3xbl4b
tbpGpvE6+XYLZVdP+nF3Epn7U1sKObxG/JWBLZPkqqVYk1gebwwPAVz04vTmml4z
WaBeXbhnzKwisiN8/0rohDVsH78M17vaXXqgAG+wnb/z/QKFHD8qEpUPBUj2JSeS
qcHVoZzxHwrPQe6dfWFvEepCH45T6ZCNzuCO++vlyw==
=YQII
-----END PGP SIGNATURE-----

--H7BIH7T1fRJ3RGOi--

