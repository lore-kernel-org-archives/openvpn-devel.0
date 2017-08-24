References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
 <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
 <20170824204045.2937b4d6@...1799...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1749ebf9-6823-5420-3bcf-79b72eae2e76@...2181...>
Date: Fri, 25 Aug 2017 02:40:50 +0800
MIME-Version: 1.0
In-Reply-To: <20170824204045.2937b4d6@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="abjIiJ4FiUbD8Rqx2MAiKK9nsBUNpKArG"
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--abjIiJ4FiUbD8Rqx2MAiKK9nsBUNpKArG
Content-Type: multipart/mixed; boundary="VWmQgPp6r3hDMbjKg0pCs1I6eams5UI86";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Christian Hesse <list@...1798...>,
 David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <1749ebf9-6823-5420-3bcf-79b72eae2e76@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
 <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
 <20170824204045.2937b4d6@...1799...>
In-Reply-To: <20170824204045.2937b4d6@...1799...>

--VWmQgPp6r3hDMbjKg0pCs1I6eams5UI86
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 25/08/17 02:40, Christian Hesse wrote:
> David Sommerseth <openvpn@...2080...> on Thu, 2017/08/24 20:16:
>> On 24/08/17 09:57, Antonio Quartulli wrote:
>>> My effort in writing the commit message has been quite poor.
>>>
>>> The assignment is useless because 'ret' is re-assigned a few lines later
>>> without ever being read.=20=20
>>
>> Hmmm.  I'm not convinced of this change.  But I'm also weird in these
>> cases :)
>>
>> I think it is good defensive programming to predefine the state of
>> variables.  When that is not done, it is up the the compiler to decide
>> what to do - which most of the times does a sane job these days.  But
>> you're at the mercy of the compiler.
>>
>> In this case,  I would expect the compiler to optimize this out anyway,
>> regardless of the approaches used.  The compiler doesn't necessarily set
>> the value first to true and then to change it to the output of
>> multi_process_post().  It might just as well postpone the declaration.
>>
>> So I think a better approach would be to completely move the "bool ret"
>> down.  So it will become:
>>
>>    bool ret =3D multi_process_post(m, mi, mpp_flags);
>>
>> Which I think is also closer to what the compiler would end up with anyw=
ay.
>=20
> ISO C90 forbids mixed declarations and code in C. Probably compilers will
> start to complain.

We try to stick to C99. I think it allows such mix, no?

Cheers,


--=20
Antonio Quartulli


--VWmQgPp6r3hDMbjKg0pCs1I6eams5UI86--

--abjIiJ4FiUbD8Rqx2MAiKK9nsBUNpKArG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmfHbIACgkQ0+HICM1s
oFBj1g//fanh27ijaVnM9EV6s7uxiKXBfIK2lFV4QHxSG9wLyk21MbpYdfy+ex3J
nP7scLoqMb7aEcLw/VfTGc+er4q3dyqDkfruT+yNNGsnjTYPr81xWLsw4ftc+quE
F5x6Pa/GQgEPd08OXDDBSzdoPGHxzSL4+WrhYUkbIA9WFyZiXy2RWsix5Vge0mHa
qlw5vsWov7IvMICzPzZCgBLXUUV92x3r/O1ks3wlQVJZzdK9PmDmWx2bjsHlkREg
0tGgsx48pkN1pFdAxf2RRBpkqjUsQfqdkVktr3/dgFtXXG4SRxK8O+FHi88qTDHq
KTBnTEutsoxbqOacSBHz1YptFCsNRX1KYxs/KXszYAtESiTXBOGBpRmGGaF1DYu8
HBGbUrGV7Bjwz2wNECEsJcrK2IYZJoRobNoEJjgdGjs26sIT6TenbrAo9igp4DsG
SNJIRotUtg7sGkkwzGRqaQ98NPbIX2qj26x22Oqmh8oFqD2xnCHwbvn/SUMuWSvd
Uo/6gd/FhBnV+wvuQf0SpXzr4ZU4qN6sUPfODoanVJdhEFVV4W0iIXGdKUazxMTb
139WkEr4EDpiU53PbS6NH9klF52R4p+/ErsWUoSZwdPhj7OgDC80eO7VSBVq5PLH
yGwR764jBNRvGhkdQpo/wod01C7aqxflgL3xr/qhK+5FbS6J93E=
=JBCX
-----END PGP SIGNATURE-----

--abjIiJ4FiUbD8Rqx2MAiKK9nsBUNpKArG--

