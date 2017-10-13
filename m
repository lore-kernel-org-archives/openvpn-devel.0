From: Simon Rozman <simon@...2293...>
Date: Fri, 13 Oct 2017 16:57:37 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10858144EF@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10857D3DCD@...2294...>
 <CAFHpkQGZuQUZBqPmsZkBDx1CPiG5KmKKi1Kn_pL9JqwiiQcOaA@...278...>
 <99D61A626FDA8A4B90A270669121BE1085811CC4@...2294...>
 <CAFHpkQF1GuNwEeZ0oCh7RKEzS2oBvO_+oxXvx_oEo-VtjQizqw@...278...>
In-Reply-To: <CAFHpkQF1GuNwEeZ0oCh7RKEzS2oBvO_+oxXvx_oEo-VtjQizqw@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0062_01D34455.22FEF700"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpnserv building under MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0062_01D34455.22FEF700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=
 [mailto:chipitsine@...277...]
> Sent: Friday, October 13, 2017 10:28 AM
> To: Simon Rozman
> Cc: openvpn-devel (openvpn-devel@lists.sourceforge.net)
> Subject: Re: [Openvpn-devel] openvpnserv building under MSVC
>=20
>=20
>=20
> yep, I meant App Veyor for openvpn core itself

I have setup AppVeyor building for core openvpn-msvc now. Please, check out=
 my fork at https://github.com/Amebis/openvpn.

I repeat: this is for openvpnserv only for the time being. I am not confide=
nt, I can revise entire openvpn.exe code to make it MSVC compliant. If only=
 I had more time.

Beast regards,
Simon

------=_NextPart_000_0062_01D34455.22FEF700
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
dTbeJUUAAAAAAAA=

------=_NextPart_000_0062_01D34455.22FEF700--

