Reply-To: openvpn-devel@lists.sourceforge.net
References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
 <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
 <1509289652.3116.11.camel@...2316...>
 <72a75ffb-67df-0986-7b64-9080254cc084@...2181...>
 <1509292633.3116.16.camel@...2316...>
 <d2079a55-a8c4-95be-4385-75d164a9f8c5@...1856...>
 <20171104175814.GY958@...1296...>
 <CAKuzo_i-CvWA0SFdTLMcN0c6DgV8DMe450NoWMSjf6iapLfcvg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7dc8bad3-eb19-0644-0b24-162cb0d842a1@...2080...>
Date: Wed, 8 Nov 2017 13:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i-CvWA0SFdTLMcN0c6DgV8DMe450NoWMSjf6iapLfcvg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ucn1B2BlXMV9lt8IpWb7JFv5dtajc0S5q"
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ucn1B2BlXMV9lt8IpWb7JFv5dtajc0S5q
Content-Type: multipart/mixed; boundary="dI8jgkPJNrcIXM4asNCJSqJ7NsQsVSj6D";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <7dc8bad3-eb19-0644-0b24-162cb0d842a1@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
 <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
 <1509289652.3116.11.camel@...2316...>
 <72a75ffb-67df-0986-7b64-9080254cc084@...2181...>
 <1509292633.3116.16.camel@...2316...>
 <d2079a55-a8c4-95be-4385-75d164a9f8c5@...1856...>
 <20171104175814.GY958@...1296...>
 <CAKuzo_i-CvWA0SFdTLMcN0c6DgV8DMe450NoWMSjf6iapLfcvg@...278...>
In-Reply-To: <CAKuzo_i-CvWA0SFdTLMcN0c6DgV8DMe450NoWMSjf6iapLfcvg@...278...>

--dI8jgkPJNrcIXM4asNCJSqJ7NsQsVSj6D
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/11/17 20:34, Selva wrote:
>=20
>=20
> On Sat, Nov 4, 2017 at 1:58 PM, Gert Doering <gert@...1296...
> <mailto:gert@...1296...>> wrote:
>=20
>     Hi,
>=20
>     On Wed, Nov 01, 2017 at 07:24:02PM +0100, Steffan Karger wrote:
>     > This looks like it should use our user query wrappers from (e.g.)
>     > console.h.=C2=A0 David, you're the expert here, what should James u=
se to
>     > query for passwords?
>=20
>     The mechanics are "query_user_...()", most conveniently
>=20
>     /**
>     =C2=A0* A plain "make Gert happy" wrapper.=C2=A0 Same arguments as @q=
uery_user_add
>     =C2=A0*/
>     static inline bool
>     query_user_SINGLE(char *prompt, size_t prompt_len,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *=
resp, size_t resp_len,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool e=
cho)
>=20
>     (console.h)
>=20
>     ... most notably this is important because it can use "other mechanis=
ms"
>     if console input is not available, for example, systemd querying.
>=20
>=20
> Shouldn't this =C2=A0happen automatically in this particular case as the
> patch uses
> SSL_CTX_get_default_passwd_cb_userdata() which would result in openssl us=
ing
> to the password callback previously set in ssl_openssl.c ? And that
> callback is
> get_userpass() which should know whether to query the management, console=
 or
> something else.

All the hoops, loops and twists we take to retrieve a simple password
from a user ....

TL;DR: Yes, Selva is correct.
--dI8jgkPJNrcIXM4asNCJSqJ7NsQsVSj6D--

--ucn1B2BlXMV9lt8IpWb7JFv5dtajc0S5q--
