References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
	<075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
	<CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0311294b-9902-c813-6649-9597a867fbea@...2080...>
Date: Fri, 23 Dec 2016 17:17:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BoCijqS6n8JPnf3qAHC1RJQhExFTUBDFI"
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in
 crypto*.{c, h}
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BoCijqS6n8JPnf3qAHC1RJQhExFTUBDFI
Content-Type: multipart/mixed; boundary="aV7Xg6gl3XCdNL8irokcKN9UQSLEHxvI0";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>,
	openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <0311294b-9902-c813-6649-9597a867fbea@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in crypto*.{c, 
	h}
References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
	<075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
	<CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
In-Reply-To: <CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>

--aV7Xg6gl3XCdNL8irokcKN9UQSLEHxvI0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/12/16 23:03, Steffan Karger wrote:
> Hi,
>=20
> On 21 December 2016 at 22:09, David Sommerseth
> <openvpn@...2080...> wrote:
>> On 18/12/16 19:26, Steffan Karger wrote:
>>> Now that we have touched each and every file anyway, I decided to go ov=
er
>>> the code I regularly work with and reformat it some more by hand.  This=
 is
>>> how for I got today, and is a large enough patch I think.
>>>
>>> This commit is mostly just reordering and changing whitespace, with one
>>> exception: it removes the #if 0 around some debugging code in
>>> read_key_file(), and now always print the debugging if D_SHOW_KEYS is
>>> enabled.
>>>
>>> This patch is best reviewed with something like
>>> 'git diff --ignore-space-change'.
>>>
>>> Signed-off-by: Steffan Karger <steffan@...1856...>
>>> ---
>>> v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.
>>>
>>>  src/openvpn/crypto.c         | 425 ++++++++++++++++++++++-------------=
--------
>>>  src/openvpn/crypto.h         |  27 ++-
>>>  src/openvpn/crypto_mbedtls.c |  63 ++++---
>>>  src/openvpn/crypto_openssl.c |  38 ++--
>>>  src/openvpn/cryptoapi.c      | 101 ++++++----
>>>  5 files changed, 356 insertions(+), 298 deletions(-)
>>>
>> [...snip...]
>>
>> Hmmm ... I like that we're trying to clean up the formatting further.
>> But I'm not too happy that uncrustify seems to disagree slightly ...
>> See the attached patch what happened after applying your patch and then
>> running:
>>
>>    $ uncrustify --no-backup -l C $files
>>
>> We should either see if our uncrustify config is correct or need slight
>> adjustments (without needing to re-run it on the complete tree once agai=
n)
>=20
> This seems to be due to 2 things:
>=20
> 1) I adhered to the CodeStyle page 'When lines exceed this length,
> wrap them using a double indent (ie 8 spaces)', while the crustify
> config uses a single indent.  Since this double indent was somewhat
> arbitrary, I think we should just change the CodeStyle page to single
> indent.

And this goes against what was agreed upon in the Munich 2014 hackathon:

  o line length?
     - breaking a line in the middle: align to opening (round) brackets
       in line above

  <http://community.openvpn.net/openvpn/wiki/MunichHackathon2014>

This is yet another thing which have appeared into the CodeStyle wiki
page without much discussion, as far as I am aware.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--aV7Xg6gl3XCdNL8irokcKN9UQSLEHxvI0--

--BoCijqS6n8JPnf3qAHC1RJQhExFTUBDFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYXU4WAAoJEIbPlEyWcf3y0OUP/2k55CZ4BIzu2uU/s53ltGJ4
+qWHhJ7/cbaB1UHGWb577lKK5AAVpRBcS46ljik4UsrXpsdbWgEIePtnJjtXjnFF
6S1SW0l1tlrvrZQ7zyMpwzmQDIs8HNluPeH9lTUDdZYpu5DAuByMy/bFB5zCmveL
Ac8kUx8yxP2nGMEGtrv+AXqS6cXnkSdydvoJgWEztJvsS5uTRHvGcBxQR2t0bJrv
hldR7ccpx20VlgVQZSPqkk28EeIVmdWB62biLo3w9+0wMmQHewuHyqegEIqNsbEC
YN3g2libovvfMt3ZgnlYEzTJg+EA+Pgpe8UiRDNDk7zLdib/Rzw/1XQcmnGCKQVj
NzQFaUSVOYKo2MmrgcrkZ42xaKVTHPBQWijbSbGHz8BwigHhe2ECbRgnqolNQzQK
HUOgrgBwBJkzmt9P7HIuJh6jj+R2zi/6CpV1SmcfCQXHVoSf8UHCwULyaV20uMpo
zh8py41xow0PR0Bw2G2WgAbJ+xO9c9QtcRMRX/nrIT9bRvC3VqhwXA8fsbh4h5pf
aIsZIiS2gRB9ASx0Lcz99+7TI7BWlmGg1U/Auq+RtsqT/n0o5jpER8NpD+MDrJ9s
4nRDA2XeB88XiQFqjz/dO5is2/JeCtNelEFmTv1okwxzbatNMU5Yrie0Y9ddhbXM
CuPVlGgm40cwQDRF5b9c
=7Tgp
-----END PGP SIGNATURE-----

--BoCijqS6n8JPnf3qAHC1RJQhExFTUBDFI--

