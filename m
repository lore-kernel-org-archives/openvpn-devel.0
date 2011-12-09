Message-ID: <4EE2289D.3090507@...1114...>
Date: Fri, 09 Dec 2011 16:26:21 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
	<20111209080212.GC18948@...1296...>
In-Reply-To: <20111209080212.GC18948@...1296...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(resent - go get it into the mailing list too)

On 09/12/11 09:02, Gert Doering wrote:
> Hi,
> 
> On Thu, Dec 08, 2011 at 04:24:20PM +0100, David Sommerseth wrote:
>> This kicks out the openvpn_basename() function from misc.[ch] and 
>> puts glibc equivalents into compat.[ch].  This is to provide the 
>> same functionality on platforms not having a native basename() 
>> function available.
>> 
>> In addition this patch adds dirname() which commit 0f2bc0dd92f43c91e
>> depends.  Without dirname(), openvpn won't build in Visual Studio.
>> 
>> v2: Move all functions from compat.h to compat.c v3: Use glibc 
>> versions of basename() and dirname() instead
> 
> ACK for the dirname() part.
> 
> I'm not particularily happy with the basename() changes, though.
> 
>> --- a/init.c +++ b/init.c @@ -862,8 +862,10 @@ init_verb_mute 
>> (struct context *c, unsigned int flags) void init_options_dev 
>> (struct options *options) { -  if (!options->dev) -    options->dev 
>> = openvpn_basename (options->dev_node); +  if (!options->dev && 
>> options->dev_node) { +    char *dev_node = 
>> strdup(options->dev_node); /* POSIX basename() implementaions may 
>> modify its arguments */ +    options->dev = basename (dev_node); + }
>> }
> 
> These changes, just to take into account some system somewhere that 
> has a basename() implementation that modifies the argument string, are
> ugly, and prone to memleak-errors.  Also, some other "basename(3)" man
> pages talk about basename() returning a pointer to an internal static
> storage which can be overwritten at the next call - so the code above
> would then not work on such a system (as the next call to basename()
> would modify the memory are where options->dev is pointing to).

For the record, I did some valgrind checks on this change.  And for some
odd reason, this doesn't leak.  Even though --dev-node is explicitly set.
 But it might be that the gc_* magic functions somehow catches this
allocation as well.

Also note that init_options_dev() is only called once during the
execution, and this allocation *only* happens if --dev-node is used.

And the only reason I say this is to try to avoid posting a v4 patch ;-)

> So I'd propose to keep openvpn_basename() - it's simple and short 
> enough, and has well-defined semantics that can be relied upon.

The original openvpn_basename() is based upon the GNU basename() which is
not modifying any arguments, so this is definitely cleaner.

> OTOH, David's compat.c basename() is nicer than what we currently
> have - so let's use that implementation, but let's call it 
> openvpn_basename().

If there's a vote for a v4 version of this patch, I would then move this
one out of compat.c and back to misc.c ... and add the code which tackles
both / and \ in the same code.

*BUT* this will cause a nasty feature breakage, with tackling both / and
\.  As this will then work everywhere openvpn_basename() is used.  But
wherever dirname() is used in the code, it will be platform defined /
*or* \ ... or in case of lack of dirname() it will use both (Windows).

Which again, in my head, speaks for openvpn_dirname() as well ...

However, Windows is the platform which first of all needs to tackle both
/ and \, as it is possible to use both variants, afaik.


David S.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7iKJsACgkQDC186MBRfrq0VQCcC8P5Um4RkZbXwGH4ENMbJugs
MIkAn2ta/cC7ufmiSEMO1JOYBW1L0Jp0
=C+WB
-----END PGP SIGNATURE-----

