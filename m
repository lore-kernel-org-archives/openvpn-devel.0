Date: Thu, 1 Mar 2018 12:23:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180301112353.GX69387@...1296...>
References: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OEp3pE+VUYV0MT2S"
Content-Disposition: inline
In-Reply-To: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
Subject: Re: [Openvpn-devel] tls fix for upcoming 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

--OEp3pE+VUYV0MT2S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 01, 2018 at 12:14:06PM +0100, Simon Matter wrote:
> I've just done some test builds with 2.4.5 tagged version.
>=20
> Attached patch makes it build with older systems. Do you see any issue
> with the change?

Which SSL library version needs this?

(I thought we have test systems for everything we officially support, plus
a few more to catch avoidable LibreSSL breakage etc)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--OEp3pE+VUYV0MT2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJal+LIAAoJEB2Cnv7KVigSU50MAJvRjNjjsrhxO2MJClj4Hy7t
pB48nEyQGhGdDEMCs7MXztO2EqJZIsUoRk0vGcJg4FBLIXnBMfFCu4DoR030WfxZ
j31VNNUhwg6NTPxTXGxf9WagTkqNo3cQ0+pCapD/o2V7z9ADZteev8XnbnMhDeJk
K75IYOhLaI+xc/DYWpY6Z+f3KIdvodwkmbbxp5/0Y8u8oC8qtciaBrnSD0DlOPIB
NURwaVeu+4ZCoVCwwHkESaOktrsGFErhtVXgulP+Hve00MJ/K82RaPk3hwSjzg9L
iuVdtBfE5k5AkI/hdeFxhJsW51eeS8fJp8Bvg8fX/09R+0mQ8GhcvelBMpGGTt2F
Dflop7MuHzgHj7+Qe9Pzp2Ga6Xvbob2baLhXNZe4gZ1I6k/hkP5USSO3MfP36UJl
sI28p3/EIKgCUbK2yUu9+MlTvNFrXB/r8eFeSKcUncTP4QMbLxOejCb/Z9nIUEtb
jQj9fVUVeE4Z2PtRHTZ3Zol74EXBulTeTLUIGme7aw==
=NP/9
-----END PGP SIGNATURE-----

--OEp3pE+VUYV0MT2S--

