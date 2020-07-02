References: <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <885f8b43-cd49-a88e-4a69-4913c0636e56@...2080...>
Date: Thu, 2 Jul 2020 23:04:41 +0200
MIME-Version: 1.0
In-Reply-To: <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cxCNmYFfZTARuGvmxTOcjyfKZsgj4uGDK"
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cxCNmYFfZTARuGvmxTOcjyfKZsgj4uGDK
Content-Type: multipart/mixed; boundary="NL3wpE95kJIvndQ4TMSJcpUiaAJCoXXAf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <885f8b43-cd49-a88e-4a69-4913c0636e56@...2080...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
References: <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
In-Reply-To: <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>

--NL3wpE95kJIvndQ4TMSJcpUiaAJCoXXAf
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 30/06/2020 16:15, Jan Just Keijser wrote:
> hi,
>=20
> On 30/06/20 16:11, Gert Doering wrote:
>> Hi,
>>
>> On Tue, Jun 30, 2020 at 04:07:52PM +0200, Jan Just Keijser wrote:
>>> @@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, co=
nst struct tuntap_options *o)
>>>      write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &err=
or);
>>>      write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &e=
rror);
>>>=20=20
>>> +    for (int i=3D0; i < o->domain_search_list_len; i++)
>>> +    {
>>> +        write_dhcp_search_str(buf, 119, o->domain_search_list[i], &err=
or);
>>> +    }
>> I assume that this won't work.  In the DHCP answer, it must be a single=
=20
>> option with the concatenated list, not multiple answers with a single=20
>> domain name each.
>>
>> gert
>>
> see https://tools.ietf.org/html/rfc3397
>=20
> "
>=20
>    In the above diagram, Searchstring is a string specifying the
>    searchlist.  If the length of the searchlist exceeds the maximum
>    permissible within a single option (255 octets), then multiple
>    options MAY be used, as described in "Encoding Long Options in the
>    Dynamic Host Configuration Protocol (DHCPv4)" [RFC3396 <https://tools.=
ietf.org/html/rfc3396>].
>=20
> "
>=20
>=20
> so you MAY use this option multiple times - and wireshark groks it fine. =
I don't have a Windows 10=20
> client to test it against, however, so I am hoping that someone (Selva?) =
can do that for me.
>=20

Hi,

Can we please see this discussion also in context of this mail thread, which
tries to look a broader at this challenge?

Message-Id: <c4628c37-0c3b-a402-ee9d-68ee7062e1f3@...2080...>
URL:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20101.=
html>

One change in that RFC since last time is that we will move IV_PROTO to be
only about the OpenVPN wire protocol (features/settings only affecting
protocol for the communication between the OpenVPN end-points themselves).
The DNS settings and more related to host configuration and similar will be
moved into an IV_FEAT field.  Except of that, nothing else has changed from
the initial mail.

The main purpose of that RFC is to ensure we handle DNS and --dhcp-options
consistently across all OpenVPN implementations we care about, and that we
document this properly.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--NL3wpE95kJIvndQ4TMSJcpUiaAJCoXXAf--

--cxCNmYFfZTARuGvmxTOcjyfKZsgj4uGDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe/kvuAAoJEIbPlEyWcf3ys50QAKD21JXVRHbR1TviX4mQwyKU
xAWA+h+OcDa3l6g5nQ4E1Pyot1m0mPEUOXxZ+HVXEtbC/lQHX1eSlyrsXd5j+/5h
Jq4EGYPVReWUaG9VJMVf8Johqx+aBZcTAjFHEHg3/uQSFFLxi5EFHQlPE2ixAcMr
IXxgLd4SaS42b/GDWj0LWJ4GhcX+UGgySbJOCtaKSqlq+feCBwrHjOZ+RKm2PTh1
k/oxf7Xmlhhed6aoWHiDRzCmWa8bxGhOV8O7iEb640XSGWUYzaSxlgN1k+Ckg+5l
e0yPHiUpLfkwH5bq6pRwLeQgyBjWOk7DoZwlAYbIkHiL9MVwqnEvHiISIgLKgx0n
tnT+OPUB9YIkSJx9cgd6AhRKb5v3oAEwVu7Zom2VGESi5EQ5ZbEvz0JWWnxzzQry
627Xb9PI6zteL+5gkt6ptZnLL2fvOml5R+Cbup3gk4Ef0nukN4n6W/9zccHMXJ8m
E1cHB+W58sxMLS1/P8+MINh/vOfZecwEU7ycnpCCvEl8o8+34LGohsbKcGe+LPE+
pw/ec5xaX0i1ke/eEq9nkiupvLpKRbPqZ1JrjGR+Xz8EqGicQ1XJTuqCtmDpg2Y1
C4ZzCjQHl4HEI1cK9Un9Oi6GnW210V1NFowg3I9fjnCrWMVS2xQrDfZETzhEYX/I
Buo1zCfuHrilvoNDcmcR
=CYRG
-----END PGP SIGNATURE-----

--cxCNmYFfZTARuGvmxTOcjyfKZsgj4uGDK--

