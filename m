Date: Fri, 29 Jun 2018 08:33:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180629063336.GH57262@...1296...>
References: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
 <20180628065703.GS57262@...1296...>
 <046f2ff7-2340-abd0-7f3a-6a31455b2fc3@...515...>
 <DM5PR08MB36420E57A6907302D18A515FB94F0@...2422...>
 <20180628165617.GZ57262@...1296...>
 <DM5PR08MB3642C3F6067B680D5BE439A8B94E0@...2422...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="R8HE/yN9deeWkwj/"
Content-Disposition: inline
In-Reply-To: <DM5PR08MB3642C3F6067B680D5BE439A8B94E0@...2422...>
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: Gert Doering <gert@...1296...>, Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--R8HE/yN9deeWkwj/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 29, 2018 at 01:56:25AM +0000, Morris, Russell wrote:
> Good find - thanks! Yep, that was it. And it had me very confused how tha=
t happened (static settings), then a bit of sleuthing here - Tether changed=
 it, as part of tethering my Android phone (tried it again, found it in the=
 logs).
>=20
> Much appreciated! And just a though, but - perhaps something to have the =
service be able to do in the future?

Most definitely :-)

We're currently (for 2.5) ripping appart and rewriting large parts of=20
"tun.c" already, which is responsible for interface setup - and the way
windows is currently handled (4 or 5 different methods of configuring
IP addresses) is hard to maintain and error-prone, thus on our list of
"we should be able to do better"...

(This is code that goes back to before WinXP...)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--R8HE/yN9deeWkwj/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbNdLAAAoJEB2Cnv7KVigSFWML/RCcE6Rj5NVImR1lOX3t6Piy
hV6b0Ac+iB0NinxIOmy+IPSn1TFrCzJf6Lr4VL4kQDcTnWKiq0wcUPHbww0WRDAy
Y7pn3Ry4mAPMdOA0dYuWdNeaBRQgaw2BnLM1O51xqdbqKFP5rKmxGI7LcVXjWQWA
5h/GevH/xgMtb+nRiYJqLR8qWZHQFeHGY9RKbB1RBtfpGa6/RL6RYI13SbiI+Nsf
swwAac7ARCUVdEWuH5wmtJ95+VueSd7a35Msq1oym0bE6k91njbN7WF2dxpCId9W
vkVqa7EBqJO9xOvBSqbntkA5aYHmrL/uKgA+VjqP3pjOwTBa3POVcNIPEo+8p73l
Qfd5gQocNQYE+OI4XGibuvtQeXuy9Flzxi4WFKgAf88PMaWtBPJqfSyb6lW6dq+M
tCk2/58hP/KR2h6vbKuN/WQ3KzZybxn2EQX0coWKWL5HGSvyA/udH5suirxt/Kfv
io3ewd69EMEx7JRjAWJ+1nY/ROJK2r68Sf6wwVtxlw==
=uXfY
-----END PGP SIGNATURE-----

--R8HE/yN9deeWkwj/--

