References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<95391fd4-7b2f-389c-3752-4123d016286d@...68...>
	<CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
	<d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <105bf86c-4cd3-ba94-3141-e5979faaf507@...2080...>
Date: Sat, 15 Oct 2016 12:11:43 +0200
MIME-Version: 1.0
In-Reply-To: <d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AUt9VHxWCB65bJfR9IMfT21WNHqk3lPxb"
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
 releases?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AUt9VHxWCB65bJfR9IMfT21WNHqk3lPxb
Content-Type: multipart/mixed; boundary="wOIrgc5oW7oAJwB6s4wO4tUX5kCMtbpFj";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Matthias Andree <matthias.andree@...68...>,
	openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <105bf86c-4cd3-ba94-3141-e5979faaf507@...2080...>
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
	releases?
References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<95391fd4-7b2f-389c-3752-4123d016286d@...68...>
	<CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
	<d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>
In-Reply-To: <d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>

--wOIrgc5oW7oAJwB6s4wO4tUX5kCMtbpFj
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/10/16 11:01, Matthias Andree wrote:
> Am 14.10.2016 um 21:51 schrieb Steffan Karger:
>>
>> On 14 Oct 2016 9:14 p.m., "Matthias Andree" <matthias.andree@...68...
>> <mailto:matthias.andree@...68...>> wrote:
>> >
>> > Am 14.10.2016 um 17:28 schrieb Samuli Sepp=E4nen:
>>
>> > > Would 2.3.12 -> 2.4-alpha1 be too big an upgrade?
>> > >
>> > Yes, definitely. Please create a separate distribution for .deb packag=
es
>> > derived from pre-releases.
>>
>> Indeed. We shouldn't upgrade people who are expecting stable releases
>> to alpha versions.
>>
> One more somewhat more constructive note:
> Oracle have been naming their VirtualBox packages such that they
> included the minor version in the NAME.
> So the package name would be openvpn-2.3 or openvpn-2.4 for us, which
> creates redundancy as the actual version is added (openvpn-2.3-2.3.12),
> but it prevents moving users between release branches.
>=20
> Alpha/beta releases and perhaps the early release candidates should
> still also be marked in a separate "unstable" 'distribution'.

That's a clever thing, and is also done in the Fedora/RHEL world too.
However there are some pitfalls which is needed to beware of.

You either need to

a) have the files installed in a way so they don't collide.  Then
   use some tools (like 'alternatives' in the Fedora/RHEL world) to
   switch between which version being system default

or

b) Have the package exclude each other to block both being installed
   at the same time.


--=20
kind regards,

David Sommerseth


--wOIrgc5oW7oAJwB6s4wO4tUX5kCMtbpFj--

--AUt9VHxWCB65bJfR9IMfT21WNHqk3lPxb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYAgDjAAoJEIbPlEyWcf3y90gQAIypDz2jrtlddw3oOwROSEHX
eWPOTkvNXyz24da67Cjf6l6BoQTffaUd1gE1aH4roY9exikTC8umMeOCyq/kwV1v
lFGwJk7jdBaNV0ohu42aXG43oLdryxRpCr/ipy8Y90iamHfEkrQ3gqEOVCyOmfYL
vG2q8TPcYaChioStNXwop3fRJmP5uGbGgRWw4/9iTkvAkdlovZWwzrQPiSJu0wv/
JFDymlSM4SpNk3XX8e75ZF9+/Rblp+9ocOKEYkWH366lNgpshJGe+WzkyBCfxU82
+hIe9sNz7VP1Z/r1vV7Ln3+FiG8BdWl1pfP0gxYOZK7iFAPScneE8q/BivkOrzXQ
mL0zcxRvWlDsgqozEyJL2LZX4EFFvJIi/hQvkC0kN6axK27c1BPggBG2lfviQmpX
Midr1Hc64BxzQnuOD+odU+n4tGRVqjsBgxayoN8UbwhF0DHFmw8CKff9IiVB2AJx
DHMId3ZW8GujPgNV1oekjKbaRRLiQsr1rA8MeM26dFaD8w5+lKwQbGuo/UPz9zRM
HDalNTvi93Ckcs4sU2UIS+S2CrUdJwPrb95fHkChibqcXZAHvxG/kgdAeytjpPI9
ioIBrlJMN6Ux/8YhTh/RplA/Ja4DB2WJJLKdUc9JZlQ40olGq45M+pEFusPM7H+r
dhqQc5eca9y9gAwJDpyR
=FEgw
-----END PGP SIGNATURE-----

--AUt9VHxWCB65bJfR9IMfT21WNHqk3lPxb--

