Message-ID: <4DE923BF.3030409@...1114...>
Date: Fri, 03 Jun 2011 20:11:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1307102025-18627-1-git-send-email-davids@...1347...>
	<20110603172224.GC8496@...1296...>
In-Reply-To: <20110603172224.GC8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Remove support for Linux
 2.2	configuration fallback
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

On 03/06/11 19:22, Gert Doering wrote:
> Hi,
> 
> On Fri, Jun 03, 2011 at 01:53:45PM +0200, David Sommerseth wrote:
>> Considering that the last Linux 2.2 update was released 25-Feb-2004
>> and the first Linux 2.4 release came 04-Jan-2001, there are no
>> reasonable reasons to help users to stay on outdated kernels.
>> I consider this extra code path just waste of bytes ... so lets make
>> the world simpler.
> 
> Basically, I agree on the idea, but I think there's more that should
> be thrown out...
> 
> #if defined(TARGET_LINUX)
> 
> #ifdef HAVE_LINUX_IF_TUN_H      /* New driver support */
> 
> ...
> 
> #else
>           
> void  
> open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
> ntap *tt)
> {     
>   open_tun_generic (dev, dev_type, dev_node, false, true, tt);
> }     
>     
> #endif /* HAVE_LINUX_IF_TUN_H */
> 
> ...
> 
> /*
>  * This can be removed in future
>  * when all systems will use newer
>  * linux-headers
>  */
> #ifndef TUNSETOWNER
> #define TUNSETOWNER     _IOW('T', 204, int)
> #endif
> #ifndef TUNSETGROUP
> #define TUNSETGROUP     _IOW('T', 206, int)
> #endif
> 
> 
> and of course...
> 
> #if LINUX_IPV6 == 0
>   if ( tt->ipv6 )
>     msg (M_WARN, "NOTE: explicit support for IPv6 tun devices is not provided fo
> r this OS");
> #endif
> 
> 
> ... so: consider this an ACK, but there's more to do :-)

Thanks!  Yeah, this is just something I stumbled upon lately, but I saw
that there are more stuff which can be cleaned up!  I just take some
smaller steps :)  More to come when I got more time to look at it :)

> Now, what did we agree was the oldest linux distribution that we wanted
> to support?  Need to setup a VM with that, and then rip out stuff, and
> verify that things still compile, ...

I think James once said Red Hat Enterprise Linux 4.6.  However, the
officially supported RHEL4 release is to my knowledge 4.9.  That's based on
a Linux 2.6.9 kernel, iirc.


Kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3pI78ACgkQDC186MBRfroA8QCgiA23jM9MX7PGs4Y9IZ+Ml7cD
zp8AniNMOSLMVYBb/SBfA0+GVEvqBSaR
=hEeB
-----END PGP SIGNATURE-----

