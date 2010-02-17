Date: Wed, 17 Feb 2010 17:20:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100217162035.GS9556@...1296...>
References: <4B7BF370.8070807@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B7BF370.8070807@...1114...>
Subject: Re: [Openvpn-devel] [IPv6 support] - usage of gethostbyname() in
	getaddr()
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
Cc: Openvpn-devel@lists.sourceforge.net

Hi,

On Wed, Feb 17, 2010 at 02:47:28PM +0100, David Sommerseth wrote:
> When reviewing the patch "FQDN for routes should expand to all IPs"
> today, I spotted that there is a function called getaddr() (renamed to
> getaddr_all() in the mentioned patch).  This function again makes use of
> the old gethostbyname() function.  This is not compatible with IPv6
> addresses.

This is actually "existing code", and not something changed by the patch
(just to point that out to readers that have not reviewed the patch).


> I would strongly recommend a move to getaddrinfo() instead.  This is
> based on an article [1] written by Ulrich Drepper, who is a glibc
> maintainer.  Any thoughts about that?  It might even be more functions
> needing to be ported as well.  The mentioned article lists most
> important functions which should be ported to newer APIs.
> 
> Any comments on this issue would be appreciated.  Another issue is of
> course how this will influence other platforms than Linux.

Well, let me answer the second thing first (because I've spent a while
thinking about this and whether I want to make the IPv6 payload stuff
#ifdef'ed from the start).

On the Unix side of things, I'm fairly sure that any platform recent enough
to have tun/tap support (which isn't all of them, just *BSD, Solaris,
Linux and MacOS) also has getaddrinfo() and IPv6.

I don't know a thing about Windows programming, though.

OpenSSH tackles this by providing their own getaddrinfo() function (from
OpenBSD) if the system has no such function, or if it is broken, and
"configure" seems to do a good job in deciding what to do.


Now, on the question of whether we want / should use it.  Right now, the
"upstream" code only uses gethostbyname() because it wouldn't know what to 
do with an IPv6 record anyway, if any such record were to be returned - the 
code is used for connection handling (IPv4 only) and for setting routes 
to FQDN (again, IPv4 only).

In the long term, this whole area of the code will see some changes :-)
- when merging jjo's tree, we should already see use of getaddrinfo() for 
connection handling, and if people see the need for it, I might need to 
implement setting of IPv6 routes to FQDN targets.


So... if you'd ask me what I would to today, the answer would be "leave
the code as it is, merge jjo's code, and then revisit what he already
had to change for IPv6 connection handling".  If gethostbyname() is still
there, come back and make this lookup function v4- and v6-capable, and
implement FQDN routes for IPv6 :-)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

