References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
Date: Fri, 9 Dec 2016 00:14:49 +0100
MIME-Version: 1.0
In-Reply-To: <943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="gQLM3TDxtwGfXNNsjKgHVIS5Q5J5QgqN8"
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gQLM3TDxtwGfXNNsjKgHVIS5Q5J5QgqN8
Content-Type: multipart/mixed; boundary="PPKValfKCHaDbTBSaFs57VdDiaoKAKFcv";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
In-Reply-To: <943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>

--PPKValfKCHaDbTBSaFs57VdDiaoKAKFcv
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 08/12/16 23:45, David Sommerseth wrote:
> On 08/12/16 22:56, Selva Nair wrote:
>> Hi,
>>
>> On Thu, Dec 8, 2016 at 4:15 PM, David Sommerseth
>> <openvpn@...2080...
>> <mailto:openvpn@...2080...>> wrote:
>>
>>
>>     This is fairly inline with the initial agreement from the 2014 Munich
>>     hackathon [3] and the summarized CodeStyle wiki page [4].
>>
>>     This proposal allows for the "open bracing" question, which allows
>>     '} else {'  and '} else if () {'.
>>
>>
>>     So now the bike shed debate opens up ... Is this something we can get
>>     consensus around?
>>
>>     And a few examples of reformatted files:
>>
>>      tun.c: <https://paste.fedoraproject.org/501999/81229253/
>>     <https://paste.fedoraproject.org/501999/81229253/>>
>>      ssl.c: <https://paste.fedoraproject.org/502010/22971814/
>>     <https://paste.fedoraproject.org/502010/22971814/>>
>>
>>
>> Looks excellent.
>>
>> Yes, responding to the call for bikeshedding , some questions/comments:
>>
>> Reformatted tun.c has at least two instances of char* xxx, we want char
>> *xxx, right? So why not add some sp_xxx_ptr_star options.
>=20
> Good catch!  tun.c and ssl.c are the biggest files we have ... so there
> might be some details we've not spotted.  Uncrustify doesn't change
> things we don't tell it to change, so we just haven't spotted this.
>=20
> I agree, we should change to this.
>=20
>> Less of a concern at least for me is function_name (...) and
>> function_name(...) both appears to be allowed. Just because we can do
>> it, why not add some sp_func_xxxx_paren options to normalize those..
>=20
> I agree to consistency.  And Steffan already suggested what I was about
> to suggest.  I'll send an updated config file soonish too.

Steffan was more clever and updated the wiki page.

I just spotted in ssl.c that we need sp_assign=3Dadd.

[ ssl.c, tls1_PRF() ]
    len =3D slen/2;
    S1 =3D sec;
    S2 =3D &(sec[len]);
    len +=3D (slen&1); /* add for odd, make longer */

I believe we've agreed on spaces around assignments.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--PPKValfKCHaDbTBSaFs57VdDiaoKAKFcv--

--gQLM3TDxtwGfXNNsjKgHVIS5Q5J5QgqN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSelpAAoJEIbPlEyWcf3yISUP/AtFoW1ceUmlQ9rAIlL3UktX
UOrWO5gw8m/tW09FYdDUepbbzx9Dwo54sEAYLbvSuejWtQy5rbdDOGmbh+W+CLW4
LRkqqYvBFGn++J73Q/paceAZCvlCy5FfffViPXY6IMMWK9qrNkuMPyNhjWCK8XhR
p2tAAmwXES5/bFI7tlZ0jn7g/g/AiXEPXLEtI3550IHSvoJj5AQmIz+SAnzKIRI0
nHnfAOcPwgBbDVTVUYjNmubXtyyQbmr3UgbEfCnulD7XtoK8k74DLYT08QDz8vQ6
I+4XiUhlEp+GdyBJcMtKbVygtVsFrNzI7rbuy01B0/UUr3hZ26dBHKsJM2GVRZBP
m3G5ljT4t4IAm6X6xcLXu0al3G+PRD2wXfddUKxAEs8bAzPoI6TFaW6LtNQsa4Cm
LXiBBtfamPGfNOkM6R1M2tJ2Eoja7hyUMvvuC0SvnYI1Nf2ux5RVSYTXgsaum7je
tQaA8A0R2dAAWVfhwimnLTF1Ze8pF5hGl6yLN4fTcRsKSoJLWWDbE6B2/RgfLhYP
8T4G8FA/gVDR1xdzHe9TLj5lro8Jt5eNPvSjVdp0UOjXlbT34N27ZlaJ+vH7rDZO
Y7EvqkjpzsFTakPaDL8Qxf589dbou3jNJUph4hWJvqAfWSPIWt5JNKs0XpsKQgIo
XVTvMs84dn7QmD9uodaO
=vTou
-----END PGP SIGNATURE-----

--gQLM3TDxtwGfXNNsjKgHVIS5Q5J5QgqN8--

