References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
	<CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
	<3092a563-61dd-9240-b288-190b6f5fc259@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <316ca921-ec33-b539-a0c0-89ee5d0ea50c@...2080...>
Date: Thu, 6 Apr 2017 15:13:16 +0200
MIME-Version: 1.0
In-Reply-To: <3092a563-61dd-9240-b288-190b6f5fc259@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OSWpcanvgEHExVlll7vDxKk8PRwPjun55"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OSWpcanvgEHExVlll7vDxKk8PRwPjun55
Content-Type: multipart/mixed; boundary="8JiQsPCjjmNq1s3OWQDN1x8CucL4xop8Q";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <316ca921-ec33-b539-a0c0-89ee5d0ea50c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
	<CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
	<3092a563-61dd-9240-b288-190b6f5fc259@...277...>
In-Reply-To: <3092a563-61dd-9240-b288-190b6f5fc259@...277...>

--8JiQsPCjjmNq1s3OWQDN1x8CucL4xop8Q
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 06/04/17 14:49, debbie10t wrote:
>=20
> As you can see, the current proposal does not allow for first random,
> followed by expected/normal/regular renegs. It is either *always* random
> or *never* random .. I believe this is a poor decision.

Even though I see arguments for first-only, I have no issues having the
current implementation being "always" or "none".

Adding a flag so the user can switch it to "first-only" will be a fairly
trivial patch to add.  In fact, I already now believe 66% of that
possible future patch will be updating the man page and Changes.rst.
The code itself to manage this will be probably around 10-15 lines of
code - possibly even less - when basing it on the "always" behaviour.

And if not a critical mass of users complains within a reasonable time
... well, then we don't need to bother.

No need to make even more noise about that now.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--8JiQsPCjjmNq1s3OWQDN1x8CucL4xop8Q--

--OSWpcanvgEHExVlll7vDxKk8PRwPjun55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5j8BAAoJEIbPlEyWcf3y1fYQALCtPMMHiH0zeDQVHwtHYzgB
omyq54r29I1jQIOQUJS6DG1wggw+9/byM5/POJ0RLmGM36u1jyhFZkhs/VuIvF7D
JNjyeST16Pgt/F5xOaU+0UDQzge6VsACYXi3OPQoN1slEf73CTv+EFtvH5W+SEBL
U7RvJxEXVZjjelUhmLcJ1xqSDv82gmThBqfc/hVqtXKBoY+MU9nAAGY/R1LEj6Zg
YFS7trabqoQ7K+gOVPi9BNL3/RDTHQs7U0ilDHQPVknnxZ2JUOluRD+eejoIwiYx
Qp09W6QDaAh+5hf7CLS30/O/FiATOxN/rhicfPWGHqLJARTqda9w+Sgnj5yhfZlL
FPdd3JNJt27qndyQfAfHpSJ5rh3jMr2PpwkfMwQIsPN/HNBp6YQHvADegVKKRzg7
ptBrZFLPFG01edB7hcRSLEdw9Be+kwbXShbr1mjZx8+agUJ8U8BRhZvgqgZlgkdF
5xb7RqyDsmB/7lcAR3cukeJ6kMMMNEkk8QpZrBJcho7KGulT68FIo3XknIbT4/gp
pzdkDLGN6XTm6gPFKDHC047ZylEo8Zt4hHxWeEbCFAHHy3kxN6SSP+41UNiaroaL
cqtraU3FbSSn9XrC+kH48HhAP20JjWygGW9NTdAyJ1YZxSAu2Z+Qj6uHzr9rcSnX
CrGGZ4YxYpCx22Bt4u1O
=vq60
-----END PGP SIGNATURE-----

--OSWpcanvgEHExVlll7vDxKk8PRwPjun55--

