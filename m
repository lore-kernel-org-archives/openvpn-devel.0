References: <20170225020229.17287-1-davids@...515...>
	<CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
	<40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
	<CAFHpkQEOCkqj0yHAH0gqJgmjpfSL-0ZgGLBPoeFnwoViY-sKow@...278...>
	<20170225143632.GZ12961@...2182...>
	<CAFHpkQFQn7udsMz5Ux6QfKRZveUpwP2GN6xt46ri+_fy3ixhqw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ed032bea-2e21-089f-44c9-b1480476002e@...2080...>
Date: Sat, 25 Feb 2017 21:25:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFQn7udsMz5Ux6QfKRZveUpwP2GN6xt46ri+_fy3ixhqw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dBkEMW8uv1M6H76vD6iTqfrOBUqokKkOV"
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
 functions
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dBkEMW8uv1M6H76vD6iTqfrOBUqokKkOV
Content-Type: multipart/mixed; boundary="mw5rbnUJfODD87NKxKXgJm7rM79etrexc";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <ed032bea-2e21-089f-44c9-b1480476002e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
	functions
References: <20170225020229.17287-1-davids@...515...>
	<CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
	<40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
	<CAFHpkQEOCkqj0yHAH0gqJgmjpfSL-0ZgGLBPoeFnwoViY-sKow@...278...>
	<20170225143632.GZ12961@...2182...>
	<CAFHpkQFQn7udsMz5Ux6QfKRZveUpwP2GN6xt46ri+_fy3ixhqw@...278...>
In-Reply-To: <CAFHpkQFQn7udsMz5Ux6QfKRZveUpwP2GN6xt46ri+_fy3ixhqw@...278...>

--mw5rbnUJfODD87NKxKXgJm7rM79etrexc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25/02/17 16:28, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>
> but for "[src/openvpn/error.c:824]: (error) Null pointer dereference",
> I'm afraid we should guard it with "#if 0", otherwise static analyzer
> will continue complain

No.  That function in error.c:824, crash(), which is only enabled with
ENABLE_DEBUG is explicitly written that way to crash OpenVPN when
called.  So that is purely a false positive, as the static analyzer
doesn't expect such nasty code to be there with a purpose.  But
triggering a crash like that can have some use case in some special
situations.

Normal builds should generally not be built with ENABLE_DEBUG, that is a
intended as a "developer mode".

We should generally avoid '#if 0' or even '#if 1' as much as possible in
the code.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--mw5rbnUJfODD87NKxKXgJm7rM79etrexc--

--dBkEMW8uv1M6H76vD6iTqfrOBUqokKkOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYseggAAoJEIbPlEyWcf3yv/gP/3eFTT4Z4r92C7P0f8eyYQoh
+gG566tEGMx1BYym+h0vCi95ElbgA6Isw2hl9r0jrclzlNwJseB36pAwFWMAaXUY
sKy8GN3uhGGysyHWWrcWJV8y5An6xYkrcwQfgeWIkMB3t6TduxAgAZ+Jh0SP2IuO
PczCeVpDjLVUrN2/RSuiVlL+hmraHwWqcL2Y4tfX7Go7zUT2h7L5kedapKIn9YQ4
0W/YuLr9Oz9Sw4e1K3y37KiaCSh2WzLxrsh767CuVdkE84E2PrJ4IcwYZCTFf6dB
On67jZxvMDlI/14ZZffYCKX6ai3tfRCaV59Bjpvi4sxzsg6AKCiD6vhy544l1RiP
09XBeM6h5ZmBZ0TK50x/NmAo4CjMkqK1b6W4/zV6fFxqZNOa4ByANq83qIKVwgwb
RG+P4MZEm62L6nu+nxQZsxp3m+Dxjcqt+Yqsg4PzqUTdRYXPlQhnmz0QU/T+NRce
qluEAtya2abwxThuAmNQfy/BY6sBfvjXoyDE3Cxe9U4LM0DGJSvmbfQlmqk3m9Wh
CSNETA4cRFZJg4/8YuOz+8kFvhvmKyuqimwqjfR3dx6rzHxLVnyoxBMUKQTpo1co
2ayLHVRYbO7XSdkYmL8rahi3PVIBD+rKljoa7sgSNNT7suiA2cx1sDCgSjnB10Jl
hMntMfyFxkEshkvW91hw
=z1+r
-----END PGP SIGNATURE-----

--dBkEMW8uv1M6H76vD6iTqfrOBUqokKkOV--

