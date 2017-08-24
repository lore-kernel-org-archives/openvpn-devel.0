Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
 <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
 <20170824204045.2937b4d6@...1799...>
 <1749ebf9-6823-5420-3bcf-79b72eae2e76@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4f5262ab-4a6e-83e1-2950-35db895ddf22@...2080...>
Date: Thu, 24 Aug 2017 20:51:52 +0200
MIME-Version: 1.0
In-Reply-To: <1749ebf9-6823-5420-3bcf-79b72eae2e76@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xqdjpAF87Nc8O3u6rEx5qIuGO5mrXq97E"
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xqdjpAF87Nc8O3u6rEx5qIuGO5mrXq97E
Content-Type: multipart/mixed; boundary="lUsIHbqR7vg8OM9S4bVHwwXKCerMGHTfF";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <4f5262ab-4a6e-83e1-2950-35db895ddf22@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
 <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
 <20170824204045.2937b4d6@...1799...>
 <1749ebf9-6823-5420-3bcf-79b72eae2e76@...2181...>
In-Reply-To: <1749ebf9-6823-5420-3bcf-79b72eae2e76@...2181...>

--lUsIHbqR7vg8OM9S4bVHwwXKCerMGHTfF
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 24/08/17 20:40, Antonio Quartulli wrote:
>=20
>=20
> On 25/08/17 02:40, Christian Hesse wrote:
>> David Sommerseth <openvpn@...2080...> on Thu, 2017/08/24 20:16:
>>> On 24/08/17 09:57, Antonio Quartulli wrote:
>>>> My effort in writing the commit message has been quite poor.
>>>>
>>>> The assignment is useless because 'ret' is re-assigned a few lines lat=
er
>>>> without ever being read.=20=20
>>>
>>> Hmmm.  I'm not convinced of this change.  But I'm also weird in these
>>> cases :)
>>>
>>> I think it is good defensive programming to predefine the state of
>>> variables.  When that is not done, it is up the the compiler to decide
>>> what to do - which most of the times does a sane job these days.  But
>>> you're at the mercy of the compiler.
>>>
>>> In this case,  I would expect the compiler to optimize this out anyway,
>>> regardless of the approaches used.  The compiler doesn't necessarily set
>>> the value first to true and then to change it to the output of
>>> multi_process_post().  It might just as well postpone the declaration.
>>>
>>> So I think a better approach would be to completely move the "bool ret"
>>> down.  So it will become:
>>>
>>>    bool ret =3D multi_process_post(m, mi, mpp_flags);
>>>
>>> Which I think is also closer to what the compiler would end up with any=
way.
>>
>> ISO C90 forbids mixed declarations and code in C. Probably compilers will
>> start to complain.
>=20
> We try to stick to C99. I think it allows such mix, no?

That is correct.  We set -std=3Dc99 unless CFLAGS already contains -std=3D.
But we expect OpenVPN to be C99 compliant.

And C99 allows this.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--lUsIHbqR7vg8OM9S4bVHwwXKCerMGHTfF--

--xqdjpAF87Nc8O3u6rEx5qIuGO5mrXq97E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZnyBIAAoJEIbPlEyWcf3yP1UP/022UL1iRfwYSz1TrXmpxnTR
zvA7/FWwaanW8IqLrTHz3BZb5NO0L9jNcZfdE01pd+Xo0Y0BcRRs9m4eMn8auTGo
i2Vuj1siqym3R0em5CwyItk2BUqJBM7QZQ0J8hzxrkMpPIUw3ide0wcbF1+fVD4s
AZ9hDFudwEIpVhwqG0lp/XiARyO6g5otCcMitRedWQcmh4mV/Km1D74rVfPNk7IE
C3JXlxX10S54iM6eIlrATr1AdF+ajvVsdRyCd0ygjKXhnlPL1Ctqr/Lr3dFwwHJ9
dy5vuHKgzhNqlM844MZ05zKgwZMle4kXtJsscvFwZymEklbHAvpO5ctJMkkVUFQd
ldaG4lOTQABSgn1758LlRdTFnzoHYGd3XjulZI3mHhoJYDe52Ph/2RKfF3pExA4e
wzEhpkWRQL6djcrdY6OujBaraYmzc5YWEVIoAZwQ4o1tn1h6AhTq0z2TI75pmRjX
Y6uUEk6BmYojAZe5Inu9eEjWxSgwNOBrSB6GTuVxGtptbOITO7XOONPo1Pa+axax
rXFlDvd0sbyvmQfkc5K3eufgnOwgWo5Q6NOjaaiGAGOI9BMWy9KDuqR3Q9ucmyom
yJQ6zOgpWIX/cRrgVdr0YaPSO9+jOJqqzOQDnFIwK0Cm9AWdAZcWow+yA9OJ6oy0
Ny5wBzZQ2k50/565pwJw
=I6/a
-----END PGP SIGNATURE-----

--xqdjpAF87Nc8O3u6rEx5qIuGO5mrXq97E--

