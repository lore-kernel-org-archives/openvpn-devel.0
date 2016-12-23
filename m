References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
	<075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
	<CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
	<0311294b-9902-c813-6649-9597a867fbea@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <1feee9f2-b989-713e-7c2d-79a54aab285c@...1856...>
Date: Fri, 23 Dec 2016 20:39:25 +0100
MIME-Version: 1.0
In-Reply-To: <0311294b-9902-c813-6649-9597a867fbea@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ikTOqF4x46Eu2kw4hSFl5TjvP9Ff6s4XB"
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in
 crypto*.{c, h}
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ikTOqF4x46Eu2kw4hSFl5TjvP9Ff6s4XB
Content-Type: multipart/mixed; boundary="VCwdwCogF1GqJVDcmkei7gfo882ba1Tqm";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <1feee9f2-b989-713e-7c2d-79a54aab285c@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in crypto*.{c, 
	h}
References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
	<075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
	<CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
	<0311294b-9902-c813-6649-9597a867fbea@...2080...>
In-Reply-To: <0311294b-9902-c813-6649-9597a867fbea@...2080...>

--VCwdwCogF1GqJVDcmkei7gfo882ba1Tqm
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23-12-16 17:17, David Sommerseth wrote:
> On 21/12/16 23:03, Steffan Karger wrote:
>> On 21 December 2016 at 22:09, David Sommerseth
>> <openvpn@...2080...> wrote:
>>> On 18/12/16 19:26, Steffan Karger wrote:
>>>> Now that we have touched each and every file anyway, I decided to go o=
ver
>>>> the code I regularly work with and reformat it some more by hand.  Thi=
s is
>>>> how for I got today, and is a large enough patch I think.
>>>>
>>>> This commit is mostly just reordering and changing whitespace, with one
>>>> exception: it removes the #if 0 around some debugging code in
>>>> read_key_file(), and now always print the debugging if D_SHOW_KEYS is
>>>> enabled.
>>>>
>>>> This patch is best reviewed with something like
>>>> 'git diff --ignore-space-change'.
>>>>
>>>> Signed-off-by: Steffan Karger <steffan@...1856...>
>>>> ---
>>>> v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.
>>>>
>>>>  src/openvpn/crypto.c         | 425 ++++++++++++++++++++++------------=
---------
>>>>  src/openvpn/crypto.h         |  27 ++-
>>>>  src/openvpn/crypto_mbedtls.c |  63 ++++---
>>>>  src/openvpn/crypto_openssl.c |  38 ++--
>>>>  src/openvpn/cryptoapi.c      | 101 ++++++----
>>>>  5 files changed, 356 insertions(+), 298 deletions(-)
>>>>
>>> [...snip...]
>>>
>>> Hmmm ... I like that we're trying to clean up the formatting further.
>>> But I'm not too happy that uncrustify seems to disagree slightly ...
>>> See the attached patch what happened after applying your patch and then
>>> running:
>>>
>>>    $ uncrustify --no-backup -l C $files
>>>
>>> We should either see if our uncrustify config is correct or need slight
>>> adjustments (without needing to re-run it on the complete tree once aga=
in)
>>
>> This seems to be due to 2 things:
>>
>> 1) I adhered to the CodeStyle page 'When lines exceed this length,
>> wrap them using a double indent (ie 8 spaces)', while the crustify
>> config uses a single indent.  Since this double indent was somewhat
>> arbitrary, I think we should just change the CodeStyle page to single
>> indent.
>=20
> And this goes against what was agreed upon in the Munich 2014 hackathon:
>=20
>   o line length?
>      - breaking a line in the middle: align to opening (round) brackets
>        in line above
>=20
>   <http://community.openvpn.net/openvpn/wiki/MunichHackathon2014>

That's about 2), not 1), but I get the point.  As before, I'll just have
to accept the "we decided on this before argument", and deal with it.
(I'm not sure how to keep the code readable with this requirement, but I
guess we'll find out.)

> This is yet another thing which have appeared into the CodeStyle wiki
> page without much discussion, as far as I am aware.

To fair about the CodeStyle page, I created it a number of weeks before
the rc2 deadline to get the reformatting ball rolling and *explicitly*
asked for feedback and additions on multiple occasions (IRC, meeting
agendas).

-Steffan


--VCwdwCogF1GqJVDcmkei7gfo882ba1Tqm--

--ikTOqF4x46Eu2kw4hSFl5TjvP9Ff6s4XB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYXX1yAAoJEJgCyj0AftKIAgQH/R3qi9iuRu/9szGB7CMD8r2L
5U1tcNODriqu+pFrwfqQs80GQQPLJnQuowqLSsMTXw9DlJ+bIOr9fKd5NeZNdhe5
Qi/slogom8Eg5MnAA9QnzvolKBkLNFW8fU4w+alDVgq4UF7JBB7GM9r0c8HsDf8p
+20uuLKkYEZlj3OEPFl+5PuFrCUquf2oPsRsg8Gyb16DVu81yZtLsb64J9Si4g8N
L0+2vwIudGBhkKRO7lAGXIr1uFSjKDz1RWwuO7j+COIe49X/09wlcFnKRH/Qb2+j
rb4ZYFDZX3Ex7BwzCoNOc3Oi3nps2K2VroPyVsa2NuV1QWKjITyHy6tgT8ODeNs=
=IrWj
-----END PGP SIGNATURE-----

--ikTOqF4x46Eu2kw4hSFl5TjvP9Ff6s4XB--

