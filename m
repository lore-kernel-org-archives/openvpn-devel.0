References: <1479163508-19435-1-git-send-email-davids@...515...>
	<c4d87247-460c-0860-5748-a62f0304653a@...1435...>
	<3ec6b9c8-7dcd-038c-6bbf-4b136a2e4507@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <ea910160-9005-8ca6-1af5-8594113944e2@...1435...>
Date: Wed, 16 Nov 2016 17:07:06 +0100
MIME-Version: 1.0
In-Reply-To: <3ec6b9c8-7dcd-038c-6bbf-4b136a2e4507@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ltf1JS0kseCv3CVmN3nuFbIQLQj5j3f3U"
Subject: Re: [Openvpn-devel] [PATCH] file checks: Merge
 warn_if_group_others_accessible() into check_file_access()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Ltf1JS0kseCv3CVmN3nuFbIQLQj5j3f3U
Content-Type: multipart/mixed; boundary="Xdaa4k0uqegPjMmPcwfkHrAo7wgAaXcQ4";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <ea910160-9005-8ca6-1af5-8594113944e2@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] file checks: Merge
	warn_if_group_others_accessible() into check_file_access()
References: <1479163508-19435-1-git-send-email-davids@...515...>
	<c4d87247-460c-0860-5748-a62f0304653a@...1435...>
	<3ec6b9c8-7dcd-038c-6bbf-4b136a2e4507@...2080...>
In-Reply-To: <3ec6b9c8-7dcd-038c-6bbf-4b136a2e4507@...2080...>

