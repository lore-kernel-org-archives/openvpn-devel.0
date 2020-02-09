References: <20200207174818.21050-1-juliusz@...2525...>
 <20200208084558.GV1431@...1296...>
 <23330b19-35b6-7e4e-2f2e-9c3c1626f53d@...2525...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <fb9901f1-d304-ca31-cd9c-23712f320bd3@...2181...>
Date: Sun, 9 Feb 2020 10:44:48 +0100
MIME-Version: 1.0
In-Reply-To: <23330b19-35b6-7e4e-2f2e-9c3c1626f53d@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9oLKHhTM2ErsLYMb3kQTihLK8z8pIvkyk"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN master
 branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9oLKHhTM2ErsLYMb3kQTihLK8z8pIvkyk
Content-Type: multipart/mixed; boundary="LavqEn9BLKi21WYyLOD2fw268oJeyM21r"

--LavqEn9BLKi21WYyLOD2fw268oJeyM21r
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Juliusz,

if wolfssl support is being introduced by means of the openssl
compatibility layer, why do people need to configure OpenVPN with
"./configure --with-crypto-library=3Dwolfssl", rather than just using
openssl and specifying a different path for headers/libraries?

Isn't the compat layer in wolfssl operating as a drop-in replacement for
openssl?

Regards,

On 09/02/2020 10:18, Juliusz Sosinowicz wrote:
> Hi Gert,
>=20
> thank you for your comments. My intention was not to add a second cipher
> line in the sample config file. I added "cipher AES-256-CBC" to an
> earlier version of OpenVPN when there was no cipher specified in the
> loopback-client and loopback-server files. After rebasing my commit onto
> master I didn't notice the double cipher lines in the config files. I
> will remove this in my next patch as wolfSSL does support GCM mode but
> not yet in the compatibility layer.
>=20
> I will add GCM support to our compatibility layer and send an updated
> signed-off patch with a better commit message explaining what is
> happening in the patch.
>=20
> Thanks
> Juliusz
>=20
> On 08/02/2020 09:45, Gert Doering wrote:
>> Hi Juliusz,
>>
>> please send patches out of a git tree, coming from a git commit with
>> "git commit -s", and having a somewhat relevant commit message.
>>
>> Besides this, please do not
>>
>>> --- a/sample/sample-config-files/loopback-client
>>> +++ b/sample/sample-config-files/loopback-client
>>> @@ -25,3 +25,4 @@ tls-auth sample-keys/ta.key 1
>>> =C2=A0 cipher AES-256-GCM
>>> =C2=A0 ping 1
>>> =C2=A0 inactive 120 10000000
>>> +cipher AES-256-CBC
>> ... modify the sample config files (and *if* you do, do not just add
>> a second cipher line, which will confuse users quite a bit).
>>
>> If WolfSSL does not support GCM, this needs to be documented, but our
>> sample config files contain the recommended cipher for the existing
>> crypto systems, and this is (and will continue to be for the time)
>> GCM - faster, and lower overhead.
>>
>> gert
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--LavqEn9BLKi21WYyLOD2fw268oJeyM21r--

--9oLKHhTM2ErsLYMb3kQTihLK8z8pIvkyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOj/Eejms5Fxtp0v4pNfqZUlHtXIFAl4/1JcACgkQpNfqZUlH
tXJ3EA/8DF4a+PUBOQnZusRjigGOFTEucGkx5S0UlQL82vklSiUXH1AHbjKm4xfz
25KFBr/Hbda541QJFYpE1kJiWjQTtUlWig3vH+Fq19CDCkGwbqrSqsZ3i72nw9rx
ftbqPMpa0OBhd1XcpdWihtSQwaPzRNcQmXwY/zNLcqljA8VA3S+sBDv+SRIp9TSt
pHB6n6hSNpUrLd2tCHluZyyk4+YKF/vV5p4BbKxyb/XFHsUtS63/MxEQxLOfMQ0y
NyR1wZdtDlaIzhS9USVJNurXqsmzUe1Vgw7hqDOuu0ba+xsXyeKe2RWBqU5pc6fG
1CbVujlEUB0yv1kVIJQ96ZPd87ncB6SjENtl4VpLnn63XPUFplkEW116GbLRX5PB
xqiHP+a1JWDsRLbeNZGdIN/xHi6vJHqwGu/Np9Tva6bw6EScoJpbhBEWloKEtikH
mM4m+kL+YvDLxMt/+NCKeGEXBBlWxRPCHBstmUj/doRT2wbo6RfcaxLAfxg8Vg5E
ORaNayavsV0YIRL9FZ+cOTLKfn54jQg5hOCTX4Op7C2cHRzPTFhY6zNmr15hjPmT
9i9SO3YMPuuLf/2aXTRa5AAUIydbzBCgNLRCPS0RlT9P+4S/gKXI6GMAvMkEAP6P
PVTSjWp7FvnVtfujzg+9qc3WMVR+HzXDBdM3mgr9EAScord7JoA=
=WonX
-----END PGP SIGNATURE-----

--9oLKHhTM2ErsLYMb3kQTihLK8z8pIvkyk--

