Date: Thu, 23 Nov 2006 08:20:08 +0100
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20061123072008.GA21251@...33...>
References: <20061114051638.GA32116@...887...>
MIME-Version: 1.0
In-Reply-To: <20061114051638.GA32116@...887...>
Subject: Re: [Openvpn-devel] On the way from tun0 to eth1,
	packets	disappearing.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Mon, 13 Nov 2006, H.Shrikumar wrote:

> I have been trying to set up openvpn to cross-connect two LANs
> together. I have a slightly complicated goal, and I believe
> I have it almost(!) working, except that at one point, the
> packets vanish without a trace. And it seems to vanish in the
> kernel, of all places, which is rather puzzling!!
> 
> I have two LANs, and two identical routers (soekris/picodebian
> linux boxes) connecting them together. Each has a openvpn
> server and an openvpn client, connecting cross to the other. (I
> have also tried it with just one link, but my problem is not
> solved. Further, I think I need the symmetrical cross-connect
> for a bunch of other reasons -- so unless this is a no-no,
> please humour me).

Strange - I find that as long as the routers have static addresses, one
process on either side is sufficient since either one can reestablish
the connection. But this is more for the -users list.

Did you try using a "tap" connection (on Linux, be sure you're using the
tun module - which includes the tap driver -, not ethertap -- the
framing of the latter is incompatible with OpenVPN), or are there
reasons not to do that?

I have two LANs connected with routing (i.  e. tun) with only one
OpenVPN process running on either side, works for me (on SUSE Linux
10.0).

> But when I ping host to host -- from 172.20.0.13 to 172.20.0.11
> (ie. it has to come from LAN to Router, then over openvpn,
> then encrypted to the far router and out to the LAN there),
> something wierd happens. The packet disappears!

> Another observation : very similar ... lets ping directly from
> the router to the host on the other LAN, but with different
> source address (which also means the ping goes out on the
> other tun).
> 
> On Router-America:
> 
> ping 172.20.0.11  as well as,
> ping -I tun1 172.20.0.11  -- goes out on tun1, replies come on tun1, and works.
> 
> ping -I tun0 172.20.0.11  -- goes out on tun0, replies come on tun0, ... 
>   ... but, never deliver from tun0 to the locally running ping process!!
> 
> Is the kernel eating up the packet?

Perhaps - to defang packets with forged source address, the kernel drops
them if they are coming in via the wrong interface. The Linux
terminology is "martian", like this:

kernel: martian source 192.168.178.1 from 192.168.0.1, on dev eth1

There are sysctls to enable source route filtering - check
net.ipv4.conf.*.log_martians if logging is enabled at all. The sample
message was captured when OpenVPN hadn't noticed some link change.
Restarting OpenVPN cured them in my case.

-- 
Matthias Andree