--Xdaa4k0uqegPjMmPcwfkHrAo7wgAaXcQ4
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16-11-16 15:59, David Sommerseth wrote:
> On 16/11/16 11:44, Steffan Karger wrote:
>> On 14-11-16 23:45, David Sommerseth wrote:
>>> Commit 825e2ec1f358f2e8 cleaned up the usage of
>>> warn_if_group_others_accessible() and moved it into options.c.
>>> At this point there is only one caller of this function,
>>> check_file_access().
>>>
>>> This takes that clean-up one step further and merges everything
>>> into check_file_access().  In addition it removes some no longer
>>> needed #ifdefs and uses platform_stat() to allow a similar check
>>> to happen on the Windows platform as well.
>>>
>>> Signed-off-by: David Sommerseth <davids@...515...> ---=20
>>> src/openvpn/options.c | 38
>>> ++++++++++++-------------------------- 1 file changed, 12
>>> insertions(+), 26 deletions(-)
>>>
>>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
>>> 4d31e4c..369f3f4 100644 --- a/src/openvpn/options.c +++
>>> b/src/openvpn/options.c @@ -57,6 +57,7 @@ #include "manage.h"=20
>>> #include "forward.h" #include "ssl_verify.h" +#include
>>> "platform.h" #include <ctype.h>
>>>
>>> #include "memdbg.h" @@ -2683,31 +2684,6 @@
>>> options_postprocess_mutate (struct options *o) */ #ifndef
>>> ENABLE_SMALL  /** Expect people using the stripped down version
>>> to know what they do */
>>>
>>> -/* - * Warn if a given file is group/others accessible. - */=20
>>> -static void -warn_if_group_others_accessible (const char*
>>> filename) -{ -#ifndef WIN32 -#ifdef HAVE_STAT -  if (strcmp
>>> (filename, INLINE_FILE_TAG)) -    { -      struct stat st; -
>>> if (stat (filename, &st)) -	{ -	  msg (M_WARN | M_ERRNO,
>>> "WARNING: cannot stat file '%s'", filename); -	} -      else -	{=20
>>> -	  if (st.st_mode & (S_IRWXG|S_IRWXO)) -	    msg (M_WARN,
>>> "WARNING: file '%s' is group or others accessible", filename); -
>>> } -    } -#endif -#endif -} - #define CHKACC_FILE (1<<0)
>>> /** Check for a file/directory precense */ #define CHKACC_DIRPATH
>>> (1<<1)    /** Check for directory precense where a file should
>>> reside */ #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is
>>> it writable? */ @@ -2754,9 +2730,19 @@ check_file_access(const
>>> int type, const char *file, const int mode, const char * if
>>> (platform_access (file, W_OK) !=3D 0) errcode =3D errno;
>>>
>>> +  /* Warn if a given file is group/others accessible. */ if
>>> (type & CHKACC_PRIVATE) { -      warn_if_group_others_accessible
>>> (file); +      platform_stat_t st; +      if (platform_stat
>>> (file, &st)) +	{ +	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat
>>> file '%s'", file); +	} +      else +	{ +	  if (st.st_mode &
>>> (S_IRWXG|S_IRWXO)) +	    msg (M_WARN, "WARNING: file '%s' is
>>> group or others accessible", file); +	} }
>>>
>>> /* Scream if an error is found */
>>>
>=20
>> Hm, I like the removal of the #ifdefs, but I don't think we should
>> merge warn_if_group_others_accessible() into check_file_access().
>> Why?
>=20
> That function is already fairly short, and these additional lines in
> the function doesn't add much.  And it falls perfectly within the
> scope of "check file access".  Had the scope for this function been
> broader and expected to be used more places, it would have a place as
> a separate function, IMO.
>=20
>> Because when it was a separate function, the code was
>> self-documenting and nicely separated.  Now, we need an extra
>> comment that basically exists of the previous function name to
>> explain what we're doing.
>=20
> The overall change reduces the lines of code with 14 lines.  Just 4 of
> them are #ifdef related.  And I personally find it easier to read a
> comment and then see instantly what happens below.  Otherwise you read
> a function name, guess what it does based on its name but don't know
> before you've located the function and read it.
>=20
> So when there's a benefit of reducing the total amount of lines, I
> value that even more.
>=20
> With that said, there are plenty of reasons why not to merge
> functions.  But from my point of view, the use scope for
> warn_if_group_others_accessible() is clearly defined and falls
> perfectly under the responsibility check_file_access() primarily
> should have.  And with just one caller, I think this approach is
> simpler and cleaner.

We clearly have different opinions here, so I guess we'll have to
discuss that further some time.  But as far as I'm concerned that should
not hold up this patch.

>> I was also wondering, have you tested that this work as expected
>> on Windows?  Since Windows has a quite different permission system.
>> Or will is simply never warn, like before?  That would be fine for
>> this patch.
>=20
> I do not have any Windows test environments, so I'll admit that's a
> bold (and risky) move of me.  However, as you've identified,
> S_IRWXG|S_IRWXO is not set so shouldn't cause any issues.

Combined with a compile-test I just this and the fact that the worst
thing that could happen is an incorrect warning (Windows builds never
warned before), I feel confident enough to ACK this:

ACK.

-Steffan


--Xdaa4k0uqegPjMmPcwfkHrAo7wgAaXcQ4--

--Ltf1JS0kseCv3CVmN3nuFbIQLQj5j3f3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYLIQqAAoJEEEwndWOY1w5THMIAI6CUOWVm5r+kgeF8W+v2j7w
SR0Ma8xsAGJf0p8lLET34gS8NZOhDM/LNFkm+97t0BTISLPo5a7TU2ZJGLOq4Rpy
UdccEicUGlG4naMkQmFo6l54caGsb7Jr/z0cZ9YDNGlHQmcC6YdSveJDzpefIy/V
TbtoLKWHzvAE+e+dG9NQTvaPP17UP2iIV5UQSPTySUCd0nhdGm2yGA+9xKfOdBcz
TOMv0TiZneAxEqBTzN3gYiEGrYyeaSLkgOETa2FOXVtzK7ugAmruJHh6auSi1lrO
IufoEL2R6RDIz7mETTVClbTtHk0C77cr0LNpWyArLtnONragBbjfmHCOGqv8VUo=
=ABHe
-----END PGP SIGNATURE-----

--Ltf1JS0kseCv3CVmN3nuFbIQLQj5j3f3U--

