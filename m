MIME-Version: 1.0
In-Reply-To: <20161225194114.GT78624@...1296...>
References: <20161219013949.19551-1-a@...2181...>
	<2fc5173c-b27b-3828-f227-e15687831667@...1856...>
	<20161225100901.GG8708@...2182...> <20161225125823.GI8708@...2182...>
	<20161225194114.GT78624@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 Dec 2016 21:40:30 +0100
Message-ID: <CAA1AbxK4tZB0jrjDCSswx04NhSbDcgKhBb5-yYje235QH33Jwg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

On 25 December 2016 at 20:41, Gert Doering <gert@...1296...> wrote:
> On Sun, Dec 25, 2016 at 08:58:23PM +0800, Antonio Quartulli wrote:
>> What is the general rule then? cron2 explained me on IRC that in the past some C
>> programs would crash when trying to print NULL, but it should not be
>> the case anymore (at least on Linux).
>
> As mentioned occasionally, we run on more than Linux.  So this is only
> safe if all supported platforms can handle
>
>   printf( "%s\n", NULL );
>
> correctly - Solaris, all the BSDs, MacOS, Windows(!), AIX.
>
> "It works on Linux" is good, but this is a "boolean and" condition - it
> needs to work on *all* supported platforms.
>
> I'm not generally opposed to modernizing the code, but the onus of
> recherching whether such a change is safe is on the proposer.

We use -std=c99, and according to C99, passing a NULL to printf()
results in undefined behaviour.  Excerpt from the C99 standard,
section 7.1.4 "Use of library functions":

"Each of the following statements applies unless explicitly stated
otherwise in the detailed descriptions that follow: If an argument to
a function has an invalid value (such as [...] or a null pointer,
[...]) or [...], the behavior is undefined."

The section about printf() does not state otherwise.

Some, most or all platforms we support might print "(null)", but I
don't think it's wise to rely on that.  So yes, if the pointer can be
NULL, I think we should check for it.  In this case, in particular
with the (new) wrapper, I think it is simpler to just check for NULL
then to figure out if the code can ever be passed a NULL pointer.  At
least the np() wrappers that are used seem to indicate that it might
be possible.

-Steffan

