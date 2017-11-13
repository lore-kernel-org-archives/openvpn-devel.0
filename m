References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <d74c3e94-2d0c-a897-5993-76b2bb4b7b13@...2318...>
Date: Mon, 13 Nov 2017 14:44:56 +0100
MIME-Version: 1.0
In-Reply-To: <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IwgEUVVUDvukM4p3Pp3FNtnXVlagQPq3g"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IwgEUVVUDvukM4p3Pp3FNtnXVlagQPq3g
Content-Type: multipart/mixed; boundary="gJwWPHAMlTJIxvhvT1eSBOLtsb3vEAQEa";
 protected-headers="v1"
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <d74c3e94-2d0c-a897-5993-76b2bb4b7b13@...2318...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
In-Reply-To: <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>

--gJwWPHAMlTJIxvhvT1eSBOLtsb3vEAQEa
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 01:16 PM, David Sommerseth wrote:
> CSV just looks structured - until the layout is changed.  While JSON
> (and even XML for that matter, _not_ saying we should have XML support!)
> is not strictly bound to the order of fields, so adding new fields is a
> no-brainer with JSON compared to CSV.  And before you say "We only
> append fields to CSV", some of those changes we have done in the past to
> --status 3 have even broken some users setup - because the CSV parser
> was stupid.  The risk of that happening to JSON is far less.

This is a very good point. This was one of the problems I had before
parsing OpenVPN's CSV when it changed (a little) between 2.3 and 2.4.

> Just a few words to the management interface vs --status file.  We
> should support JSON via both channels.  And implementing that shouldn't
> be rocket science as it should be the same function producing that result.

Agreed, also talked about with Gert (van Dijk) @ Hackathon.

> But we should consider if we want to make use of a JSON library
> producing the JSON streams.  The reason is to ensure the output is
> according to the specification and that escaping if contents is
> consistent and proper.  Imagine if someone puts a double-quote into the
> CN field of a certificate?
>=20
>  CN=3D"} Lets explode things, O=3DHacktivist0
>=20
> Or other characters which needs escaping.

Another very good point. I do have some experience with json-c [1],
would it be acceptable to add this as a project dependency? That is the
main reason I started out by just outputting a string and conveniently
forgot escaping issues...

So for now my plan is:

1. use json-c to generate (human readable) JSON;
2. also support --status (command line) in addition to "status" in
management interface
3. do not print "END" marker any longer

This is an excellent way for me to gain some more experience with
writing C (and OpenVPN), even if in the end the patch is not accepted. I
do think, like Steffan said, we need a good reason to support JSON,
especially if it adds an additional external dependency. The
future-proof-ness of the JSON format could be a good selling point,
maybe new fields would only be added to the JSON format and not to the
other status formats to promote adoption of the JSON format and slowly
phasing out the CSV format(s).

Cheers,
Fran=E7ois

[1] https://github.com/json-c/json-c/


--gJwWPHAMlTJIxvhvT1eSBOLtsb3vEAQEa--

--IwgEUVVUDvukM4p3Pp3FNtnXVlagQPq3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYje68UGKkH2qmOqnnF7dZFpXHrIFAloJodsACgkQnF7dZFpX
HrJodg/+ICOTMUUKtqwoxaaSQGqA9ShhaJp8/Cq9u4zid6UUCAv3SvMkxuxO8DkZ
Z8QP7mlO3oekTuAtBLa25AiouRwTll2uDdX2oSnJh6PjHpCTJmVSTUy+BLR2PbG2
A7J12fTrRR5yZG/L82/E+2bULgzKzeUbykFlnF/XqeTQ3VSX4/mS2rXoG5rDD+5Y
2B7yuiy+DIsspTYqrJPsGrMMa7/CrZ5iSp6e0kJXgb2Xzazfe7beIdXtylI0wufm
JLAzk2yDa0wZl9QpKszjQFMtptvVeMG/jMCEVPGlS2zz6Fgs5bf/SkF/tyNLbPc2
BrDTD8NOV5ovHya7qMkHYTrQ7xbuLk74vTVV2vVuWIJxbNuFKJ2EVjRg3DvVvb6D
jHQsYBuNYdgnUpvIgJsK9NB3XCsd4aZdBnjixmmGkg+S5SKuaCp5R5zemxjBkPth
rqyTiO/EyPD9/Vb+tFHymAu83Wy/im6URYulQuELaAeIleN8KVw26KWqWWZHf0yM
rJetPRoe18DcvOLzTNiO1yPvixgrgvgtD25Li5KGIjhYN4O/ijrMwvWpwIIEaYx1
h072aBTBrTmQNL6sNpLgSrUBCTthXK736QRyOjJTM3h/O2h2N06PNFhKYf6+GXgl
19c07OD+NT/uX1LkHuu0bbypSR0QhXDuZI/E/80HMZYbaQ5RlBA=
=DfQo
-----END PGP SIGNATURE-----

--IwgEUVVUDvukM4p3Pp3FNtnXVlagQPq3g--

