References: <1490527279-31426-1-git-send-email-chipitsine@...277...>
	<12987e8a-1873-fc96-3b4f-0576939773fb@...1856...>
	<CAFHpkQHyR+fO-PpK-q+vHvWC02sjRiOWkcwOTje7g6wqyZyEYg@...278...>
	<7e470072-787c-c7c3-39cb-b9338720b79c@...1856...>
	<CAFHpkQELjBpk4TXNrrOrkMaE1vooH=ZySG6HfQts+RuuPuXGfg@...278...>
	<57b33706-7042-d65a-0269-ba7d5ac932e8@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <ee309d8f-61fc-8c8a-1962-3d6377dba722@...515...>
Date: Mon, 10 Apr 2017 10:03:02 +0300
MIME-Version: 1.0
In-Reply-To: <57b33706-7042-d65a-0269-ba7d5ac932e8@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8WMrDSRMv0gSUEERg7BNIlt82MVDUnfXg"
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only
 configurations"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8WMrDSRMv0gSUEERg7BNIlt82MVDUnfXg
Content-Type: multipart/mixed; boundary="------------013BA2331DDEE907FD1E8B11"

This is a multi-part message in MIME format.
--------------013BA2331DDEE907FD1E8B11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 00:44, David Sommerseth wrote:
> On 09/04/17 15:31, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>>
>> how did you came to conclusion that it means poor code quality?
>> is it written somewhere on the https://openvpn.net on how to write bash
>> scripts ?
>=20
> Steffan have given a good reasoning, and I completely agree with him.

Searching for "why split code into functions?" in DuckDuckGo gave this
as the first hit:

<http://stackoverflow.com/questions/3107400/what-is-the-golden-rule-for-whe=
n-to-split-code-up-into-functions#3107416>

Two good reasons from that page:

1) Code reuse (=3Davoid repeating yourself)
2) Readability

Your patch adds a big chunk of code under

   if [ ! -z ${CHOST+xxx} ]; then

It is pretty clear _what_ the lines in the code block are doing, but it
is not at all obvious _why_ the code block is there. One has to search
it for hints like

    # Must have something to do with mingw-w64...
    sudo apt-get -y install dpkg mingw-w64

and

   # This must be building for Windows...
   unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip

One could also search for the commit that added that block, and notice
the commit message: "travis-ci: add 2 mingw "build only configurations"".

Nobody should have to spend more than a few seconds trying to figure out
why the code block is there. A simple comment before the block would
have improved readability _a lot_, e.g.

   # Build on mingw-w64
   if [ ! -z ${CHOST+xxx} ]; then

That said, please do what Steffan suggested and split the block into
human-readable logical functions and call those functions as needed.
Then we can review the patch again and hopefully merge it as-is.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> Further, it is impossible to write a documentation which is 100% perfect
> on coding style, good coding practice and related subjects.  If you
> insist on that, I recommend you to visit http://shop.oreilly.com/ or
> Amazon and find some good books about it (the review ratings on those
> sites are usually fairly good in this regard).  So there are no reasons
> for us to try to duplicate the work of other writers.
>=20
> I would even dare to claim that programming isn't just a science with
> only one way to do things properly.  But it is a science which requires
> you to think thoroughly of what you try to solve, how to solve it and
> how to make it easy and understandable for others.  In fact, the real
> science part of programming (to solve a real and concrete issue) is just
> one little part of the whole picture.  And this makes me think of Reuven
> Lerner and his weekly newsletter.  He pulls up a lot of these things
> there too, perhaps consider to sign up for that too can be a good idea?
> <http://lerner.co.il/newsletter/>
>=20




--------------013BA2331DDEE907FD1E8B11
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------013BA2331DDEE907FD1E8B11--

--8WMrDSRMv0gSUEERg7BNIlt82MVDUnfXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY6y4nAAoJEClYTZ9AhkV4MUsH/2K4YCtTK/Jo5mbgeC6+36aD
Gq8liQTYiAWATSTsVHBcbCpbFrFP34BtQyORU4Z3pIhVgvHzX6Www5THExYKgNpY
cj3pxhwovFgLZt/sLZUZ0Ag8/cedSRh3YZYsDrHcllwI2eqTRfuBJM3agbCMwv1E
mlTn2KVE+rcyWRSgJnuyhHooA1z8lCF2bcyRNNvgHOIO+6ntz6q++OlnooEgpw9S
qRkCmip+kHwnHR4Ussdn4DIa17vAoYwNOPdFI3G9ygbK+TALFfxrKLPFNQtxm++/
qGrfKUwBHDXvI4fLV4DjrH8gDCk4eb0rtmva36mWiWG9MpAc8v03s0P51UrW7Hc=
=YelJ
-----END PGP SIGNATURE-----

--8WMrDSRMv0gSUEERg7BNIlt82MVDUnfXg--

