From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
In-Reply-To: <20050425104620.V15659@...283...>
Message-ID: <Pine.LNX.4.58.0504251102160.14285@...41...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...><20050420091539.C21
 <20050420091539.C21450@...283...>
 <Pine.LNX.4.58.0504201125560.14131@...41...><20050420141742.B1503@...381...
 <20050420141742.B1503@...283...> <Pine.LNX.4.58.0504211811260.14131@...41...>
 <20050425104620.V15659@...283...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Apr 25 10:26:18 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: JuanJo Ciarlante <jjo-ipsec@...283...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 25 Apr 2005, JuanJo Ciarlante wrote:

> On Thu, Apr 21, 2005 at 06:27:03PM -0600, James Yonan wrote:
> > I would like to merge your IPv6 patch into the 2.1 branch, once it gets 
> > started (I'd like to keep the 2.0.x branch as stable as possible, with 
> > minimalistic changes that don't go beyond bug fixes and small patches).
> > 
> > One potential speed bump will be in merging both IPv6 + the multihomed 
> > patch which will definitely be going into 2.1:
> > 
> > http://openvpn.net/patch/openvpn-2.0_rc16MH.patch
> > 
> > Because both patches touch much of the same code, there will likely be a
> > need for manual merging.
> 
> Ok ... indeed I tested "patch --dry ..." and shouted about 80% rejects.
> I could merge both in my own CVS, but because it's a rather daunting task, 
> I would like to be sure it's a productive one :-) ie. that it will have a
> high chance to be merged , of course, if resulting patch quality qualifies.

The MH (multihomed) patch has a near 100% chance of being merged, since it
is necessary for OpenVPN to operate properly as a multihomed server.  Here 
is more info about it:

http://openvpn.net/archive/openvpn-users/2005-02/msg00640.html

The important thing in doing the merge is not so much to make the
multihomed feature work with IPv6 (right away) as it is to do the correct 
accounting and authentication of both source and destination address of 
received packets (without this patch, OpenVPN does not keep track of 
destination IP address of received packets when running in a multi-homed 
context).

I think it's a fairly high priority to get your IPv6 patch + MH + the 
BETA2.0-THREAD branch in the CVS merged as a baseline for 2.1.  I don't 
expect the BETA2.0-THREAD code to conflict either with the MH or IPv6 
patches.  I'd be glad to work with you on this, as I am also interested in 
extending the IPv6 support to allow IPv6 tunnels over OpenVPN in 
client/server mode (right now, IPv6 tunnels are only supported in 
point-to-point mode).

Incidentally, does your IPv6 patch affect performance when it is inactive, 
i.e. when IPv4 is being used?

Thanks,
James


