Date: Thu, 18 Feb 2010 13:53:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100218125308.GZ9556@...1296...>
References: <4B7AE8D6.3020304@...1114...>
	<jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>
	<4B7BF17F.4080109@...1114...>
	<jwv1vgj4rnq.fsf-monnier+inbox@...1269...>
	<4B7D2A60.8040909@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B7D2A60.8040909@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Feb 18, 2010 at 12:54:08PM +0100, David Sommerseth wrote:
> The average user might have hits between 1 and 5 IP addresses
> (guestimate) on such a hostname lookups.  There are a few things I am
> concerned about in this regards.  Even though on my platform in_addr_t
> only needs 4 bytes, other platforms might use more.  If that platform is

in_addr_t is an IPv4 address, so I would be very surprised to see it require 
more than 4 bytes on any reasonable system.

[..]
> Remember that the memory which is allocated "static" in functions like
> you have done, are in the reality allocated dynamically when the
> function is called.  The advantage is this approach, is that it is
> easier for developers to write the code.  The developer don't need to
> care about explicit malloc() or calloc() calls, neither to free the
> memory afterwards.  The compiler does this job for you.  (Global
> variables on the other hand, are different in this regards, but that's
> another chapter.)

Just to nitpick on that: those variables are not malloc()'ed, they are
put on the stack.  Different area of the memory management -- but still
valuable on embedded systems, of course.

Since the openvpn server process is not multithreaded, there is no risk
of it happening "10 times in parallel", though.  So we lose 400 bytes
of stack space while getaddr() is called.


[..]
> 1) Make use of dynamic memory allocation
> You return number of IPs retrieved, so you know how much data to free
> later on.  You might also want to have a configuration parameter which
> can limit the amount IPs allowed to be processed.  This also gives users
> with restricted memory usage better control.

I see this specific case as "somewhat borderline" - adding dynamic
memory handling will save 400 bytes of stack space (good) but will bring
in extra code for sizing, allocating, and free()ing the memory, which
might well end up being in the same order of bytes of code space - and 
that's memory "lost forever".   And the risk of programmer error is higher...


> 2) Reduce MAX_IPS_PER_HOSTNAME and make this a default value.  Then make
> this number changeable via a configuration option (in options.c).  For
> me a reasonable default number would be 5 or 10 in this situation.

Getting configuration options propagated down all the way into a generic
function like getaddr() is either painful (lots of callers that might
themselves not have a pointer to the config struct around yet) or messy
(global variables).


Reading through this, my suggestion would be "go for a reasonable but
lower value", something like "20".  Still arbitrary, but brings down the
(transient!) memory used to 80 bytes, which is hard to beat with any sort 
of dynamic allocation scheme.


> * usage of get_random in getaddr() [socket.c:261]
> 
> I admit I should have spotted this one on the first review.  Because
> this code snippet below looks really odd to me.
> 
>   if (nb > 1)
>     {
>       msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d
> 			      addresses, choosing one at random",
> 	   hostname,
> 	   nb);
>       return ips[get_random () % nb];
>     }
> 
> 
> Why on earth do you want to use get_random() in this situation?  

That's original OpenVPN code, just moved to a different place.  

While I am not saying that it should be that way, or should not be that
way, it's not something brought in by the patch in question, so should
not be covered by its review.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

