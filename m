References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
Date: Wed, 22 Feb 2017 02:21:35 +0100
MIME-Version: 1.0
In-Reply-To: <20170221211205.GF93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N5pVlmgxEp3UJ7MuJrJjNlx7DiNqBjVC8"
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
 without AES-256-CTR or SHA256
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N5pVlmgxEp3UJ7MuJrJjNlx7DiNqBjVC8
Content-Type: multipart/mixed; boundary="46UAJmvigOu87C87vTCEvm62nlb34jSAT";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
	without AES-256-CTR or SHA256
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
In-Reply-To: <20170221211205.GF93896@...1296...>

--46UAJmvigOu87C87vTCEvm62nlb34jSAT
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/02/17 22:12, Gert Doering wrote:
> Hi,
>=20
> On Tue, Feb 21, 2017 at 08:42:57PM +0100, Steffan Karger wrote:
>> ACK to the attached patch.
>=20
>> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00 2001
>> From: "Simon (simix)" <via-trac>
>=20
> All previous commits (I'm aware of) carry a valid e-mail address, and
> most of them have a full name for the author.
>=20
> Do we have a policy how to handle patches with missing author info?

I see no reason at all why we should not give proper credit with full
name.  And we want to be able to reach out to people if there are issues
we can't figure out.  And since I'm one who likes consistency, I think
the policy should be the same for both large as well as small patches.

If someone have issues with that they can get in touch with Samuli or me
directly, as we are employed by OpenVPN Technologies.  Then we will sort
out the details and figure out who will get the credit in the end.

And we should see the Signed-off-by (SoB) line as well.  This carries
more importance if there are legal issues later on (intellectual
property issues, copyright infringements, etc).  The SoB line basically
indicates that "Yes, I am allowed to share this contribution for
inclusion".  The OpenVPN project is far to big to be ignorant to these
possible challenges.  And we never knows whom will be a victim for the
next patent troll.

With that said, I am far more relaxed to the SoB when it comes to
documentation and text snippets (unless it is a massive contribution).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--46UAJmvigOu87C87vTCEvm62nlb34jSAT--

--N5pVlmgxEp3UJ7MuJrJjNlx7DiNqBjVC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYrOenAAoJEIbPlEyWcf3yPwUQALpJPGQ/1FFUJXqmIcalc9mr
ehe3tmGymcUTIvo58kWa43oUYerQavyo8DnRGzSls1o90o5o/pgE3v7z0uT26+fo
AtLjVf5WLDN5VACpxINDM1tonVm55reNM+HboIRO0RZ3BDMueW+XeA6gXUzca4Fw
Jo+OL/+8Po0MOnsD1nQpR03ol0kXjMZfsATuUG9ykrLM3o8rUJ9mhJl481eavw3x
c74we8uPH1/wUjWYfCJV24xEH3yckb5pTIaM/0SIsMbcNZmmgoLMUfybXG3n5pjo
gDL5OkCnvfpKtk0NNKJrLoop+t/F/+2fnhzVReX2uxOcKYZdD+l37B5nYptPH72u
d2/haXIfL8WYzvgRddaFquHzl5idZDohrVzQLiwLN4aF04K4ojhRK2mFmouP5C3R
5kJk8yKe4s+smaGlXKSLnTiKorcPttKIO7YMWMSObt+mCWLggj9nRvzPLjPk+M9Y
8SHZR8V4QwY9Mb3BcN4ahzOjzFVcyR50ispBhDfhi4pPGkj3TV27JetH5MLr0VdF
KFEwQAuJgxw55TdpC/Xh6MbRRz1RMNLsT5zIs0Kcac2QbkwGt0Dd++XnMeQRRZ0K
o9AKObhDDWWgpQvgWCLyGFYaUFNvb2nq1lv6og09doDnM8z/xOJgHMCET6vi5SmX
cmG8/VnFHCPl1k5UHcTK
=4pcj
-----END PGP SIGNATURE-----

--N5pVlmgxEp3UJ7MuJrJjNlx7DiNqBjVC8--

