References: <1481728374-7196-1-git-send-email-davids@...515...>
	<6083f8ec-b180-5cc3-b776-dd7e1e14d94a@...1856...>
	<20161215100509.GM78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <97b1b2d8-b8f4-a7a3-aec2-fd72793f3937@...2080...>
Date: Thu, 15 Dec 2016 12:07:49 +0100
MIME-Version: 1.0
In-Reply-To: <20161215100509.GM78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="gluln4Oa0RrtxqvKrEFWXavbRoVLUvxlx"
Subject: Re: [Openvpn-devel] [PATCH] auth-gen-token: Hardening memory
 cleanup on auth-token failuers
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gluln4Oa0RrtxqvKrEFWXavbRoVLUvxlx
Content-Type: multipart/mixed; boundary="JeIkXmRnCsXiiiFxQcf98McdpLtapENhp";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <97b1b2d8-b8f4-a7a3-aec2-fd72793f3937@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] auth-gen-token: Hardening memory cleanup
	on auth-token failuers
References: <1481728374-7196-1-git-send-email-davids@...515...>
	<6083f8ec-b180-5cc3-b776-dd7e1e14d94a@...1856...>
	<20161215100509.GM78624@...1296...>
In-Reply-To: <20161215100509.GM78624@...1296...>

--JeIkXmRnCsXiiiFxQcf98McdpLtapENhp
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/12/16 11:05, Gert Doering wrote:
> Hi,
>=20
> On Wed, Dec 14, 2016 at 10:08:25PM +0100, Steffan Karger wrote:
>> Looks good, but I think there's one more occurance you should
>> incorporate in the patch:
>>
>>   if (openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
>>                             &multi->auth_token) < AUTH_TOKEN_SIZE)
>=20
> Under which conditions can this ever fail?  In other words: if this
> fails, should we consider it a major programming error and ASSERT()?

It can only fail if there's a malloc() failure in
openvpn_base64_encode().  But I agree, ASSERT() is probably more
reasonable here.

I'll send a v2 patch with assert here instead.

Side track .... the malloc() size calculation in base64.c:66 is, well,
interesting:

       p =3D s =3D (char *) malloc(size * 4 / 3 + 4);



--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--JeIkXmRnCsXiiiFxQcf98McdpLtapENhp--

--gluln4Oa0RrtxqvKrEFWXavbRoVLUvxlx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUnmLAAoJEIbPlEyWcf3yiQ0QALAK9T2Xf2wwrAJlq6BMGByM
Ik5sMy1ha5UQvR/5BY9lxygdJF8/Ooj46OwLY1v5Zi9C8jsLRxrshJodMrjbdY2I
5a1cVHzxOk+wbXtU7a+N1RrgUY+fRqlZZxF31P83ytDoiUrDMhP/yqEEAlmQD4oh
7We+1Crn7+BDALW5BB7E9J4nWc0vsNdIPLotUoha+43L11ym7Xl4lPNnOvhbaFaj
Xa0+XeKWOciCK9/SOsqeO5rl79yB4OWcRD6HF5wARX1i/wkBLAykhEVOhE+61unG
nxzocs+USIuLij2FUivqkS6pqHUigXsmGWcySRds9P36gtPjztmkd0SVkOF9JNd7
ulObIN0S93d7WdtCdTGs0Py6oM7Kr3Gd2vHHzT+BQAhe3s6xfugs5RftbSAq4ZfJ
xBa8xFKigyyOwIA6LRDc4AQ4snMXhJVO+441oTCTwB852YY3a/CmPCNrfi8w5980
HLMrfArcgijV/pW9l7ZBFUNDjuEPSnq7l00wu52qnuvQc7SLooP9Xq2La5XrAMfS
yCU5s+0ajDBY4Jxznr1pLA/AS1ClUGkSyTXX+l3aI8ZOzwKiLc5jhos9/HkQ6IAN
M6sfEpyNvr5ArDG3Umu/lpaYiQbNDRsGfb4OKdYkDOgCyOIsOcJNLxiwCPliOLjL
DPymsmoUESThjoH1W81F
=Qecd
-----END PGP SIGNATURE-----

--gluln4Oa0RrtxqvKrEFWXavbRoVLUvxlx--

