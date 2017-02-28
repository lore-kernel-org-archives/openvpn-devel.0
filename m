References: <003bd3ed-9a64-3e77-cd06-2212b82a6165@...515...>
	<6a8f8780-a49c-9d1f-30ac-d3b804e9476b@...1435...>
	<5cab0f4b-c40e-c11d-25e7-dc276d18317c@...515...>
	<d86d9946-dfa1-785b-5fe5-fe44acadda18@...1435...>
	<e0a6e693-96ee-3c3d-f17f-d62c45676b5a@...515...>
	<4cfe9376-5bc1-51da-4082-9837b232a40f@...1856...>
	<1c3fb5b3-39c8-1c4b-c531-9cb2480a2382@...515...>
	<13666431-ed44-1ac1-2fef-fe295b33cc97@...1856...>
	<419e734c-8879-8bdd-e6cf-94dd16de86cc@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7fe7759e-88b6-4b9f-9026-c76323fe72d9@...2080...>
Date: Tue, 28 Feb 2017 02:18:00 +0100
MIME-Version: 1.0
In-Reply-To: <419e734c-8879-8bdd-e6cf-94dd16de86cc@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E6wpmgqO7CqqA6sXP0R1GXoHo667lsRCK"
Subject: Re: [Openvpn-devel] Should we use mbedTLS certificate profiles?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E6wpmgqO7CqqA6sXP0R1GXoHo667lsRCK
Content-Type: multipart/mixed; boundary="HnUAm2JT07g60JBEdAtPblQVhMEDI6Kau";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net
Message-ID: <7fe7759e-88b6-4b9f-9026-c76323fe72d9@...2080...>
Subject: Re: [Openvpn-devel] Should we use mbedTLS certificate profiles?
References: <003bd3ed-9a64-3e77-cd06-2212b82a6165@...515...>
	<6a8f8780-a49c-9d1f-30ac-d3b804e9476b@...1435...>
	<5cab0f4b-c40e-c11d-25e7-dc276d18317c@...515...>
	<d86d9946-dfa1-785b-5fe5-fe44acadda18@...1435...>
	<e0a6e693-96ee-3c3d-f17f-d62c45676b5a@...515...>
	<4cfe9376-5bc1-51da-4082-9837b232a40f@...1856...>
	<1c3fb5b3-39c8-1c4b-c531-9cb2480a2382@...515...>
	<13666431-ed44-1ac1-2fef-fe295b33cc97@...1856...>
	<419e734c-8879-8bdd-e6cf-94dd16de86cc@...515...>
In-Reply-To: <419e734c-8879-8bdd-e6cf-94dd16de86cc@...515...>

--HnUAm2JT07g60JBEdAtPblQVhMEDI6Kau
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 27/02/17 23:06, James Yonan wrote:
> On 25/02/2017 08:40, Steffan Karger wrote:
[...snip...]
>> I'd say so.  Something like:
>>
>> legacy: RSA 1024+, SHA1+, all curves
>> default: RSA 2048+, SHA2+, all curves
>> suiteb: no RSA, SHA256/SHA384, P-256/P-384
>>
>> As long as we kick anything that's deprecated out of 'default', that
>> should probably suffice.
>=20
> That sounds good, but I'm thinking that we should probably name=20
> "default" something else, such as "standard", so there's no confusion=20
> between the cert profile name, and which cert profile is chosen by=20
> default which may vary according to app preferences/settings.
>=20
> For example in mobile clients, we would probably need an app-level=20
> setting to indicate whether "legacy" or "standard" should be the=20
> default, but that would be confusing if "default" was actually a profile=
=20
> name.

There's a narrow edge here before it becomes bike-shedding; I do try to
avoid that ... but what about:  legacy, preferred and suiteb ?

"Standard" just sounds a bit too static to me, that is not something
which changes much.  So in 5 or 10 years from now, "standard" may just
as much be "legacy".  Hence my suggestion for "preferred"; this is what
we prefer now.  "legacy" is what we used and can even include what we
preferred earlier.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--HnUAm2JT07g60JBEdAtPblQVhMEDI6Kau--

--E6wpmgqO7CqqA6sXP0R1GXoHo667lsRCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYtM/IAAoJEIbPlEyWcf3yV9cQAKh+XI+C0xp3u0Yk3YmA2Azm
YXgNH/M8KtsSh9AGIq+iu0redKTMTnqKhfy2YFJdUtiZrSJpU12a9EWMpwlzdSWs
R2PD3RaSHmf1jr3fHdCeJ3wXWvMaN7VpRCo0VelFx33L2sIfvcnLRFfkzkISt3sB
y1LML2kynzhZ6HKjMLgJhSddRu8f/fNK+37ajZnHmp1gUdS70GwzosAG6eoI82N1
495NgKcpX8Ab7UeoNsM0qO1Eau6CFydX+3bBGHIQybMgkn2w2dpgQT3l6uw8H6s7
Zpr493xp037JTYtkqJ7leWvhIADvW574k2JPLs5KQxeumdwaAiCTYBGRueBKUvl+
9iWk6kb67wNROAjZW9k0Bok4fJZbAJQSTevVIwJbzhnXFrboAH+GqG4rvGKus+/k
mLZHGYqR3SS6ovlmDGejI5IZ5SIZt7KnNRw45cjCwZcM0pbkaA3A/fO89jbY/16G
zMrr8ZegHViA1CiiKFs+OTrbEExd8g5U4stU21wK3Ek/ZSojr1O1cp2nXuhyJAto
v3O8eM/WWuA6xbNpvLqqs0ogOq4XumxZYigFf37HoyCOMG5R9ES1JCNOiYNsm4c3
zwcgUd2Lcnra8UkOtEaJ1y0T7zUczKOC67EPDEZO9yNnyL2YmC7z5maISgyMR3ZV
SitqIwcu6LsgQuCmBIkE
=YQOg
-----END PGP SIGNATURE-----

--E6wpmgqO7CqqA6sXP0R1GXoHo667lsRCK--

