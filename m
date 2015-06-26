Message-ID: <558D2D98.70905@...1516...>
Date: Fri, 26 Jun 2015 12:46:48 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
	<20150626073544.GT382@...1296...>
In-Reply-To: <20150626073544.GT382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Hello Gert,

Am 26.06.2015 um 09:35 schrieb Gert Doering:
> Hi,
>
> On Thu, Jun 25, 2015 at 06:01:20PM +0200, Holger Kummert wrote:
>> When a linux tun interface is closed (e.g. on disconnect)
>> an optional ipv6 addr that was previously set is deleted now.
>> Without this patch a later reconnect would fail with
>> 'Linux ip -6 addr add failed: external program exited with error status: 2'
>> and openvpn would exit.
>
> There is a trac ticket to that extent already (trac #141,
> http://community.openvpn.net/openvpn/ticket/141) - so thanks for the
> patch :-)
>
> I'm not sure I fully understand that usage scenario - which is one of
> the reasons why that ticket did not proceed.
>
> If you use normal nonpersistant tun interfaces, openvpn will destroy the
> tun interface at exit, removing the IPv6 address in the process.
>
> If you use *persistant* tun interfaces, this is usually done for a reason,
> like "bind (nameserver) cannot bind to new interface addresses because
> it is running without privileges" - but in this case, we should not remove
> the address (because then it's gone...) - and arguably not add it either,
> because it should already be there - because if not, the argument with
> "other software needs this address" is moot.
>
>
> So - help me understand the scenario.  Why are you using persistant tun
> interfaces but want dynamically added and removed addresses?

well, I pass the device name on the command line of the call of openvpn
because I need explicit named tun-devices for firewalling purposes
(the firewall on the system also needs to know the name of the device in 
use).
So it's created on start of openvpn.
After exiting openvpn the device will be brought down.

There are no additional services depending on the tun device except
the firewall which is in charge for the device only if the tunnel
is established.

So the tun device is merely used like a dynamic one, but with a fixed name.

>
> (I can see that OpenVPN misbehaves but I'm not sure I understand what
> "the best" solution should be - maybe go for "if that address is already
> there, do not touch it, otherwise, remove existing address and add
> new one" instead?)

Your proposal would probably also do the job. I didn't dive deeply into
the dependencies
but just adjusted the behavior of handling ipv6 addresses to the handling of
ipv4 addresses on the device.

With the provided patch the handling is at least symmetric for ipv4 and 
ipv6 and works in the described
case (and would also work for the setup as described in trac #141).


Best regards,
Holger

>
> gert
>

