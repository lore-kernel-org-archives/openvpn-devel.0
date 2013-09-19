Message-ID: <523ACA8B.7000408@...1114...>
Date: Thu, 19 Sep 2013 11:57:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAFHpkQEPogSqK9xbkMa4YYdE9yNSO9Lwj9Tqo-jARB4hrgdYbw@...278...>
	<20130917195350.GL161@...1296...>
	<CAFHpkQFBF6EXPfXMV=ePhh3QNMRJuXnh5TjG1bCtKJuOi40Utw@...278...>
	<20130917202917.GM161@...1296...>
	<CAFHpkQFFC50keiv_BuUoDFWRGN-pe3Ojhn5wT5Mr9ULSWLhZeg@...278...>
	<20130918110441.GO161@...1296...>
	<CAFHpkQGybr=n7mCAbMkn=pizE+Apn-Hw1DHzgo5yyZub9pD1Tw@...278...>
In-Reply-To: <CAFHpkQGybr=n7mCAbMkn=pizE+Apn-Hw1DHzgo5yyZub9pD1Tw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="UTnSklX9NnDauVtFrFUDttLmfo1i2affJ"
Subject: Re: [Openvpn-devel] "unix style line endings" in openvpn-build repo
 ?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UTnSklX9NnDauVtFrFUDttLmfo1i2affJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 18/09/13 13:19, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> 2013/9/18 Gert Doering <gert@...1296...>:
>> Hi,
>>
>> On Wed, Sep 18, 2013 at 02:42:22AM +0600, ???? ??????? wrote:
>>> I was very impressed how Cassandra community helps developers:
>>>
>>> http://wiki.apache.org/cassandra/HowToContribute
>>
>> Yeah, this is great.
>>
>>> I spent an hour when I tried to build openvpn under cygwin. I DID
>>> mention that "cygwin's git should be used", I did run git from command
>>> line and I was wonder what went wrong. I simply installed cygwin
>>> without git and windows git was in PATH.
>>
>> Well, what shall I say - building on Windows is always problematic, which
>> is exactly why the official windows binaries get built under *Linux*,
>> using openvpn-build and mingw64 cross-compiler.  This is the official
>> way, documented in the openvpn wiki.
>=20
> What I'm trying to say "let us do it less problematic" and your point
> is like "ok, it is always been problematic, let us keep it that way"
> why ?

CR/LF has *always* been a problem, all since DOS came and wanted CR+LF
while Unix at that time already used LF only.  And them Apple Mac came a
long using just CR.  This isn't a new issue.  And this is the core problem.

Having that said, git have some features to try to lessen this burden.
But it is far from perfect.  In fact we had some information how to set
up git to handle CRL/LF issues "automatically" [1].  However that
approach didn't work too well.  So it was decided that using
.gitattributes was the right and most native approach.  See commit
f99d8fa79d538c42f2ebb54d8bc2a7f891ea09f9 for more information.

[1]
<https://community.openvpn.net/openvpn/wiki/GitCrashCourse?action=3Ddiff&ve=
rsion=3D10>

To be frank, I still think that commit solves the issue better in most
cases.  That Jenkins on Windows is becoming a pain in a*** isn't really
going to convince me of solving this issue differently.  That's a
Jenkins problem not a git or OpenVPN issue.

>> James also builds with msvc, so that "mostly works", but using cygwin
>> is not something any other developer does, so it's not particularily well
>> documented.
>=20
> using cygwin is exactly what any other developer does when he comes to
> an idea "ok, openvpn-gui sucks, I'm going to add a feature to it"
>=20
> first of all, developer comes to conclusion that openvpn-gui is a
> separate tool, which in turn can be built separately.
> ok, let download it and figure out how to compile it.
> hmm, there's even README, great... no luck at all after many hours spent.
>=20
> second, developer comes to an idea that
> https://github.com/openvpn/openvpn-build can be used
> ok, there're 3 ways: msvc, cygwin and linux cross compile. which one to c=
hoose ?

Most of us prefer Linux cross compile these days.  The reason we have
these three alternatives is that OpenVPN is from over 12 years old.  It
has gone from cvs->svn->git, it has been using all of these approaches
all after what worked best.  Many years ago, cygwin builds might have
been better for Windows compatibility than cross compiles.  And the that
didn't work too well, so builds in msvc came to improve that.  And then
mingw came strong back again and enabled us to do very good cross
compiles in Linux again ... and so the circle spins.  Everything is in
movement and we choose what works best at the given time.

Yeah, we can probably remove some of the builds methods at some point.
But not before the OpenVPN Technologies company is ready for it.  They
sponsor this project and are the core origins of this project so we
respect their needs.

> I managed to compile using msvc (no luck with x64). Also I managed to
> compile with linux and cygwin.

We have instructions on doing cross-builds, which is used for the
official builds:
<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem>

>>> Any reason to puzzle developers ?
>>> Look, people want to contribute, and they have to solve puzzles
>>> instead of doing usefull things.
>>
>> A more useful approach would be to ask first what the recommended way to
>> build Windows binaries is - Samuli would have told you :-)
>=20
> a more useful approach is to eliminate difficulties.
> ok, we can live with difficulties. but when we can eliminate some of
> them, why not to do so ?

Because there are no perfect remedy for this issue which works for
everyone.  What we use now is what was found to be the best compromise
for most of the users and we knew it would still be some use cases it
would hurt us.

If you need different .gitattribute settings to solve your issue, you
can apply them locally in your own git tree (.git/info/attributes).  See
[2] for more info.

[2] <http://git-scm.com/book/ch7-2.html>


--=20
kind regards,

David Sommerseth



--UTnSklX9NnDauVtFrFUDttLmfo1i2affJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlI6ypAACgkQDC186MBRfro4pwCfV8t5eIbzLirvMwJ7Y4vq3W0i
9i8AoJlyNzz3AZtQsWZbWbfWVYlVyWmH
=UGxA
-----END PGP SIGNATURE-----

--UTnSklX9NnDauVtFrFUDttLmfo1i2affJ--

