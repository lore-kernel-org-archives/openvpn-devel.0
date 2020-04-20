References: <0a607581-4179-a97b-1e8b-e19dd6bd85bd@...515...>
 <CAEsd45Q+GvZf3du9FYCaLiPeupN88UTv3BjE1dzPKsJO2hzFjQ@...278...>
 <20200417213506.GI1431@...1296...>
 <CAEsd45Tym2Rs=v0RyQY57wWvNd0N=BXVLgRus5hoDYZRY+W4Fw@...278...>
 <67d10ca6fb99ba7d75ff0b65f84cb76f.squirrel@...2260...>
 <20200419100325.GZ1431@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <87a61aa5-bba1-637d-2169-4f9aa74d5044@...515...>
Date: Mon, 20 Apr 2020 09:13:10 +0300
MIME-Version: 1.0
In-Reply-To: <20200419100325.GZ1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8hYuueVNPWvq9Xn1d9VqBticGrX97VFyd"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.9 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8hYuueVNPWvq9Xn1d9VqBticGrX97VFyd
Content-Type: multipart/mixed; boundary="Sq0XGDCSFilzjKD87yz71iVAVS7pyn32R"

--Sq0XGDCSFilzjKD87yz71iVAVS7pyn32R
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Il 19/04/20 13:03, Gert Doering ha scritto:
> Hi,
>=20
> On Sat, Apr 18, 2020 at 02:30:46PM +0200, Simon Matter wrote:
>> A long time ago I was asking them to also show MD5/SHAXXX checksums so I
>> can easily verify the downloads. My request was turned down for reasons I
>> still don't understand. At least it could give us some peace of mind when
>> downloading OpenVPN and the PGP stuff doesn't work or is not used by the
>> person downloading it.
>=20
> True... Samuli, are you listening?  Adding SHA256s to the release
> announcement might not be so hard to integrate into your process, and
> help in case GPG acts up again.

> (Mostly because "the mail on the list is signed, the other openvpn
> developers see it, and if someone tries to play games, we'll notice")

Having SHA256 sum in the _release announcement_ is good, because it
can't be forged easily. But I would also have have it on the download
page. I just need to ask our webmaster to add that field. If the website
is tampered then we still have the release announcement to refer to.

On a related note: I think we should consider stopping the distribution
of the security list's public key from our webservers and just instruct
people to fetch the key from the keyservers and refresh it if they have
trouble.

Meaning: I don't see the extra value distributing the key from our
webserver gives anyone. But please correct me if I'm missing something.

>=20
> gert
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20



--Sq0XGDCSFilzjKD87yz71iVAVS7pyn32R--

--8hYuueVNPWvq9Xn1d9VqBticGrX97VFyd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl6dPXYACgkQKVhNn0CG
RXhkkwf7BW6XNgZYeG5J+Y4RXhdjW34iIQ4vhTV88neClO6bD6e7IOrqCqnlvLiw
OGcNBVKdb80R1YN4R6Yq4xEia0ZJ+rdizktsY+uqNFHUKViNB7OVCyln1nxKYIXb
euQJHTe6iHpTK8IfNK/TLoOQaTVSma/+pxNSfL1eLuZSfyC9UjcH8yJoci42tCHB
BrRzxfF5NkMjaZ0idc3aJ+4GL3knDoFfe1q2c+oLhjaLamXslygJmS57I42A9qRU
lPfM3ZSX6Pk94XNcH0JgMNsf8sNaTju1+whHMD5ciEXX5VfaxVWnwd1U8/AWSoVO
NETpZ6OMuMK3Hrf3kYjFt44jLgH2Yw==
=yXrB
-----END PGP SIGNATURE-----

--8hYuueVNPWvq9Xn1d9VqBticGrX97VFyd--

