Date: Fri, 19 Apr 2019 21:15:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190419191555.GK31008@...1296...>
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
 <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
 <CAKuzo_iikr28FJcXNMz+xSbkoqZAyutJ3cx5J5zBvnEnEEw5bw@...278...>
 <d2f35ef2-dfbc-0202-2eb9-68e69051f742@...1147...>
 <CAKuzo_jn38kJm4izesNzK6fedgbc55MUYmmsyZRrZa1oaix5wg@...278...>
 <f120b337-53d1-b6b3-2188-db81fadc5bae@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mfP1iJBimQeSOP+4"
Content-Disposition: inline
In-Reply-To: <f120b337-53d1-b6b3-2188-db81fadc5bae@...1147...>
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Selva Nair <selva.nair@...277...>, Francois Gelis <francois.gelis@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mfP1iJBimQeSOP+4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 19, 2019 at 03:12:49PM +0200, Jan Just Keijser wrote:
> Can you do a pull request for your pkcs11-helper patch on the=20
> pkcs11helper github page?=A0 or shall we simply patch pkcs11-helper ourse=
lves?

I agree with Selva that it should go upstream - since this is not about
windows, we do not provide our own pkcs11-helper builds anywhere, so
either we get the distribution maintainers involved (lots...) or
upstream.

(On *windows* we could just patch whatever library we use for our builds)

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mfP1iJBimQeSOP+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcuh0aAAoJEB2Cnv7KVigSWUIL/3MCZppFX9Q0Zpi7wXDGQeWv
3OtTePmg4MnigAP16oMetG1BbHe22v01bwnUFfwRqpgQOQTA7hPizAhS9Q/zMzQR
TdTgwsTH9nhAeQLZHFtpaHPXRfUWrP1rRbgpznkcSevHMBKTSqz3dq903BnhjJOG
+nFxQa3PWdmd96tms6VoRveIife2H5APS+8pL6RKOMM82vQHH55zziCoOr40F9tg
Cpac/WhyHeNOKLpJPtWgPFr6OFPl3iic1n3IFEGk0AtN9Ary2dBn6Of6cEBOj7ve
bWrS1z1A6beRF60gYyb/s5iDR/eEzMHfeHkQTKzGBL328bAljngZE4X6ZfTNewxu
PENWr2tw45nvR5Y0K8mpchapjboN8af61aew77GwFuzicwCSY9bEOzjqAbVeSdKG
zmYQR2/FIuZ1eycuDl7gR8IfuNjqkVgv1NOuG4dwGjuO8QvWZQyzFHEuLHgx1u/F
w5vyp6u+68W4HMg39L1XuWzvToHevnVf0nPeEDHaNA==
=VMgm
-----END PGP SIGNATURE-----

--mfP1iJBimQeSOP+4--

