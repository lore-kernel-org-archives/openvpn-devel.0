MIME-Version: 1.0
In-Reply-To: <4F426F81.6040201@...1114...>
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
	<1329749121-24501-1-git-send-email-alon.barlev@...277...>
	<4F426F81.6040201@...1114...>
Date: Mon, 20 Feb 2012 21:35:43 +0200
Message-ID: <CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] windows: do not use X_OK as it is
	unsupported
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

David,

Again,
This has nothing to do with POSIX.
mingw *DOES* define this constant in *WINDOWS*.

We do not want to have a different constants (and different values) at
the MSVC and mingw build.
Build should be consistent when possible, but not override environment SDK.
Anyway, If this will not enter here it will enter my rewrite... I
thought it is better to do this sooner than later.

The definition of PLATFORM_X_OK will be moved to autoconf.

Alon.

On Mon, Feb 20, 2012 at 6:06 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 20/02/12 15:45, Alon Bar-Lev wrote:
>> Reported by Heiko Hund. Reference [1].
>>
>> Replaces 4ebc587eab73e03ef64d344a5707d84e7f8d875a
>>
>> [1]
>> http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=3Dvs.100%29.aspx
>>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- options.c
>> | =C2=A0 38 ++++++++++++++++++++++---------------- win/config.h.in | =C2=
=A0 =C2=A02
>> +- 2 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/options.c b/options.c
>
> I'm not convinced about this at all. =C2=A0It *is* the proper way to do i=
t,
> from an intellectual point of view. =C2=A0But this complicates the readin=
g of
> the code in places where I don't see it really improve any thing else -
> except of being pedantically correct.
>
> The reason for this argument is that the following lines of code is in
> the source tree already:
>
> (win/config.h.in)
> #ifndef X_OK
> #define X_OK 0
> #endif
>
> This is *well contained* inside the build tree which MSVS depends on.
> This build-platform does not define these macros at all. =C2=A0[RWX]_OK a=
re
> all defined in unistd.h, which is non-existent in non-POSIX compliant
> environment (basically what MSVS falls in under).
>
> So my point of view is that win/config.h.in covers the definition of the
> required macros which MSVS is lacking. =C2=A0Of course, it can be argued =
that
> such declarations should be in compat.h - as it a compatibility issue.
> For me that's a slightly different discussion.
>
> The OpenVPN code base is primarily written for the POSIX platform. =C2=A0=
MSVS
> is not a really POSIX friendly platform and mingw is somewhere in between
> - - but seems to be far more POSIX oriented than MSVS. =C2=A0We should fo=
cus on
> keeping the POSIX part of OpenVPN as pure as possible, from a POSIX point
> of view. =C2=A0And to be fair, the compat.[ch] files exists purely becaus=
e of
> the issues we have with MSVS.
>
> Bottom line is that I'm NACKing this patch, as it complicates things more
> than make things more clear. =C2=A0I do admit it is a more correct approa=
ch in
> its principles, but I don't like the complication it implies by
> "recasting" well defined POSIX macros.
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk9Cb38ACgkQDC186MBRfrqKhwCghAxMG/X+xKZdiy6gU9FR8Yhf
> n7oAnjxkrDDjpQngfM1TwTZgLkKVlmdH
> =3DVupy
> -----END PGP SIGNATURE-----

