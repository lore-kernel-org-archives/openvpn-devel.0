Reply-To: openvpn-devel@lists.sourceforge.net
References: <1498475606-8337-1-git-send-email-arne@...1227...>
	<99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
	<73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
	<96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
	<a486ae43-afd7-5066-5f32-459c90c7a976@...2080...>
	<cdb9b9a5-8df4-e5d9-5632-fb48bf7314f2@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3fd761c2-548b-8aeb-66ec-04bd4647c51d@...2080...>
Date: Mon, 26 Jun 2017 16:59:06 +0200
MIME-Version: 1.0
In-Reply-To: <cdb9b9a5-8df4-e5d9-5632-fb48bf7314f2@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="kVmKSgd7RXjp29OBflP5Sj2cmVPDqqCs5"
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before
 loading certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kVmKSgd7RXjp29OBflP5Sj2cmVPDqqCs5
Content-Type: multipart/mixed; boundary="KHH3grUX4r2tdeIxOWmlT6TN2pa9dh0FW";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <3fd761c2-548b-8aeb-66ec-04bd4647c51d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before loading
 certificates
References: <1498475606-8337-1-git-send-email-arne@...1227...>
 <99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
 <73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
 <96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
 <a486ae43-afd7-5066-5f32-459c90c7a976@...2080...>
 <cdb9b9a5-8df4-e5d9-5632-fb48bf7314f2@...1227...>
In-Reply-To: <cdb9b9a5-8df4-e5d9-5632-fb48bf7314f2@...1227...>

--KHH3grUX4r2tdeIxOWmlT6TN2pa9dh0FW
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/06/17 16:00, Arne Schwabe wrote:
[...snip...]
>>
>> Currently there is an agreement of the following profiles:
>>
>>   - legacy: SHA1 and newer, RSA 2048-bit+, any elliptic curve.
>>   - preferred: SHA2 and newer, RSA 2048-bit+, any elliptic curve.
>>                (default in v2.5)
>>   - suiteb: SHA256/SHA384, ECDSA with P-256 or P-384.
>>
[...snip...]
>> The suiteb profile is just reusing the mbed TLS definition directly.
>>
>> With that said ... The legacy profile does not include MD5.  So either
>> we allow MD5 into the legacy profile; or we need legacy-md5.
>>
>=20
> Yes but I think that is seperate effort. I am not sure how to probably
> implment that with OpenSSL. SECLEVEL is similar but does not have
> exactly the same consequences. YOu could probably emulate the profiles
> with some kind of tls-cipher settings. But if you do that, you still
> need this patch :)

I agree we need to have a mechanism for adjusting the
SECLEVEL/--tls-cert-profile.  The challenge is that we have users which
expects a similar behaviour, regardless if their OpenVPN build is using
OpenSSL or mbed TLS.  For end users, that matters - and we can't tell
them "for this OpenVPN variant, you need to use this syntax".

In addition, AFAIK the --tls-cert-profile support is already released
for OpenVPN Connect.  IIRC, that approach was agreed upon between James
and Steffan at the last Hackathon.

Unless there are really strong reasons not to continue with
--tls-cert-profile, I am of the opinion we should go that path.  That is
to ensure sites already rolled out --tls-cert-profile will not start
yelling at us later on.  OpenVPN 3 based clients needs to behave
similarly to OpenVPN 2.x when it comes to configuration options.  And
OpenVPN 3 is what is inside OpenVPN Connect and PrivateTunnel clients,
which again have ties to OpenVPN Access Server.  We need to ensure we
don't add fragmentation inside the OpenVPN environment.

Of course, it won't be easy to make the users have the same experience
regardless if OpenVPN use mbed TLS or OpenSSL under the hood.  But I am
do strongly believe that is the proper way to handle this.  OpenVPN need
to "glue" this together so the user experience is unified.

I am also aware that we have a few mbed TLS specific features
(--use-prediction-resistance) and there are some features only available
in OpenSSL (f.ex. PKCS#12 support, --capath, --engine).  This is
unfortunate, and we should try to reduce such gaps to an absolute
minimum.  So I cannot give an ACK to any patches which contributes
further to such a fragmentation - unless there are really strong reasons
to do so.

In this particular case, both OpenSSL and mbed TLS have a similar
features, so in this case it should be possible to get a unified
experience.  So lets try to aim for that.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--KHH3grUX4r2tdeIxOWmlT6TN2pa9dh0FW--

--kVmKSgd7RXjp29OBflP5Sj2cmVPDqqCs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZUSE6AAoJEIbPlEyWcf3yeR0QAJjs+gxuICuRcPXgCRqxRk6R
O8mZFmGJNSimfXm5kp8dyGMT1HgY2AXUGvd7wgTlaBj2BQGhuZnQblTyDsHJaHu1
ZJ1dc6fT9l60yi8Anocs/DRgy2JB4Fs0+7qoScAbqaKHTEH2YFhgXI4wn2W3DaRq
6b/OCzCVW9+RvIIU621v2a5u+cEU/SN4EKn+ANHRKUE4paJ5EZExNP7xH0JluJAG
6sLBLoFlpZzWr94cyHcDZhNiaKCZXSoWSf9lWH/coy+BeYOCfNDjPrrEpI5UkBTY
6MJjtW5QqkHRs/5LRgcxIAS28xVdn+n8lhwm2YXQsTtM7kTLXiJLaUqkehVRQoIk
mN8ZRdIpPEibJtXwOG0+dhVCqqdlk2hQn9C2y1tS/GjFL3/RKoXGKOUn/afs6oES
vES7z5NW/yDP4xHo7+zpNE9n2CF3hDbkSgpSRb48BX3i4n3d4Yths1dCvU4LhVVK
XSO+iP+oUldtKdRp8EpXMqOJMZeM5nyurMfH1NvXtMYI+suiXffTEVjpbq4aZQ8Z
ScmxJ1qJ8SHs8zb4cbHQcM1o2Obfoe4AgK462G2CvHbM6QuVxcfm6PR9lC4Zob8u
cAIMsFJSjsY8YMIzg4G4ujJKpBjNt7yWoJf57wFqkeCUGjtArPG1b/Ybq418RkCC
lbv4NR9gZMq953ZlU6/b
=mzsK
-----END PGP SIGNATURE-----

--kVmKSgd7RXjp29OBflP5Sj2cmVPDqqCs5--

