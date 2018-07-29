Reply-To: s7r@...2137...
References: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
 <20180727192636.GK55859@...1296...>
From: s7r <s7r@...2137...>
Message-ID: <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
Date: Sun, 29 Jul 2018 04:46:14 +0300
MIME-Version: 1.0
In-Reply-To: <20180727192636.GK55859@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aQHqjnfnFb3ez1LXmqzollI747MuogLgX"
Subject: Re: [Openvpn-devel] Set interface metric instead letting it on auto
 (OS choice) when we have redirect-gateway present to enforce the desired
 effect for IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQHqjnfnFb3ez1LXmqzollI747MuogLgX
Content-Type: multipart/mixed; boundary="V3O3YHJssJCka74RJs1hPqF7XAc3qfDeZ";
 protected-headers="v1"
From: s7r <s7r@...2137...>
Reply-To: s7r@...2137...
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
Subject: Re: [Openvpn-devel] Set interface metric instead letting it on auto
 (OS choice) when we have redirect-gateway present to enforce the desired
 effect for IPv6
References: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
 <20180727192636.GK55859@...1296...>
In-Reply-To: <20180727192636.GK55859@...1296...>

--V3O3YHJssJCka74RJs1hPqF7XAc3qfDeZ
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Gert Doering wrote:
> HI,
>=20
> On Fri, Jul 27, 2018 at 05:57:14PM +0300, s7r wrote:
>> I have run into a problem which raised my attention. I am not sure if I
>> can call this a bug, but I think it's best to discuss here and decide if
>> it should be addressed in OpenVPN or let it as it is at operating system
>> layer.
>=20
> It's always much more interesting if the OS in question is not mentioned =
at
> all... :-)
>=20
> gert
>=20

Hello,

Sorry - I have missed this information because I thought it's irrelevant
and it should apply to _any_ operating system, if it is to be applied at
all. The OS where I experienced the behavior is Windows 10 Enterprise
(64 bit) all up to date with OpenVPN community version 2.4.6-l602, vpn
client running in UDP mode.

Hope this information is sufficient.


--V3O3YHJssJCka74RJs1hPqF7XAc3qfDeZ--

--aQHqjnfnFb3ez1LXmqzollI747MuogLgX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEfDaSMlq9+wswIQPxg3+lLIEmWxEFAltdHGoACgkQg3+lLIEm
WxE+ygf+NEgc31HzLOTRW5toAgEuJfGxFFFZDFq1Snj7PIEsEkhXGd9Mw59a3DCm
IBpjma3szjqZ9RUNfE+K6E4y3G18EBeHsCCO+YR3x/GY+SNShtCF/ByiG4cQ8uWA
KrGbZVHOsuiZ4XhsvZibxt6D4HPnQYyz/i9vi+jI9bhF3Lex2JSHpQfivV79yitj
AE3KLkEw2qvFtfKtRA9Zk/6OqkAM+asumFKSghXVGyxmioZePweros7EHKBIvFxe
643frIZ/2ImkbP57ur9356DM7CoDM82Jpxv1MTmz7Jg4xukpqTSx2L7mu/mA/FfR
W7f/xvHRjqdud5VQtZuC7MJh/YnNvA==
=ifMr
-----END PGP SIGNATURE-----

--aQHqjnfnFb3ez1LXmqzollI747MuogLgX--

