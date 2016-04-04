From: Mike Auty <mike.auty@...277...>
References: <5701661B.80904@...277...> <20160404065418.GA53051@...1296...>
Message-ID: <5702CF6B.3000100@...277...>
Date: Mon, 4 Apr 2016 21:32:43 +0100
MIME-Version: 1.0
In-Reply-To: <20160404065418.GA53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 0/7] Vlan support for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/04/16 07:54, Gert Doering wrote:
> Hi,

Hello!

> On Sun, Apr 03, 2016 at 07:51:07PM +0100, Mike Auty wrote:
> Well.  Thanks for maintaining, and squashing this.

My pleasure!  5:)

> Overall, I think it's still too many patches - like the doc patch and the
> configure patch, these do not make sense on their own, so maybe squashing
> the patch set even further (after some feedback) might be the way to go.

Ah, I was worried about the patches being too big, the granularity for
other patches that have been past recently seemed very small, sorry, I'm
happy to squash it more.

> Usually we try to have patches in logical units - like, "one bug fix", or
> "one manageable chunk of refactoring", or "one new feature, with header,
> code, configure, and documentation".  Very complex new features do get
> spread across multiple patches, of course, but splitting off configure and
> documentatation does not really make sense - without documentation, the
> patch is incomplete, and the configure change without the code change is
> not useful.  Of course this is not a hard rule, but you might look at
> the commit log to get an idea how "this is usually done".

My reason for splitting the configure options and the documentation was
that they were extremely easy self-contained units (and they'd work
as standalone commits without disrupting any of the other code, but I
guess the #ifdefs do that too).

> I have not done a full review, but I noticed that at least for the 
> "is_ipv4()" patch, the documentation isn't correct anymore - it talks
> about is_ipv4(), but the function has been merged with IPv6 and is called
> is_ipv_X() - which the code change acknowledges, but the commit message
> doesn't.  Further, that particular change creates quite a bit of messy
> code - we do have a style guide, and the code should follow it (I'm aware
> that the original code is more "compact" than according to style guide,
> but when extending by extra branch levels, this gets non-pretty quickly).

Ok, thanks for spotting that, I must've grabbed the commit message from
an earlier commit because it seemed relevant.  I'll take a look at
what's going on and the style guide to see if I can sort the code (as
well as the documentation).

> 
> But these are all minor things - "the big thing" missing here is "the success
> story".  
> 
> So - what is it that you can do with it that you can not do with tun mode?  
> How would the configuration look like on the host side?  etc.  - please 
> describe this to an audience that has no idea whatsoever about vlan 
> stuff(*), and has mostly moved from tap mode to tun mode in the previous 
> years (since tun has less overhead, *and* both Android and iOS do not 
> support tap mode unless rooted).
> 
> So we have somewhat of a niche feature for a niche corner of OpenVPN 
> (tap mode) - which will land on our plates for maintenance if we take it,
> and the balance between "useful new code" and "maintenance chore" needs
> to be on the side of "useful"...
> 
> Right now, we have about 47123 strange options and compile-time features
> that hardly anyone is using, but every time we change one of the more
> mainstream features in a bigger way, one of the exotic things breaks
> (and we feel stupid about it).  Which makes us a bit reluctant about adding
> new "special feature" code.

Yep, I understand there's a maintenance cost associated with adding the
code to the project, but it's the maintenance cost of layer 3 management
that this is trying to offset somewhat.  Layer 2 VPNs, whilst
potentially less efficient due to additional traffic (is there another
reason the tap adaptor is less efficient?), allow for simpler management
and configuration, and do not require significant changes to the VPN
configuration if the network topology changes.

We've implemented 802.1x with dynamic vlan assignment already, meaning
that when a user connects either wired or wirelessly they get shunted
into the appropriate segment of the network (and potentially into
overlapping subnets).  This ensures strong segregation based on their
identity/certificate.  So we really want to plug openvpn into that and
allow users a single certificate to always end up in their same
segregated section of the network without having to create separate VPN
subnets for them.  This can be achieved using Fabian's patches and the
following server config (with no changes to the client software or config!):

vlan-tagging
vlan-accept tagged
client-connect /path/to/radius_auth_script.sh

The radius auth script would echo out "vlan-pvid 2", for example, for a
user who belongs in vlan 2, whilst it will push a different user into
vlan 3 if appropriate.  It means that users can talk within their own
VLAN but not with everybody using the VPN (which at the moment
client-to-client won't allow, and would be complex firewall rules
otherwise).  This also allows us to use a single trunk port, rather than
having to split all the various networks out into their own connections
to feed into the VPN server or for us to run multiple VPN servers on
different ports/IPs for different sets of users.

So our users see a single VPN configuration, connect with their existing
certificates, and end up in the network they expected to with DHCP
provided by the network itself (allowing us to change DNS servers,
routers, etc from a single central point rather than distributing that
information out to DHCP servers and openvpn servers, etc).

It would be possible, but in our opinion much more of a burden, to
implement, manage and maintain a single endpoint in tun mode that could
achieve the same effect, and make use of the existing network topology
that we're already using.  I'd like to think this capability ranks over
some of the existing 47123 strange options that have already been
accepted into OpenVPN in terms of usefulness, and that's just my
use-case scenario alone.

Allowing bridged mode to have knowledge of vlan tags and be able to
manipulate them based on the user is an advanced, but extremely valuable
facility that I was genuinely surprised OpenVPN didn't already have,
given its flexibility.  These existing, tested patches would add that
support.

Hopefully that sounds like a success story?  5:)

> gert
> 
> (*) I do understand VLANs - being a network guy - but I'm missing the 
> big picture "how would the configuration on the host and client (and ccd/)
> side look like?  what can you do with it?  why is this cool?"
> 
> PS: I promise a more detailed review per-chunk, so don't send new patches
> yet.  I'm not making promises which month this is going to happen - sorry.
> 

It'll take me a bit of time to get the changes requested done too, but
thank you for reviewing these, it's much appreciated.  5:)

Mike  5:)

