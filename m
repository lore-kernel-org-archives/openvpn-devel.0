References: <7ff426e2-a389-c8e4-245e-a36328f5bf2e@...277...>
	<1bd76716-c49f-0346-c1d2-f88feaba890e@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <90dfe997-a962-3cda-1bfb-42c8157bc0ae@...2080...>
Date: Tue, 28 Mar 2017 21:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <1bd76716-c49f-0346-c1d2-f88feaba890e@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u6UmPSm8BwfXP3c1epidOR7QD4O4RlMqu"
Subject: Re: [Openvpn-devel] Wik page drafti: DeprecationWarnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u6UmPSm8BwfXP3c1epidOR7QD4O4RlMqu
Content-Type: multipart/mixed; boundary="9PH3SBhUCDX8NsRWq4R9JIJ1xrkpttfxq";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <90dfe997-a962-3cda-1bfb-42c8157bc0ae@...2080...>
Subject: Re: [Openvpn-devel] Wik page drafti: DeprecationWarnings
References: <7ff426e2-a389-c8e4-245e-a36328f5bf2e@...277...>
	<1bd76716-c49f-0346-c1d2-f88feaba890e@...277...>
In-Reply-To: <1bd76716-c49f-0346-c1d2-f88feaba890e@...277...>

--9PH3SBhUCDX8NsRWq4R9JIJ1xrkpttfxq
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/03/17 21:24, debbie10t wrote:
>=20
>=20
> On 28/03/17 19:18, debbie10t wrote:
>> Hi,
>>
>> Following on from:
>> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1433=
0.html
>>
>>
>> For your consideration:
>> https://community.openvpn.net/openvpn/wiki/DeprecationWarnings
>>
>> I do understand why duplicating work is not preferred, which is
>> why the page is for priority Warnings .. it could also be that
>> --ns-cert-type is going to be the only deprecation which qualifies
>> for such a warning, so the page could be recreated for --ns-cert-type
>> specifically.
>>
>> The page could also serve as a perma-link for log warnings.
>=20
> Here is a further example of what I am thinking:
> https://community.openvpn.net/openvpn/wiki/DeprecationWarnings#warnnsct

Thanks, debbie10t!  This is a very good starting point.

I am just wondering if we should have some kind of "standard table"
within each of these warning blocks which contains a consistent overview
of "what and when".  I don't have a good suggesting right now but
something like:

    | Feature                 | Deprecated    |  Removed  |
    +-------------------------+---------------+-----------+
    | option: --ns-cert-type  | v2.4.1        | TBD       |
    +-------------------------+---------------+-----------+

And then below such a table, the rationale for removing it, pointers to
more information and other types of important notes related to this.
The "Deprecated" and "Removed" columns could also point at the git
commit containing the deprecation/removal.


Of course, this wiki-page will require some maintenance ... and I hope
this maintenance load will not just be dumped only to us core developers.


--
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--9PH3SBhUCDX8NsRWq4R9JIJ1xrkpttfxq--

--u6UmPSm8BwfXP3c1epidOR7QD4O4RlMqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY2r9PAAoJEIbPlEyWcf3yp2cP/0gAlB6WpUfUu+WfFXpT5xMx
HaTks+uOYuCVxJfYk4xXOBdFhocNhyYiSGWeh9amgsvZiwRLnJ7WMY+LVfw5nwiN
K+CbY0MtiNto8DR1I3A7rfEhlJTm4rNpQe/TkPdac2ymzhNSaRQjqcCAvtB+POoY
+fNRfOtbLR9UhyDUtR3LoKCMX8n90WLfEb2Nqy1sWpWug39l+81XYz/D/QBHAg83
5XH6t1OgEYeMtf7cKvGqqzJ5GC2uXcyuhr9ezMlL3cjtvppGwSGS2OT0R02J8l9v
2jbDQtHEdAl30IBt9QkEPfVGzf142oyt0rfYlTGzc5ItN79EPkEnPbGzAgeX5iyP
eGD53b+J7Druodj8XJ0cE0qTvnls9QJyK3IfGn1Yc9GDKG8Ipp0nNSEvvnVzdv2O
8nkqg7/P7YuZBLLFMhWKyhW4hBZ1lTgc45F7ZdFouu28Onqzi50dbsReYd3e9L22
EwccREYlbkna2m21z1/NPrIjlKRqbyyexC6Sl6a+zQEgpsPcaS0+uRKhX/KjJf4w
pA1drwYamnT5TuAkn55IhHRFdwgN3Cr83nNnPoi3YgVvtLQqw2GFZW6QfC02kRtL
OJnfR+oJKVPA47+tsLufq0X47Z+NYDgOQPfE8q4AWp0cWdvnI2dW5GEzNhvftCzn
4BmlMYmK0gqOBc+/pZii
=vun6
-----END PGP SIGNATURE-----

--u6UmPSm8BwfXP3c1epidOR7QD4O4RlMqu--

