References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
Date: Thu, 8 Feb 2018 11:36:42 +0800
MIME-Version: 1.0
In-Reply-To: <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zTpVxd3TdAJWORIvm3PKZr3XYz76uws58"
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
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zTpVxd3TdAJWORIvm3PKZr3XYz76uws58
Content-Type: multipart/mixed; boundary="gCfmNA9JsbpLtH06jkJwiEk7yir6ii7EO";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net,
 David Sommerseth <openvpn@...2080...>,
 Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)"
 <openvpn-users@lists.sourceforge.net>
Message-ID: <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in openvpn-gui
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
In-Reply-To: <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>

--gCfmNA9JsbpLtH06jkJwiEk7yir6ii7EO
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 08/02/18 04:41, David Sommerseth wrote:
> On 07/02/18 21:21, Selva Nair wrote:
>=20
>> In my view auth-token handling in openvpn.exe is broken at multiple leve=
ls:
>>
>> Client process:
>> (i) it should not remember the token after a reconnect is issued
>=20
> Agreed.  This should trigger retrieving new user input in regards to SIGH=
UP at
> least.  Not sure yet about SIGUSR1 though.  SIGHUP has a cleared semantic
> though (hang-up).

I discussed this Arne as well as he also had users complaining about this.

The conclusion we came was that it may be meaningful, upon reconnection,
to try sending the token once (the token might be handled by external
server side scripts and might still be alive, so one attempt is worth)
and if it fails then we should dump the token, ask the user for the
password and reconnect.


This way we still save all those setups where the token survives fast
reconenctions on the server side

Cheers,


--=20
Antonio Quartulli


--gCfmNA9JsbpLtH06jkJwiEk7yir6ii7EO--

--zTpVxd3TdAJWORIvm3PKZr3XYz76uws58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlp7xcoACgkQB6U8WA7y
zXROLA//c3tofMKgJ4DGsXKndf4c+qDwlC4sDcigVSiHFA+s0CbHrnKc0pI0MfGH
sBeV+dKeQT79ROwv8AxbaUI/2jPChmvgVLqnQ29ld2lVCjQJz18jemKIfGjRgHwK
5/8v+HLgJFT7fVTsKekPb1KOwXjrmMeCbZX5Rezlw6SlL6oxCKPq2sQI4nj7OsnY
TSxWTzVR7BujAoieZTQmMERAKukNPd35ZFeVUeu1KiV+YVMQcLc6JAoUgDI8gCod
cvB+L0l98nPpv9sORfn+j8d2UE99Zgwy8ealXbu3XavlaTgcCMmdhRUA1EMIXzb9
TY6f+DhPxkLAEZky47PM/DDRL4JQlH1IdvFS8nyJgVklrLlC79xsOn0imU5R2YIu
K+VumB0F6CkQjjn7ty/6jitP+IEoA7MM4rSMWuVcxLqRaJ3wFghkDBe+G5R5Ydge
Ja5CO1mEjCK6/5BX8V0IukN4xr2WeD5XTd7+eSk50hlW9fpiLzkrElY2UJNKQWY6
wtTRT4DTWDnodc+BuoEJfnIAyH/Kr6HS2qIUsMASgz0KIuSlvUDVjzTTWUpHUI4R
56/dqZG2062yvC4Yt10++XETKflOjatpV8VmGcnL2RXDcg5+HY83obogt4tFA91q
bHfIRH22GpXd4ITTZvVRsBbMnA4bpaeZMAJJMFZc6zhjwULiok0=
=nxtY
-----END PGP SIGNATURE-----

--zTpVxd3TdAJWORIvm3PKZr3XYz76uws58--

