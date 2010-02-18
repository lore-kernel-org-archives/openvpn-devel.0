Message-ID: <4B7D2A60.8040909@...1114...>
Date: Thu, 18 Feb 2010 12:54:08 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7AE8D6.3020304@...1114...>	<jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>	<4B7BF17F.4080109@...1114...>
	<jwv1vgj4rnq.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwv1vgj4rnq.fsf-monnier+inbox@...1269...>
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
To: Stefan Monnier <monnier@...1268...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/02/10 20:27, Stefan Monnier wrote:
>> Thanks a lot for you patch!  In general, it very looks good.  Can you
>> elaborate a little bit on how you have tested this patch?
> 
> I've been using it on my client machines for the last few months.
> This is not a very extensive test, obviously: they're all configured
> identically and so they all lookup the same FQDNs received from the same
> VPN server.
> 
>> Have you checked it for memory leaks?  (e.g. using valgrind)
> 
> No, my patch does not use dynamic memory allocation, so memory leaks
> seem unlikely (tho I don't know enough of the functions I call to be
> 100% sure).
> 
>> What happens if no FQDNs are found?
> 
> I have not touched this part of the code, AFAIK, so the behavior should
> be the same as before (not sure what it is).

Hi Stefan,

I've gone through parts of your code more carefully again, looking *how*
you solve things, not just if it is following coding standards, how it
merges, and the obvious pitfalls which can cause troubles.  And I chose
to do this after you in another mail thread said "[I'm] Not a network
programmer by a long shot, just a user who needed a specific feature".
This statement raised my attention and made me a bit more concerned ;-)


* Memory allocation

You are right in regards to dynamic memory allocation.  You're using
static array allocation, defined by MAX_IPS_PER_HOSTNAME.  This value is
set to 100.  Where did you take this number from?  IMHO, that sounds to
be fairly high.

The average user might have hits between 1 and 5 IP addresses
(guestimate) on such a hostname lookups.  There are a few things I am
concerned about in this regards.  Even though on my platform in_addr_t
only needs 4 bytes, other platforms might use more.  If that platform is
an embedded device with even limited available memory, 400 bytes can be
much.  This can especially be hurtful in such environments if more
connections hit this function in about the same time.  For example, if
10 connections/clients does this call in parallel, it will suddenly
require 4000 bytes.

Remember that the memory which is allocated "static" in functions like
you have done, are in the reality allocated dynamically when the
function is called.  The advantage is this approach, is that it is
easier for developers to write the code.  The developer don't need to
care about explicit malloc() or calloc() calls, neither to free the
memory afterwards.  The compiler does this job for you.  (Global
variables on the other hand, are different in this regards, but that's
another chapter.)

On the other hand, it might be that the scheduler (event handler) in
OpenVPN won't trigger multiple calls to getaddr(), but that's in its
current state.  This can change, and then this function should be safe
in that regards as well.  TBH, I believe this serialised behaviour of
the scheduler in OpenVPN needs to change in the future, to improve the
performance.

I have two suggestions how to work around this:

1) Make use of dynamic memory allocation
You return number of IPs retrieved, so you know how much data to free
later on.  You might also want to have a configuration parameter which
can limit the amount IPs allowed to be processed.  This also gives users
with restricted memory usage better control.

2) Reduce MAX_IPS_PER_HOSTNAME and make this a default value.  Then make
this number changeable via a configuration option (in options.c).  For
me a reasonable default number would be 5 or 10 in this situation.


* usage of get_random in getaddr() [socket.c:261]

I admit I should have spotted this one on the first review.  Because
this code snippet below looks really odd to me.

  if (nb > 1)
    {
      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d
			      addresses, choosing one at random",
	   hostname,
	   nb);
      return ips[get_random () % nb];
    }


Why on earth do you want to use get_random() in this situation?  Why not
always return ips[0]?  Fair enough, the warning may stay, just adjusting
it saying it will return the first IP address it resolved.  Maybe it
should be a possibility to mute this warning as well, somehow, as this
might not need to be an error, and with a lot of traffic this warning
could be rather annoying log trash.

Another trap here is that you in init_route() [route.c:282] use both
getaddr_all() and getaddr().  How do you make sure that you don't set
the wrong netmask against the different IP addresses returned by
getaddr_all()?  I might have misunderstood the code here, but please
explain what is happening here.


* Copyright notes

According to the GPL license, you are allowed to add your a copyright
statement at the top of the file in addition to the the OpenVPN
Technologies, Inc copyright note.  If you also add a simple sentence
describing the change, that would also be good.


At least these two first things needs to be fixed, IMHO, before we can
include it into a testing tree.  I'm sorry for now withdrawing my
initial and quite positive attitude for an ACK.  But we need to have a
few more rounds on this code, I see now.



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt9KlwACgkQDC186MBRfrpzXACfTf2A7yF2O0K0Ek8+/VnFLJWq
ZW4AoIDMuIuqGF+wRzBMP+xVC8KevYe5
=8z/v
-----END PGP SIGNATURE-----

