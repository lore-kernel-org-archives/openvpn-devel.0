Message-ID: <4B7D4AC1.7010808@...1114...>
Date: Thu, 18 Feb 2010 15:12:17 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7AE8D6.3020304@...1114...>
	<jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>
	<4B7BF17F.4080109@...1114...>
	<jwv1vgj4rnq.fsf-monnier+inbox@...1269...>
	<4B7D2A60.8040909@...1114...>
	<20100218125308.GZ9556@...1296...>
In-Reply-To: <20100218125308.GZ9556@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/02/10 13:53, Gert Doering wrote:
> Hi,
> 
> On Thu, Feb 18, 2010 at 12:54:08PM +0100, David Sommerseth wrote:
>> The average user might have hits between 1 and 5 IP addresses
>> (guestimate) on such a hostname lookups.  There are a few things I am
>> concerned about in this regards.  Even though on my platform in_addr_t
>> only needs 4 bytes, other platforms might use more.  If that platform is
> 
> in_addr_t is an IPv4 address, so I would be very surprised to see it require 
> more than 4 bytes on any reasonable system.

True, I didn't think about that.  I actually thought of in_addr_t as a
struct, for some strange reason.  But you're right.

> [..]
>> Remember that the memory which is allocated "static" in functions like
>> you have done, are in the reality allocated dynamically when the
>> function is called.  The advantage is this approach, is that it is
>> easier for developers to write the code.  The developer don't need to
>> care about explicit malloc() or calloc() calls, neither to free the
>> memory afterwards.  The compiler does this job for you.  (Global
>> variables on the other hand, are different in this regards, but that's
>> another chapter.)
> 
> Just to nitpick on that: those variables are not malloc()'ed, they are
> put on the stack.  Different area of the memory management -- but still
> valuable on embedded systems, of course.

Correct!  Thanks for the nitpick!  Stack memory is anyway precious, on
some systems more than others depending on how stack allocation is done.

> Since the openvpn server process is not multithreaded, there is no risk
> of it happening "10 times in parallel", though.  So we lose 400 bytes
> of stack space while getaddr() is called.

As I said initially, in the current situation this might not be the
case.  But this part of OpenVPN will most likely see a change in the
future.  Not forked nor threaded applications scales very badly on
today's multi core systems.  So this comment was really meant as a
hands-up of a potential issue in the future.

> [..]
>> 1) Make use of dynamic memory allocation
>> You return number of IPs retrieved, so you know how much data to free
>> later on.  You might also want to have a configuration parameter which
>> can limit the amount IPs allowed to be processed.  This also gives users
>> with restricted memory usage better control.
> 
> I see this specific case as "somewhat borderline" - adding dynamic
> memory handling will save 400 bytes of stack space (good) but will bring
> in extra code for sizing, allocating, and free()ing the memory, which
> might well end up being in the same order of bytes of code space - and 
> that's memory "lost forever".   And the risk of programmer error is higher...

Good point!

>> 2) Reduce MAX_IPS_PER_HOSTNAME and make this a default value.  Then make
>> this number changeable via a configuration option (in options.c).  For
>> me a reasonable default number would be 5 or 10 in this situation.
> 
> Getting configuration options propagated down all the way into a generic
> function like getaddr() is either painful (lots of callers that might
> themselves not have a pointer to the config struct around yet) or messy
> (global variables).

Reasonable argument.  On the other hand, a hackerish approach it might
be considered to use a global variable in this case.  This setting
should only be read only, not changed and is a global setting.  Even
though, I'm not a big fan of global variables, I'm willing to consider
it in this setting.

> Reading through this, my suggestion would be "go for a reasonable but
> lower value", something like "20".  Still arbitrary, but brings down the
> (transient!) memory used to 80 bytes, which is hard to beat with any sort 
> of dynamic allocation scheme.

Good point!  But that's only valid as long as openvpn stays single
threaded.  On the other hand, this might be good enough for now.

>> * usage of get_random in getaddr() [socket.c:261]
>>
>> I admit I should have spotted this one on the first review.  Because
>> this code snippet below looks really odd to me.
>>
>>   if (nb > 1)
>>     {
>>       msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d
>> 			      addresses, choosing one at random",
>> 	   hostname,
>> 	   nb);
>>       return ips[get_random () % nb];
>>     }
>>
>>
>> Why on earth do you want to use get_random() in this situation?  
> 
> That's original OpenVPN code, just moved to a different place.  

Good catch, I honestly didn't see that move.  Sorry for the blame here,
Stefan!

> While I am not saying that it should be that way, or should not be that
> way, it's not something brought in by the patch in question, so should
> not be covered by its review.

Agreed.  Lets hear with James today if he see any reasons for using
get_random() in this situation.  It really do not see any advantage of
this at all.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt9Sr4ACgkQDC186MBRfrpVBwCdF31D+3Ta0ToKGIEuO06oFPqr
AkQAn06srxO1dXE62MW/EqLR7QOLuTZA
=ic3i
-----END PGP SIGNATURE-----

