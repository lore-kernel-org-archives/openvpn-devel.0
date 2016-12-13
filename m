References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
	<CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
	<CAKuzo_gH8UNruspCDOTeAa-wU9YsDB8nGGponvkCrVWnPR7SKw@...278...>
	<CAA1AbxJORM6ONqNNH7cA+Wy88_f1us=jvtTSXKzc4r5YbwtQcQ@...278...>
	<efc994a6-49bc-121b-3c47-503e6228d1ca@...2080...>
	<CAKuzo_hQyg2vQidGdkhOkn8jCSQKN3+uh-SL-uc8sfft_fFFeA@...278...>
	<a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f4e2b0db-98e8-ea01-36cb-30f3cb86eab5@...2080...>
Date: Tue, 13 Dec 2016 21:56:41 +0100
MIME-Version: 1.0
In-Reply-To: <a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BMSpUAQL83aSHCaevEgoHNqkx5uMRSFFr"
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BMSpUAQL83aSHCaevEgoHNqkx5uMRSFFr
Content-Type: multipart/mixed; boundary="f0RlaVhOiG4EHe9HXqcLHFKclTq7ldkhI";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <f4e2b0db-98e8-ea01-36cb-30f3cb86eab5@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
	<CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
	<CAKuzo_gH8UNruspCDOTeAa-wU9YsDB8nGGponvkCrVWnPR7SKw@...278...>
	<CAA1AbxJORM6ONqNNH7cA+Wy88_f1us=jvtTSXKzc4r5YbwtQcQ@...278...>
	<efc994a6-49bc-121b-3c47-503e6228d1ca@...2080...>
	<CAKuzo_hQyg2vQidGdkhOkn8jCSQKN3+uh-SL-uc8sfft_fFFeA@...278...>
	<a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
In-Reply-To: <a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>

--f0RlaVhOiG4EHe9HXqcLHFKclTq7ldkhI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/12/16 19:55, Steffan Karger wrote:
>=20
> On 09-12-16 22:44, Selva Nair wrote:
>> On Fri, Dec 9, 2016 at 4:39 PM, David Sommerseth
>> <openvpn@...2080...
>> <mailto:openvpn@...2080...>> wrote:
>>
>>     On 09/12/16 22:27, Steffan Karger wrote:
>>     >
>>     > Sounds like we have a final config on the CodeStyle page now.  Are=
 we
>>     > ready to run it on all code now, and publish a reformat branch?
>>     >
>>
>>     Agreed.  I can do this later this night.
>>
>> Wait a minute we may need cmt_cpp_to_c=3Dtrue  -- I saw some C++ comments
>> (added by uncrustify) in header files against #endif etc..
>=20
> Indeed, tested and added to the CodeStyle page.  Anyone up for creating
> the reformatting branch?

Already at it.  Written a script to do everything in a consistent way,
added the cmt_cpp_to_c=3Dtrue (and sp_arith=3Dadd) .... just reviewing that
things isn't too bad ... I do see we have some files which will need
some refactoring to be readable, mostly due to our 80 chars limit.  But
looking good ... hope to have something out within a few hours.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--f0RlaVhOiG4EHe9HXqcLHFKclTq7ldkhI--

--BMSpUAQL83aSHCaevEgoHNqkx5uMRSFFr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUGCJAAoJEIbPlEyWcf3yowYP/0TuN9K2v0Vh1nf1N8NMpPl+
FNCxgigunCP8stzj1FSbAWOYocnkbWj2qV5q6jiJOLEyVOCTdtizsunR21YaxlrK
k4ifP9OjmP93AxGt7SsyR72Mw9B9+RPmLFmnw1z2LHztXL2xU8O+xqkv6MvMS76d
1vRqVqtY19FXTofC9uPXOwKZnD8RQO3SdFEReGWMxK81TTFbtyxcr4wU6nkM0kZp
yTm/JIBkoRPYRKkjt3T3qoXM0CfDfLe8lw5E9+R7h0h2ODaM/8dvBoOiNuIyH2Z8
oBBkaQoyogWz08a95YBsnLdxt1SYUURe9eLugQ4pLRGZKsOKNYqlG4LBRIEQXdWY
IQSgwDkOM1D0EzvIdgoV/O+dV09s49BhxKO/awD8W3vRhb2md4PVV9FDKRKCOQAk
BgNGt4+o5XUK0X08jcAQESw7L0LHFU9MOXF+M/KAzZk7QbvgPylVZ+RmZOCXpBXa
M2Nht1Fs93Zaip74FgCZ3H77ArPm+ffmjvDsZL20w3uG3WYE3MwWTwq0oemZqLY6
oYzPHe5ygIjyGF/mHaGHwJZk5OBziKmzWDVCMWvgqidN/SqMVzSrdJkFt540T7uD
4E4eIOvazephrZfcpjcpC+kXOaFsII2KuugsfbV2KhWTbGLTkqoAQpO1zf6f6Pna
vN7BQpG1eZPtax6CuXsq
=NNne
-----END PGP SIGNATURE-----

--BMSpUAQL83aSHCaevEgoHNqkx5uMRSFFr--

