Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
 <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3bb917b3-3ed2-8097-49ff-1aebca097561@...2080...>
Date: Thu, 8 Feb 2018 13:20:13 +0100
MIME-Version: 1.0
In-Reply-To: <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zbhO7PdyHPZQ9R2ipNS5orWhgPFQxzkRI"
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net, Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zbhO7PdyHPZQ9R2ipNS5orWhgPFQxzkRI
Content-Type: multipart/mixed; boundary="DEqasLhdRKf6KvNZJKlGHVYNrvwisHPim";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net,
 Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)"
 <openvpn-users@lists.sourceforge.net>
Message-ID: <3bb917b3-3ed2-8097-49ff-1aebca097561@...2080...>
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in openvpn-gui
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
 <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
In-Reply-To: <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>

--DEqasLhdRKf6KvNZJKlGHVYNrvwisHPim
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/02/18 04:36, Antonio Quartulli wrote:
>=20
>=20
> On 08/02/18 04:41, David Sommerseth wrote:
>> On 07/02/18 21:21, Selva Nair wrote:
>>
>>> In my view auth-token handling in openvpn.exe is broken at multiple lev=
els:
>>>
>>> Client process:
>>> (i) it should not remember the token after a reconnect is issued
>>
>> Agreed.  This should trigger retrieving new user input in regards to SIG=
HUP at
>> least.  Not sure yet about SIGUSR1 though.  SIGHUP has a cleared semantic
>> though (hang-up).
>=20
> I discussed this Arne as well as he also had users complaining about this.
>=20
> The conclusion we came was that it may be meaningful, upon reconnection,
> to try sending the token once (the token might be handled by external
> server side scripts and might still be alive, so one attempt is worth)
> and if it fails then we should dump the token, ask the user for the
> password and reconnect.
>=20
>=20
> This way we still save all those setups where the token survives fast
> reconenctions on the server side

This sounds reasonable to me.  But it is crucial that it is a proper
re-connect - meaning, if UDP the "--explicit-exit-notify" message must be s=
ent
to the server to close the session on the server side.  Otherwise you'll get
into some odd back-and-forth until the session is fully closed on the serve=
r.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--DEqasLhdRKf6KvNZJKlGHVYNrvwisHPim--

--zbhO7PdyHPZQ9R2ipNS5orWhgPFQxzkRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJafEB+AAoJEIbPlEyWcf3y3GwP/0Vc8p/Hy3Z4GMnMoP4f85KA
2cItIpmSvA6QD+PS+QaZykZ1bg9p3oGOvPUftDJeNiG3jynygZv96nMj4Tr02nTS
LULCl/oyLfq231ve69/orgdPD7HUD99eRsJAMY2MMXU3AAuCV4B7RfPBpo3juwl/
lX+hD92iulg+DHK8cIkH7lurV3HHCzpRtGS6FJVg+gcRqCV1pVtZTL/ikn98f9fI
UZ5iE2tO1vedydDAkdvFe1MJqUNB8SaDFv+B8K8ArFqgCh8kuYmNAwDtcQsqbDRd
3zjuNpiM9Qu3lrU2hog0RqoQe/MbNC/7VtO7c71NVhh074j6boMlS6ogwteF1zNM
KfUFgIP0cATRcy5IrrdxOx2SYE/eDmuhQn3/fOLxb00hRtDg3v3QNpR9iDCd4hPS
ehn+SOeLpYsl5WNbBpYHNGbiPxLbzzgCr+OqZkIoO/YZ+0auBjqyuM2L3LqNxtr9
Qp7dhK3e3xV3GAxImaFSnJE/rbEL5o2QgFxD3Y8J9iE4H1INCC1JC5eVZLGKHwWr
kflOe6R0Xc3yesTVmRfMwCA26zmxMMLt7fLRRo1q5tFYPJlzl9+x7PuBCI/ZxeJG
3M9WPF1mbi7IUHSvfX5QgKGaEydIWJoFOQq/uQNUmVpYLEvpEPx7bToDiNCxQMwr
TK1+nan77VsnYuiEpgn5
=HU2u
-----END PGP SIGNATURE-----

--zbhO7PdyHPZQ9R2ipNS5orWhgPFQxzkRI--

