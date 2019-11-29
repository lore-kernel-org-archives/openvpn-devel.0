References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
 <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
 <20191129105207.GU40538@...1296...>
 <f9930229-0e7c-a03d-3050-dae11e59b2c6@...2080...>
 <20191129113740.GV40538@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <28596834-0999-e5f3-e4c3-272feb0b88e6@...2080...>
Date: Fri, 29 Nov 2019 13:22:26 +0100
MIME-Version: 1.0
In-Reply-To: <20191129113740.GV40538@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="D66yGGaEch1PxkRdgqoIOt9JBRgWxsk9u"
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D66yGGaEch1PxkRdgqoIOt9JBRgWxsk9u
Content-Type: multipart/mixed; boundary="oI4V1hji6TpzD4XQ3wpRWRD2kyJU7RF5y";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <28596834-0999-e5f3-e4c3-272feb0b88e6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
 <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
 <20191129105207.GU40538@...1296...>
 <f9930229-0e7c-a03d-3050-dae11e59b2c6@...2080...>
 <20191129113740.GV40538@...1296...>
In-Reply-To: <20191129113740.GV40538@...1296...>

--oI4V1hji6TpzD4XQ3wpRWRD2kyJU7RF5y
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/11/2019 12:37, Gert Doering wrote:
> Hi,
>=20
> On Fri, Nov 29, 2019 at 12:25:13PM +0100, David Sommerseth wrote:
>> On 29/11/2019 11:52, Gert Doering wrote:
>>> On Fri, Nov 29, 2019 at 11:47:02AM +0100, David Sommerseth wrote:
>>>> With GCC-4.3.8, I see this warning:
>>>
>>> This is about as old as you :-) - do we care about suppressing warnings
>>> in old gcc versions that might suppress a *relevant* warning when
>>> compiling with a current gcc version?
>>
>> This is the default compiler on stock RHEL-7 ... which goes EOL August 2=
024.
>=20
> We're not going to break it.
>=20
> I'm just not going to care very much about the warnings it might throw
> (and I might object to any patches that are "just for the benefit of
> suppressing warnings from gcc-4").

Fair enough.  But that will actually restrain us from adding -Werror by
default for some time forward, unless we want to make package maintenance a
bit more tricky - needing to revert a -Werror chage or add
-Wno-missing-braces.  If we have status quo for the moment, I can live with
that until RHEL-7 is EOL.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--oI4V1hji6TpzD4XQ3wpRWRD2kyJU7RF5y--

--D66yGGaEch1PxkRdgqoIOt9JBRgWxsk9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJd4Q2CAAoJEIbPlEyWcf3yMv4QAI2XcoZrPmWO3vPgopy8apyT
Fy+Q26AEntuZWILkqLnRZn72HMk87fudh3v19xCiX2O8Vi/SVcoANt0GIXdsQUlc
FfVbAGPqdFItvuOoDTZ/r3gRVL9nA9U0e0nvW4ijDvRoZkB7osG8q+cjUR3ZGtJu
mJKnq9Qe8qPt4g11ImF5xnx94ODdFGYbRN+Odum4MKajgIe/JRESUeo3H+nH8JxJ
MEomVzgJ44fopc7T1a/0/mJj2hdGsYwl8JTlZdlhX11T9R9GiwpWMzHwuLVzLTsI
IlLpYurXwVKnIpqCJByw8GAowX4aqnW+r3K9vduwBYKxmnvpkLdzxlnmeMF0IMHP
U7PTwmfi7EcYxApxxwsLDFPC46sw6IZnP97mGNAy/QA7/iF2xFTa1Igpxpoe/94G
mRkKiMVrfcvgVbyH6cs0JMqUB7DX7KAvVsRPS0j258s3/EsIcPx2N+0ehsogJNfq
hw363OK7MI7LOTeQTQWagz6fV5sTI1LRyqPCHVwP9wx8n2ImZrosJ4oAIq/3tYLf
v8bOMbABaXajO+/Y5pcBcskrojiCkfyVpsCr+rKbAvcDpKu2VeqMp9jBjoSsHVmz
mBfHF1Ng/Blzx3H5oUb3hcWV7N4ClPDPIu7DHl/Rv9437VVeti/Vxmbvnqi0kg73
9NsdkDrD/sfCAJ2Tu191
=gESa
-----END PGP SIGNATURE-----

--D66yGGaEch1PxkRdgqoIOt9JBRgWxsk9u--

