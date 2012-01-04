Message-ID: <4F043F02.4070109@...1114...>
Date: Wed, 04 Jan 2012 12:58:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4ECC6EE6.5050709@...1388...>
	<20111230191255.GF5060@...1296...>
	<20111230202120.GH5060@...1296...>
In-Reply-To: <20111230202120.GH5060@...1296...>
Subject: Re: [Openvpn-devel] Problems with add_route_ipv6()
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

On 30/12/11 21:21, Gert Doering wrote:
> Hi,
> 
> On Fri, Dec 30, 2011 at 08:12:56PM +0100, Gert Doering wrote:
>> On Wed, Nov 23, 2011 at 04:56:22PM +1300, Michal Ludvig wrote:
>>> I'm using the latest openvpn from GIT on OpenSUSE 11.4 and am 
>>> experiencing a problem with IPv6 payload setup. It works but
>>> openvpn seems to be somewhat confused when setting up the v6
>>> route.
> [..]
>> Bug.  For workarounds, see above :-) and a patch will follow as soon
>> as I have cornered the bug (or have understood why this is not
>> happening for IPv4).
> 
> "lazy coder error".  OpenVPN in p2mp client mode saves certain(!)
> options before pulling options from the server (pre_pull_save() etc.
> in options.c) and this only happened for IPv4 - because, when adding
> IPv6 support, I just overlooked this code path.
> 
> So on reconnection, the IPv4 "route_option_list" was reset, and the 
> corresponding IPv6 "route_ipv6_option_list" wasn't - and thus, all
> the IPv6 routes were added to whatever was pushed by the server
> previously, leading to duplicate routes.
> 
> A patch is attached.  I have tested this here for various cases, and 
> with the patch, the problem is gone (as expected) and I haven't seen 
> any adverse cases.
> 
> Michal, if you could test that this fixes the problem for you, it
> would be great.
> 
> David, this patch is pretty much straightforward duplication of the 
> corresponding IPv4 code path.  It needs helpers in route.c, thus the 
> patch is somewhat bigger than expected...  but it should be "fairly 
> easy" to review.
> 

ACK.  Applied to master branch on -testing and -stable trees.

commit 9140223643f7d9bdfd2214304a7bd6ab4b662f97
Author: Gert Doering <gert@...1536...>
Date:   Fri Dec 30 21:08:49 2011 +0100

    Fix build-up of duplicate IPv6 routes on reconnect.

    options.c: extend pre_pull_save() and pre_pull_restore() to
           save/restore options->routes_ipv6 as well
    options.h: add routes_ipv6 to "struct options_pre_pull"
    route.h, route.c: add clone_route_ipv6_option_list() and
           copy_route_ipv6_option_list() helper functions

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8EPwAACgkQDC186MBRfrr2ZQCdH78BvqhxhOmJEI3Ur+3/q7XN
mwwAn25WhXEoQZa1PIkbW5H3sVTN1NDM
=jLpt
-----END PGP SIGNATURE-----

