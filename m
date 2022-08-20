Date: Sat, 20 Aug 2022 18:06:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwEGlqATPpa7ATpb@...1296...>
References: <Yv9fczYCUEM3i6V4@...1296...>
 <20220819193005.210-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QPYRCmUm+BJEBR2H"
Content-Disposition: inline
In-Reply-To: <20220819193005.210-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v102 3/7] dco-win: implement ovpn-dco
 support in P2P Windows code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>, Antonio Quartulli <a@...2181...>

--QPYRCmUm+BJEBR2H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 19, 2022 at 10:30:05PM +0300, Lev Stipakov wrote:
> From: Antonio Quartulli <a@...2181...>
>=20
> With this change it is possible to use ovpn-dco-win when running OpenVPN
> in client or P2P mode.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

I am fine with the code changes, and I have tested this on FreeBSD
and Linux with/without DCO (full set takes like ~2 hours now) - so=20
what worked before still works.


I am *not* going to merge this "just based on this", because I want to
be sure it actually works on Win10/Win111 with dco... can I get a=20
tester?  Richard refuses to do Win10, so, no DCO for him... :-(

(But I have confirmation that the resulting installers still work fine
for tun/tap and wintun on Win7, so that's at least reassuring :-) ).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QPYRCmUm+BJEBR2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjAQaWAAoJEB2Cnv7KVigSGjwL/AgRBy9q8uCjb5x70Af3eWSQ
hCVElNAP5V2p4c22MfmhUkcQjGj8VMTReIdGbl1Ei3D2hDnG/oIq4gC0dMCrP6h+
G6rPEdOAdq0F8N6G3ssmeqoC47qjkZKGXCRA2yZK2Zamfayh5RGN6n5GPw0DVEN7
rduhHdAfiuMjk5H+hd2QiTSoybfcS5Yds9aAkGrFfm+a2imBqaN38aHWlps123Yp
qLUV/3poi9miX1WMnoexQKYjXZ+Hb2bBLU3NFyPdcNuDcPWvj+hR4FB16d24qgwy
7JmvE+O8ZxcriXJZQ2hsa6uEiGJzkQ3mWaWKPHRC7exeDElAYRByDTKSNVS1Hl75
lAXI2VWl4OePQ6Vu/VXzjyQtDOrZOwLKgt+OhfDfrk6OlW0RyRKX794UbrUdjJ4s
kL49BJ0GB4oL16J/SfQoTYN6HQ7qEUnbH9Skmqz1sYUQ23DwFgmBuWPX3CfyLYyO
msDyXNnVVWIRKRiXXoJFAjSdmJrdP3GrxtInv9tVaQ==
=+wx6
-----END PGP SIGNATURE-----

--QPYRCmUm+BJEBR2H--

