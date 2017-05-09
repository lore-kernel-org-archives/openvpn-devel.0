References: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
	<1494279878-24601-1-git-send-email-steffan@...1856...>
	<18f36661-f955-86d6-e948-755bdb401fd7@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <1bc105a1-d52a-759d-a6a6-0d4059a769f2@...1435...>
Date: Tue, 9 May 2017 13:05:43 +0200
MIME-Version: 1.0
In-Reply-To: <18f36661-f955-86d6-e948-755bdb401fd7@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KwCvbse40hkIcajxGEpWgEug4poLcPgCt"
Subject: Re: [Openvpn-devel] [PATCH] Restore pre-NCP frame parameters for
 new sessions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--KwCvbse40hkIcajxGEpWgEug4poLcPgCt
Content-Type: multipart/mixed; boundary="TE0aHGRVMLAQpah6bF974wWsdV3eNj5KL";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <1bc105a1-d52a-759d-a6a6-0d4059a769f2@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Restore pre-NCP frame parameters for new
	sessions
References: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
	<1494279878-24601-1-git-send-email-steffan@...1856...>
	<18f36661-f955-86d6-e948-755bdb401fd7@...2080...>
In-Reply-To: <18f36661-f955-86d6-e948-755bdb401fd7@...2080...>

--TE0aHGRVMLAQpah6bF974wWsdV3eNj5KL
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 09-05-17 12:46, David Sommerseth wrote:
> On 08/05/17 23:44, Steffan Karger wrote:
>> As reported in trac #879, as of the introduction of NCP we always adjust
>> the frame parameters on session negotiations, but do not reset the frame
>> state for a new session on an existing state instance.  That caused the
>> frame parameters to be reduced for each reconnect, resulting in smaller
>> and smaller packet size limits until no traffic could go through the
>> tunnel at all.  This patch resolves that omission.
>=20
>=20
> Only glared at the code changes, and it makes sense to me.  I'll try to
> run a few tests to see if I can reproduce this issue.  If others can
> help test this patch, that will also help tremendously - and I'll try to
> remember to add a Tested-by: tag in the commit log too for all those
> confirming this fix.

The two reporters on trac confirm this fix works for them.

> A little nit-pick below though.
>=20
>=20
>> Trac: #879
>> Signed-off-by: Steffan Karger <steffan@...1856...>
>> ---
>>  src/openvpn/forward.c | 7 +++++++
>>  src/openvpn/init.c    | 2 ++
>>  src/openvpn/openvpn.h | 3 ++-
>>  src/openvpn/ssl.c     | 9 +--------
>>  src/openvpn/ssl.h     | 8 ++++++++
>>  5 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 8102e94..2f3f3c5 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -866,9 +866,16 @@ process_incoming_link_part1(struct context *c, stru=
ct link_socket_info *lsi, boo
>>               * will load crypto_options with the correct encryption key
>>               * and return false.
>>               */
>> +            uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
>>              if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.bu=
f, &co,
>>                                  floated, &ad_start))
>>              {
>=20
> Wouldn't it make more sense to move the opcode declaration to inside the
> if (tls_pre_decrypt(...)) block?  I can do that on-the-fly though.
>=20

That won't work, because tls_pre_decrypt() alters buf.

-Steffan



--TE0aHGRVMLAQpah6bF974wWsdV3eNj5KL--

--KwCvbse40hkIcajxGEpWgEug4poLcPgCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZEaKHAAoJEEEwndWOY1w5FrYH/A7qbcRBGyyKPdM+k3MFruP2
8ZJg8KAomkjJV5ewQpEFLFzdLaU9OuYnll2V4lq69Up4H4sKYDHJ98OK54f+5uHO
2CCGLIwtHTr78BYO6Hz1/2e/GEUKybeYDp7Y819WRNfwyLVyVN/d4vE8aYLxo5k0
JweRjpauGKaerEse1jXPgPKHqhMHcqjFZyqIVzIjcRbsB4k56978D3EFDlT2p0LB
GcQHfxf6j1/IQJXTMRYbW/LwxqBAG+xQsadHj1ESE4kzgu3RQBekVI+oOPX4P7nJ
oiRKVES+5T7oO31OKzKZYmWJgJXwtnl+ZOuSD/iyVzNpJviOW54heTJh31qMjIA=
=dGOl
-----END PGP SIGNATURE-----

--KwCvbse40hkIcajxGEpWgEug4poLcPgCt--

