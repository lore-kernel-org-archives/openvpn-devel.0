Date: Fri, 5 Mar 2010 16:13:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100305151349.GK25238@...1296...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
	<20100304213523.GF25238@...1296...>
	<1267744903417725500@...1315...>
	<20100305080138.GG25238@...1296...>
	<1267800137.8210.25.camel@...23...>
Mime-Version: 1.0
In-Reply-To: <1267800137.8210.25.camel@...23...>
Subject: Re: [Openvpn-devel] Openvpn 2.1.1 bad tcp performance but good
	pingwhen -l 1472 (with packet size = MTU)
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
To: "Michael H. Warfield" <mhw@...1243...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Mar 05, 2010 at 09:42:17AM -0500, Michael H. Warfield wrote:
> Oh WOW...  I hadn't even thought of that.  That's got to be the A #1
> reason right there for avoiding the use of tcp like the plague for
> things like these.
> 
> That means that OpenVPN is (to use the older terminology - I'm old
> school) not using the PUSH OOB method to push packets out and to get
> them received immediately at the other end.  Looking that the

I'm not sure what OpenVPN *is* doing internally.  I was just assuming that
the TCP_NODELAY (nagle) would affect performance for "half-full" packets
(as observed).

Since TCP_NODELAY is not having an effect here, it might be worth a look 
into the sources to see that it's done correctly with TCP_PUSH.

*I* am not going to do that any time soon, though - I'm not using 
VPN-over-TCP, and digging through the socket code of OpenVPN is fairly
far down on my "what to do with OpenVPN in my spare time" list.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

