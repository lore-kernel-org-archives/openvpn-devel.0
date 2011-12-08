Message-ID: <4EE0910F.8010108@...1114...>
Date: Thu, 08 Dec 2011 11:27:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<CAOazyz3B=PWg7jySe41p8KTZmWk87H0NM51EvkW1qKC1XPtSXA@...278...>
In-Reply-To: <CAOazyz3B=PWg7jySe41p8KTZmWk87H0NM51EvkW1qKC1XPtSXA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Move away from openvpn_basename() over
 to platform provided basename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/12/11 08:42, Alon Bar-Lev wrote:
> On Thu, Dec 8, 2011 at 1:46 AM, David Sommerseth <davids@...1347...>
> wrote:
>> 
>> This kicks out the openvpn_basename() function from misc.[ch]
>> andputs it into compat.[ch].  This is to provide the same
>> functionality on platforms not having a native basename() function
>> available.
>> 
>> In addition this patch adds dirname() which commit
>> 0f2bc0dd92f43c91e depends.  Without dirname(), openvpn won't build
>> in Visual Studio.
>> 
>> Signed-off-by: David Sommerseth <davids@...1347...>
> 
> Hello David,
> 
> The idea of compat.[hc] is to have system compatible layer. There
> should be no openvpn specific code in these. Just alternate
> implementation of missing functionality. It should be at the end of
> the chain in term of linkage.
> 
> So the "openvpn_dirbasename" should ether be copied to this file and 
> declared as static or provide a different simpler approach, 
> (strrchr('\\') or strrchr('/')).
> 

Hi Alon,

I'm not sure I understand the critique too well now.  As this is the
approach I tried to do.  However, I put the basename() and dirname()
implementations in compat.h, calling the combined openvpn_dirbasename()
function.

The reason for the combined version is basically to keep as much generic
code as possible.  And the old openvpn_basename() has been tested and
tried for many years, so that code base can be considered solid.  As you
know, the difference between dirname() and basename() is basically if you
return the string from the beginning to the split point, or from the
split point and to the end of the string.

But I can move the static inline functions from the compat.h file over to
the compat.c file, and declare openvpn_dirbasename() static instead.  If
that is a better solution.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7gkQ0ACgkQDC186MBRfrrK7wCfZUZbCF+8bJXApFpOipFsJ4xt
Tz0AoJH8GJV/XyirtQklBzYKOHOAXD7o
=XiV3
-----END PGP SIGNATURE-----

