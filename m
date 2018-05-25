References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
 <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
 <fd348cf4-8d17-24b1-cace-f238d319c550@...1227...>
 <03f8402c-a603-3405-543a-e5eaa1ebc224@...1147...>
 <1d803ca0-2f28-585c-eeca-4c64ac2d745f@...1227...>
 <d8fe4a16-fc48-f1f9-3d4d-b82a906bb322@...2080...>
 <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <cc520540-3331-de68-c433-744e1b49b4b9@...2181...>
Date: Fri, 25 May 2018 15:57:29 +0800
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xAQSKqK4ZHhlWjM47sS3IZ1HIMBUDS6c7"
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Arne Schwabe <arne@...1227...>, Jan Just Keijser <janjust@...1147...>, Steffan Karger <steffan@...1856...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xAQSKqK4ZHhlWjM47sS3IZ1HIMBUDS6c7
Content-Type: multipart/mixed; boundary="9bVCllL5GI1WLw8qh71g94xbRnXYaO40D";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Simon Rozman <simon@...2293...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne@...1227...>, Jan Just Keijser <janjust@...1147...>,
 Steffan Karger <steffan@...1856...>
Message-ID: <cc520540-3331-de68-c433-744e1b49b4b9@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
 <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
 <fd348cf4-8d17-24b1-cace-f238d319c550@...1227...>
 <03f8402c-a603-3405-543a-e5eaa1ebc224@...1147...>
 <1d803ca0-2f28-585c-eeca-4c64ac2d745f@...1227...>
 <d8fe4a16-fc48-f1f9-3d4d-b82a906bb322@...2080...>
 <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>

--9bVCllL5GI1WLw8qh71g94xbRnXYaO40D
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 25/05/18 09:41, Simon Rozman wrote:
> Hi,
>=20
>>> Private and public key are still used. The patch stil uses
>>> certificates and TLS, it only replaces the check certificate of the
>>> peer's certificate against the CA with a hash check (certificate
>>> pinning if you want).
>>>
>>> So basically instead of saying that you trust all certificates signed
>>> by a CA, you only trust only those certifcates of which have hashes. A
>>> certificate pinning of an unknown CA is exactly the same. Since you
>>> cannot verify that certificate you add a one off certificate in your
>>> list of trusted certificates.
>>
>> Correct me if I'm wrong, but this approach allows for self-signed
> certificates
>> too, right?
>=20
> Exactly! Client and server can use whatever certificate they like or make=
 a
> self-signed one. All they need to do is to exchange their fingerprints ov=
er
> some trustworthy channel.
>=20
> Simple. Like SSH.

As a side note, this approach might not need to disable the CA: a
preliminary check against the trusted fingerprints can be performed and
then fallback to the normal CA check in case of failure (but I'd make
openvpn *clearly* log what is happening to avoid debug nightmares).

Regards,



--=20
Antonio Quartulli


--9bVCllL5GI1WLw8qh71g94xbRnXYaO40D--

--xAQSKqK4ZHhlWjM47sS3IZ1HIMBUDS6c7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsHwekACgkQB6U8WA7y
zXQVKg//Zja63SVOlfxcKje5ZwwHNSAG3eJx0m0Z7REbO9mcQpUF2beILRufcTyK
Qf6ShlCVukMuSWmFLIkxzxUN/s7iVm6h7dknj7c5wGJlRCkiJjzBPbD+ORW2uvh1
VF6anK25wChaUm2hJcr2Z6Xs0PEmh094d+NdaK0Vf6m435vdYLPJd0Hu4T9gMr7l
sVzTvYIDblB5UMDTtcsWBfqnvOXNT3deEuzMhq1VK62w4W4xeZaw/om/PMVrwhs4
hQlJdIZ0TCcgetfp4PGEq+Oh9z8dOuNtmmJweeraP9hTuzZY4ZZYvc2004wG6xxX
SQtyxkVUt0d8gplRQ69H0lXl4u9fUBmLoGCockYpMJOfJ5RzSSD4C2pX2K0JlfyE
sSgt5PiuPm3w74b/O/KpXkQurCIdmWHCXugLpbDTVPJI+nPj3vYCrnzb0UukcA1h
1oQyUNyJTMkTD98aFu0gPKdVuTFKM06e7KKCGptp5B8Zvp0OTyQT0DSIWdQ+p27L
j8XgelUsVEDHVzyhBGTPjvSfu2sHtKbmSxXNidDQFnXU3j5Tv4eQu43qJUKjdY0W
dyb0n4oPryxJotvEBX+AgIc9feDDEQyvcmbFwiCQJ9dOtYfWGO0BxDLT1gi8hqj4
iqVdLCYg7NLO5l7awWIFzajo8HrUQ93ZydjDWryEYlQfaGlp0z0=
=OUGP
-----END PGP SIGNATURE-----

--xAQSKqK4ZHhlWjM47sS3IZ1HIMBUDS6c7--

