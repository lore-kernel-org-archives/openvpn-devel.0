References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
Date: Mon, 13 Nov 2017 10:44:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171112214244.GI958@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fVSrNHCP0hKalnj94iXEDVgwuL9XAHBUs"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fVSrNHCP0hKalnj94iXEDVgwuL9XAHBUs
Content-Type: multipart/mixed; boundary="7Dr6qnbvxGnCbwgwamJg5Gwau5tmjf6Bm";
 protected-headers="v1"
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
To: Gert Doering <gert@...1296...>, Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
In-Reply-To: <20171112214244.GI958@...1296...>

--7Dr6qnbvxGnCbwgwamJg5Gwau5tmjf6Bm
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/12/2017 10:42 PM, Gert Doering wrote:
> On Sun, Nov 12, 2017 at 12:21:06PM -0500, Selva wrote:
>> One of the niceties of JSON is its readability which is greatly reduced
>> if formatted without line breaks.=20
>=20
> +1
>=20
> the difference in efficienty is not large, but "human readability for
> manual proofreading" is good.

Selva, Gert,

You know, the funny thing is that my main reason for implementing JSON
support for status was to have it easily _machine_ readable, for higher
level programming languages where JSON is "first class citizen", and not
primarily human readability. Besides you could easily do this to make
JSON human readable:

$ cat /path/to/status.json | python -mjson.tool

Thinking some more about it now, it doesn't really make sense to
implement JSON at all, because CSV _is_ actually meant to be machine
readable and a lot more efficient in the amount of data it uses (much
less duplication). So it seems my reasons for implementing JSON support
seems to completely miss the point. For machine readable output it would
make more sense to use a binary format instead of JSON.

What do you guys think? Are there any other reasons to implement JSON
support?

Cheers,
Fran=E7ois


--7Dr6qnbvxGnCbwgwamJg5Gwau5tmjf6Bm--

--fVSrNHCP0hKalnj94iXEDVgwuL9XAHBUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYje68UGKkH2qmOqnnF7dZFpXHrIFAloJaZEACgkQnF7dZFpX
HrLrqQ/+J3GKDAJN4I4HJcOj3hznWLGaiseYWFgG8R/0mYZBALddpo2JniiJrIi9
4+fuU1sAXQ1Ud1jDlhfPq6evp11Ro1f3if0Wp4Zjxq45Rbo7XiNy8yTaWnptYHK4
41yqvSNPceoGosdO+9D3OANG7JaJW9IMaKLoCYptygWMeKblSjTenp9zEIhl7eI9
ot0gleREITsky9BdNaKVQxjwFPxmgx/8r2Qkvib9rGHbRZ9DK3eF2sUkOMsPxKB+
/PsIYNRatfzPn82OseIedILGR7fn/pj4p84qHNVoIOqhuzWP7Oyhhr/om3QKcHMO
/vEw3g9D48WhD8bf7X+hZd0chr8IJYI0LR48jHtLRWfYsJxjIzLlz8/Dw9t5mSFT
GGYH208WCv3vqR9LeaLhwpqPbhn+EdK2R7Cfs/GapRJF7ZLgR+IT568osSMivHW+
LiWOh3Usg3h+Jm13XZQP3I4CchaFPmvyUMUiow2mjx7jM8vkn555UI4Yq25iZG6l
iWi4GMOIZKhK16EXeNy1U0XNpxxcQx5JXddqyNssnhU1m52WGwpLDGRYOKbTOlkA
hn2AzNoO3heJveyp1DolfflP/g5mxUjPHtKxJuNAMrxPSKfwgEjaJTwf9FO7FvlX
LbhKpIxw7gL4mn3U0JzbLF0PmLtAROSAMxT/RtbR7YY3rLccQpc=
=PPwI
-----END PGP SIGNATURE-----

--fVSrNHCP0hKalnj94iXEDVgwuL9XAHBUs--

