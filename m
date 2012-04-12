Message-ID: <4F868C17.2090008@...1114...>
Date: Thu, 12 Apr 2012 10:02:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
	<4F85B343.6090207@...515...>
In-Reply-To: <4F85B343.6090207@...515...>
Subject: Re: [Openvpn-devel] ACK system review finished
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/04/12 18:37, Samuli Sepp=C3=A4nen wrote:
> Hi all,
>> My personal feeling based is that we should probably focus the
>> ACK system to high-risk patches, e.g.
>>=20
>> - patches touching critical parts of the code (rationale: better
>> safe than sorry) - patches from new contributors (rationale: fix
>> stylistic issues and errors, ensure usefulness, educate)
> I might add that James wanted to mandate a review on all patches -
> or at least those that have capability to create security issues.
> That said, we could probably use a  "experimental/testing" tree to
> host patches/patchsets that make sense, but have not yet been
> properly reviewed. This would have a couple of nice benefits
> compared to working with stable master + external trees/patches:
>=20
> - We could (easily) run build/connectivity tests against this=20
> "experimental" tree using our build farm - We could build snapshot
> binary packages based on this tree, and publish them using
> apt/yum/website
>=20
> This would allow patches to be reviewed by developers_and_
> (easily) tested by users at the same time.  The stable tree would
> still be the basis for official releases, and would pull stuff from
> "experimental" as it matures.

Just a little nitpick.  I wouldn't pull patches from the
"experimental" branch directly "just like that".  Let this branch be
completely experimental in all ways - like a fork which will never be
anything else than a fork.  So, patches which are taken from the ML
into the experimental branch, will need to be reviewed before hitting
the master branch.

But maybe it makes sense to discuss what kind of changes and to which
parts of the code will strictly require an ACK and what can more
easily be applied to the master branch just doing a more "sanity
review".

F.ex. man-page/documentation updates don't necessarily need to go
through any kind of security related review.  The same probably
applies to core autotools files itself(?).  But when touching C code
or some of the scripts we ship, then much more caution is needed.

But fixing typo's in a log messages isn't necessarily security related
at all (unless changing the formatting of the message; that might
introduce security issues).  However, changing the log verbosity level
in the encryption code might have some security impacts.  My point is
that we can't necessarily state that errlevel.h changes should be
relaxed "by default".  We need somewhat of an overall generic, but
still precise descriptions of what can be relaxed and what should not
be relaxed at all - not just a list based upon file names and/or
functions.

The current model, which tries to enforce a more strict ACK policy on
all patches avoids this need of clarification.  But it slows down
patch inclusions.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+GjBUACgkQDC186MBRfrqOGwCgpncEZTZ95R1RH9EXc4vhcIie
4asAn1VT845tPvVWaNpxA0i7gpmbPYyd
=3DQ7/m
-----END PGP SIGNATURE-----

