References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <7adfcf57-b3dd-0e6a-ced0-2767a5462699@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c6a491fe-17d2-445c-e99d-511992c33f38@...2181...>
Date: Fri, 29 Dec 2017 18:32:46 +0800
MIME-Version: 1.0
In-Reply-To: <7adfcf57-b3dd-0e6a-ced0-2767a5462699@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wlGikPWlqK2xhxfbzrPyZridCFruq2lc0"
Subject: Re: [Openvpn-devel] [PATCH] travis: use clang's -fsanitize=address
 to catch more bugs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wlGikPWlqK2xhxfbzrPyZridCFruq2lc0
Content-Type: multipart/mixed; boundary="rNrn7a9BAFLBreuheel1G6U1MFEWDTEqy";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c6a491fe-17d2-445c-e99d-511992c33f38@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] travis: use clang's -fsanitize=address to
 catch more bugs
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <7adfcf57-b3dd-0e6a-ced0-2767a5462699@...1435...>
In-Reply-To: <7adfcf57-b3dd-0e6a-ced0-2767a5462699@...1435...>

--rNrn7a9BAFLBreuheel1G6U1MFEWDTEqy
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/17 18:00, Steffan Karger wrote:
> On 29-12-17 10:47, Steffan Karger wrote:
>> The clang address sanitizer is able to catch quite a number of
>> memory-related bugs, such add memory leaks and buffer under/overruns.
>> So, enable the address sanitizer for one openssl and one mbedtls build.
>>
>> This would have caught the buffer list unittest memory leak that
>> <1512724338-22197-1-git-send-email-steffan@...1856...> wants to fix.
>=20
> For reference, I've pushed this commit to my own gh fork.  This would be
> the result based on current master:
> https://travis-ci.org/syzzer/openvpn/builds/322839893\

your travis build is failing and throwing out quite some "errors".

I personally think we should fix them all before adding the new sanitize
flag, otherwise travis will just always fail until we fix them all.

Cheers,



--=20
Antonio Quartulli


--rNrn7a9BAFLBreuheel1G6U1MFEWDTEqy--

--wlGikPWlqK2xhxfbzrPyZridCFruq2lc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpGGc4ACgkQB6U8WA7y
zXR4VhAAgkBMlYuv+VGR8WFtX2e2PbKnFMmzIGmIbfY392sEuT21YCO+wG7mC3QY
QFy2qKbOXra8FPKA7HRS4ULE3NFn6bppInfoY/9XlRf/hg4WBFfxhj5K8u3YLgbW
dSCnMAjE3SxqBJIRdPQIsw2MOI3UFl03cz6Pn156cUj9knxVvEGUHOD6P3jT4dNv
bxVwH+kf1VPh/cvqbx6o9LbsGKtoNuuXJ5KgQH3ARnC6J9Ta/GJRsxo+zIQxGOF2
y0fj//MM//IS0CUKccF9c4CA0Fc7engZZev/lr8p8os7hwoR2iZe0+bl+6yitwp5
+G+yhwAJFriI2EFUApWU8GVOQ5uG+kNE9ePivtfwQ9hX6dmna1OPIV869wysWsMa
mGjUOWU6S7EEMZt27G0ZQNpoxBeDghcBht9Gw5ILGt28dLemIcRQ1x/RXY2NJx7y
YQRdZrHZ44iJVQi6AwxJun5FxwH40BZf3knDVyzpRN/DYuhIAUsL50sZQajjs9PX
SC9o3+/OsyyY02XjLn9Wy2O6DbNWRn2+d4YPnpLQ/mMWEWW0uUbuMh9IgIP/CxY7
0sAdgzbZyZoDnhmotyASpNYg1wvI2Nc05gSmy17pRY7KdmuUePs6uCuzzX3uto6s
3xcuied77tneYPFoMeeFsAhEDnSpSFlLk2BBpKpeArW1rDr4jZs=
=wx/N
-----END PGP SIGNATURE-----

--wlGikPWlqK2xhxfbzrPyZridCFruq2lc0--

