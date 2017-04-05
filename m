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
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
Date: Wed, 5 Apr 2017 23:39:51 +0200
MIME-Version: 1.0
In-Reply-To: <31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eNSOxv4AgNWLuq5rJNmdFg7EfXBdf4VbC"
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
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eNSOxv4AgNWLuq5rJNmdFg7EfXBdf4VbC
Content-Type: multipart/mixed; boundary="LvFUEW9epQESbnP9mHf2mnb4TOu7lmdiF";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
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
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
In-Reply-To: <31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>

--LvFUEW9epQESbnP9mHf2mnb4TOu7lmdiF
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/04/17 23:13, debbie10t wrote:
> I don't believe there is any need to specify "max" because that would be=
=20
> --reneg-sec as is. Otherwise specify a smaller or larger --reneg-sec

I think you, probably without being aware of it, are agreeing to what
the current proposal is:

  --reneg-sec max
    A renegotiation happens within 'max' seconds, but with a 10%-ish
    randomness

  --reneg-sec min max
    A renegotiation happens within 'min' and 'max' seconds, fully
    controllable

So using --reneg-sec 3600 3600, effectively removes the randomness.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--LvFUEW9epQESbnP9mHf2mnb4TOu7lmdiF--

--eNSOxv4AgNWLuq5rJNmdFg7EfXBdf4VbC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5WQnAAoJEIbPlEyWcf3yXn4QAIcoVdprFQwWmFeVU/Uu7WXK
PrCCYgvdOzIqTYlhzPGPAJApNAvet8zfVoc/5ggCpJ+0nEMC230doZ/AOD+37cAq
Y/xDTP2C+FgLwAIoxUyaXkXonzApQo8WPvBj8XvrFOhquKecCNn8we/JK/PLxaO+
kyXgOLo4wTjQRSt7LwaYx2qHNUf1bKYYn0clKGmf8IsEsgiE9I0bz3TkG0qjLvfv
g4E6oBzgmuxtaoHSSvRgMYTWotYnPwiLx15fH5yAlCUzFI+K9NIY/tObwvXKJmIt
vYWDmMAGWXQBfWFZz4HzVv5cV6om1PAJCIF79TQQnIJUkImRnhqDmgpbt01GaKeM
MoVl2mkqXO78g2c+NpjS2RmL1njW5pKxrtSczIdERYL5/jKw/mTJDyF0uBnaoCm8
Y8zDa5qHxqyNFsVF0+7Z8DYERvbunp+g/Q7sNL3uqbwH6O6ppyjQnon3ZZqtORfx
y6W/LXMDzhP3f11HZazy3qtmPD3VRXPZLleHXOXVWB40tKs/XMSprv74RYVBhzbZ
u6q2ha/zC5wHQjvCVjEycsi6/Gqzv+r/FSgK5HVCkV3c9rmWVabKec3uACMoW5uF
x5XFYXJGFZH2gRlZMTt4orzWGJRudj+/mZasTxsFkoWAD/qsFlG3ouGX3RH8Qh5j
kIJpdwe2oiuipSDUi/YE
=/Ako
-----END PGP SIGNATURE-----

--eNSOxv4AgNWLuq5rJNmdFg7EfXBdf4VbC--

