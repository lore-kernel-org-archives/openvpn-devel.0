Date: Sun, 11 Dec 2011 21:33:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111211203341.GG18948@...1296...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
	<20111209080212.GC18948@...1296...>
	<4EE2289D.3090507@...1114...>
	<CAOazyz1Y8cXmm1py=V-6+N2tBQx1OS42Hq5buVSH4UJYxRHQYg@...278...>
	<4EE2747A.1080100@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <4EE2747A.1080100@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
	over to platform provided basename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

cutting off most of this long mail, and pointing to a few - IMHO -
important aspects.

On Fri, Dec 09, 2011 at 09:50:02PM +0100, David Sommerseth wrote:
[..]
> >>> So I'd propose to keep openvpn_basename() - it's simple and short=20
> >>> enough, and has well-defined semantics that can be relied upon.
[..]
> Then there's the next problem.  Vague specifications and different
> platforms interpreting standards and specifications differently.  Sometim=
es
> you really wonder what POSIX people were smoking when deciding on
> standards.  And base/dirname() is one of those ... the vast majority of
> man pages I've read lately states this:
>=20
>        Both  dirname()  and  basename()  may  modify the contents of
>        path, so it may be desirable to pass a copy when calling  one
>        of these functions.
>=20
>        These  functions  may return pointers to statically allocated
>        memory which may be overwritten by subsequent calls.   Alter?
>        natively,  they may return a pointer to some part of path, so
>        that the string referred to by path should not be modified or
>        freed until the pointer returned by the function is no longer
>        required.

Keep that in mind...

> And we can go on like this forever and ever and ever ... it will always
> be one argument which kills the other, both ways.  So the conclusion?  We
> really need to draw a line _somewhere_.

This is why I opt for "use our own openvpn_basename()", based on the
(very short) glibc implementation.  Why?  Because to cope with this
messy specification, the caller of libc basename() has to jump through
a number of hoops, which your v3 patch doesn't completely do yet:

 - strdup() the string before calling basename() (in case the=20
   implementation modifies the string)

 - strdup() the *returned* string (in case the next call to basename()
   overwrites the static buffer that we've just received a pointer to,
   thus garbling a string that we might need to use at some unknown=20
   point in time late ron)

 - free() the first strdup()

 - eventually free() the second strdup()

[..]
> To be able to support the lower end, code size matters.  Reducing the
> number of code we ship, reduces the footprint OpenVPN takes.=20=20

Not in this case.  The actual basename() implementation has less footprint
than the extra hoops required to *savely* call any possible POSIX-compliant
basename() implementation.

[..]
> In regards to this current patch.  I have done valgrind tests, I even
> tried to free() the strdup()ed string in init_options_dev() ... and glibc
> complained instantly about double freed memory.=20=20

Well, the valgrind tests are nice to know *what happens if using glibc*,
but we already know that it's basename() implementation is really sane - it
doesn't tell us anything about basename()'s with static buffers, etc.

I'm a bit surprised regarding the "double free" - that is something that
this code and the implementation of basename() in glibc shouldn't be able
to trigger - it will free() memory that other pointers still point to
(so valgrind is happy, as there are still references), but it's not a=20
*double* free.

> So somehow, there are
> some clever memory management involved.  Which seems to be covered by the
> gc_*() calls on the options buffer.=20=20

This would very much surprise me, as strdup() isn't gc_*() aware.

[..]
> We haven't had any democratic system on the ACKs earlier, and I don't
> have any strong reasons to start with that now.  But unless there are
> more people NACKing this code, it will be applied as-is during next week.
>=20
> Any objections?

Let me point you to your own code size argument :-) - the extra code to
make POSIX basename() safe to use in all the useless-but-permitted cases
is more than carrying a sane implementation, as it is now...

(Now for dirname(), things are different, as it's not used for store-and-
use-later strings, so the "static buffer" thing is no risk here, and we
know that most implementations will modify the path name passed, and=20
have to cope with it anyway)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTuUTpakuBuNlUUl1AQL0tAQAq5x4R2lQrcSlx3xhkjcVxuWcApicMHH1
x73CGVnzdfeEEbg0y075yU8lba9hsWDcNF3oeFZejKKi0pI6hGAP9s35XYmkz0g1
56KHtpWojOFjogXSh0fRxv/hadamkjuQoECpHTdhjYV7FNaeFK7sCOUItp+iLimW
z2vNWoJGwEw=
=2dVk
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--

