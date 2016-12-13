References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
	<8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
	<20161213083314.GS78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
Date: Tue, 13 Dec 2016 11:29:17 +0100
MIME-Version: 1.0
In-Reply-To: <20161213083314.GS78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="19oHQW1NWxWG4N4DA6kb5vo3dxnumhxdv"
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
 --enable-plugins
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--19oHQW1NWxWG4N4DA6kb5vo3dxnumhxdv
Content-Type: multipart/mixed; boundary="kRslOnuIDpEX0fGdn6URsnAAJsqMnL28Q";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
	--enable-plugins
References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
	<8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
	<20161213083314.GS78624@...1296...>
In-Reply-To: <20161213083314.GS78624@...1296...>

--kRslOnuIDpEX0fGdn6URsnAAJsqMnL28Q
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/12/16 09:33, Gert Doering wrote:
> Hi,
>=20
> On Tue, Dec 13, 2016 at 01:15:03AM +0100, David Sommerseth wrote:
>> But I am wondering if it would be better to just do this in syshead.h
>> instead:
>>
>>   #if !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH)
>>   #undef ENABLE_ASYNC_PUSH
>>   #endif
>=20
> We discussed this on IRC yesterday, and I like Lev's approach more.
>=20
> Your approach will "silently not do what the user requested" - the user
> configured "--enable-async-push", and the resulting binary will not
> have that functionality because we turned it off again.
>=20
> So erroring out in configure if incompatible build options are requested
> sounds like a logical way to tell the caller "this is not what you want".

autotools and ./configure's task is primarily to *probe the system*, not
to safe-guard the user against invalid feature combinations.  It should
ensure your system have what is needed to do a good build.

Which is why I don't think such a check belongs in configure.ac.
Because --enable-async-push should be ignored if the user have disabled
support for plugins, becuase async push is a sub-feature of plugins.

If async-push is enabled or disabled have nothing to do with if the
system have all it needs to do an openvpn build or not.  It is purely an
openvpn internal switch.

>> My point is that there's no real point of screaming about missing
>> --enable-plugins if you have added --enable-auth-push.=20=20
>=20
> Someone added --enable-async-push to the configure command line, and they
> expect this to have a different effect than "not putting it there".

If someone added --disable-plugins, they don't need --enable-async-push.
 So no reason to scream about it.  That it fails to build with that
combo is actually more or less something which slipped through the ACK
of the initial patch (mostly because very few disables plugins at all).

Regardless, I won't NAK this pactch as it will resolve an issue.  But it
also won't get an ACK from me, because I do think this is an abuse of
./configure.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--kRslOnuIDpEX0fGdn6URsnAAJsqMnL28Q--

--19oHQW1NWxWG4N4DA6kb5vo3dxnumhxdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYT819AAoJEIbPlEyWcf3yJ+0P/38HZ/t5rU+pcqFMK334GlwZ
YOrR/EYbEsyrQZ7TCXvJT4cUhJaBZ6koOtIutQefSV2QMkTlZal2S+BnYq3kkkHY
AIbfL1qQ2e69vHqJa69gswL2ND6GjF4dd7HHziex6AFSnC7dTEuM2GfUCNls+SlB
YqHVlqRgxuLId6AMyjZ68sdA3hm/VAwcRrnpGvM9u5q0eEUeMZkcXiwQKWvMcRy7
1zzmj7qqKf0yT9aV9E7rRVJg6aXQoly3jCUwDkKmFm2K7yuiVcGVUzCHKwG5Bw+7
XwP2x2xLgNbWrv2tP65VN0k5dmRElgZiX0QwSFp5UMOn/PWEWXkGvLqMwtphv8w6
sveOxXpipneguWzQM+pewu1fJc5XFdn6OcQg5Hk3dGmuU7wVVR7ctQae7aBnm97F
NBVZuY47fbkZCLLK6YvXQV8UCJYHH2KWnNRFMlNv5jF+68xkeI52afjuAnSowVtl
um2AIgg4MHBQr+QRTnkD3oCSuzBml71QrVhtyCVF4i+urrIn1FxTBggrAwG9O3tE
GQIOJg53RhN3f6I104ZgJLxBxm9XYz+z+XzftWgAieJVRXnrRlJqMF+AxrlJPNJV
IasytK0HKpOUe8DvGnIjnOody9mUzqdihp+tKhFWwskhTna71OOJMnojgN8tP2Cz
mOLwZ2vM3f2dXbNg1arV
=C+rV
-----END PGP SIGNATURE-----

--19oHQW1NWxWG4N4DA6kb5vo3dxnumhxdv--

