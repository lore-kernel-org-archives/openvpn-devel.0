References: <1479163508-19435-1-git-send-email-davids@...515...>
	<c4d87247-460c-0860-5748-a62f0304653a@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3ec6b9c8-7dcd-038c-6bbf-4b136a2e4507@...2080...>
Date: Wed, 16 Nov 2016 15:59:18 +0100
MIME-Version: 1.0
In-Reply-To: <c4d87247-460c-0860-5748-a62f0304653a@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] file checks: Merge
 warn_if_group_others_accessible() into check_file_access()
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/11/16 11:44, Steffan Karger wrote:
> Hi,
>=20
> On 14-11-16 23:45, David Sommerseth wrote:
>> Commit 825e2ec1f358f2e8 cleaned up the usage of
>> warn_if_group_others_accessible() and moved it into options.c.
>> At this point there is only one caller of this function,
>> check_file_access().
>>=20
>> This takes that clean-up one step further and merges everything
>> into check_file_access().  In addition it removes some no longer
>> needed #ifdefs and uses platform_stat() to allow a similar check
>> to happen on the Windows platform as well.
>>=20
>> Signed-off-by: David Sommerseth <davids@...515...> ---=20
>> src/openvpn/options.c | 38
>> ++++++++++++-------------------------- 1 file changed, 12
>> insertions(+), 26 deletions(-)
>>=20
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
>> 4d31e4c..369f3f4 100644 --- a/src/openvpn/options.c +++
>> b/src/openvpn/options.c @@ -57,6 +57,7 @@ #include "manage.h"=20
>> #include "forward.h" #include "ssl_verify.h" +#include
>> "platform.h" #include <ctype.h>
>>=20
>> #include "memdbg.h" @@ -2683,31 +2684,6 @@
>> options_postprocess_mutate (struct options *o) */ #ifndef
>> ENABLE_SMALL  /** Expect people using the stripped down version
>> to know what they do */
>>=20
>> -/* - * Warn if a given file is group/others accessible. - */=20
>> -static void -warn_if_group_others_accessible (const char*
>> filename) -{ -#ifndef WIN32 -#ifdef HAVE_STAT -  if (strcmp
>> (filename, INLINE_FILE_TAG)) -    { -      struct stat st; -
>> if (stat (filename, &st)) -	{ -	  msg (M_WARN | M_ERRNO,
>> "WARNING: cannot stat file '%s'", filename); -	} -      else -	{=20
>> -	  if (st.st_mode & (S_IRWXG|S_IRWXO)) -	    msg (M_WARN,
>> "WARNING: file '%s' is group or others accessible", filename); -
>> } -    } -#endif -#endif -} - #define CHKACC_FILE (1<<0)
>> /** Check for a file/directory precense */ #define CHKACC_DIRPATH
>> (1<<1)    /** Check for directory precense where a file should
>> reside */ #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is
>> it writable? */ @@ -2754,9 +2730,19 @@ check_file_access(const
>> int type, const char *file, const int mode, const char * if
>> (platform_access (file, W_OK) !=3D 0) errcode =3D errno;
>>=20
>> +  /* Warn if a given file is group/others accessible. */ if
>> (type & CHKACC_PRIVATE) { -      warn_if_group_others_accessible
>> (file); +      platform_stat_t st; +      if (platform_stat
>> (file, &st)) +	{ +	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat
>> file '%s'", file); +	} +      else +	{ +	  if (st.st_mode &
>> (S_IRWXG|S_IRWXO)) +	    msg (M_WARN, "WARNING: file '%s' is
>> group or others accessible", file); +	} }
>>=20
>> /* Scream if an error is found */
>>=20
>=20
> Hm, I like the removal of the #ifdefs, but I don't think we should
> merge warn_if_group_others_accessible() into check_file_access().
> Why?

That function is already fairly short, and these additional lines in
the function doesn't add much.  And it falls perfectly within the
scope of "check file access".  Had the scope for this function been
broader and expected to be used more places, it would have a place as
a separate function, IMO.

> Because when it was a separate function, the code was
> self-documenting and nicely separated.  Now, we need an extra
> comment that basically exists of the previous function name to
> explain what we're doing.

The overall change reduces the lines of code with 14 lines.  Just 4 of
them are #ifdef related.  And I personally find it easier to read a
comment and then see instantly what happens below.  Otherwise you read
a function name, guess what it does based on its name but don't know
before you've located the function and read it.

So when there's a benefit of reducing the total amount of lines, I
value that even more.

With that said, there are plenty of reasons why not to merge
functions.  But from my point of view, the use scope for
warn_if_group_others_accessible() is clearly defined and falls
perfectly under the responsibility check_file_access() primarily
should have.  And with just one caller, I think this approach is
simpler and cleaner.

> I was also wondering, have you tested that this work as expected
> on Windows?  Since Windows has a quite different permission system.
> Or will is simply never warn, like before?  That would be fine for
> this patch.

I do not have any Windows test environments, so I'll admit that's a
bold (and risky) move of me.  However, as you've identified,
S_IRWXG|S_IRWXO is not set so shouldn't cause any issues.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYLHRGAAoJEIbPlEyWcf3yHrEP/3ETuMw700Aw1qU0NFtfyA1X
rFyx7cn4HWaKSnb15b/I5SaniG2frh/dfFmSudbm1SZIbS+tFMV33HL0Rrzca+f7
pyAQsbOVFcvuG7dZrbutUCZ7v19d93xkYr06Z1ceHtuG1pqa0ZiVow7eKiHzxjnG
yNmYqbuPRzgiMnXkA1Nd3toaeGO6ee6hPnKHWUdIg/UWFmDJqnYac3ErC+jNuzB8
jaSzGXTAIpj7O/R4B4pkzd+La1nnsUce0iAeEw9EUpFQN9VxaJ8+28MscsQIiKg7
AAPLFHCWuZEw2WENTvpRvT4pTYfaztb8sxDLt8GO31x8MHR8c8t4i76u6T9ma73Q
mSTGcErALkR4zaxn9BSbXZLrxsBFZeWCM5WfGcD5lVQCQrQC4zPBVhUvaL9Sq1vi
oEEVcavBvjN2yGzuQQQ8k6fNAjKhD2VETKY11RpWxuo2L/YiEVKigu0O1mt6FiBU
2a9LnBctsx0a5jPGmHg1fb1AlLh+F/DqsKjIlXxG7TwECAkam4PCJsG9j3hs/77/
fXVsgkjdxNQwEA+ZrzoCiMIy3YCxphiMg38jXnoVmY5T2uk3n0Uhutk356F06egK
233aA3eI+p060UCwPY/RK7KXAfHt6ivGAVMHUOdOqQM3NKlBEPaLiR8U8FDwfvqk
SXZsoYN0NzuurabdSefK
=3DIkUh
-----END PGP SIGNATURE-----

