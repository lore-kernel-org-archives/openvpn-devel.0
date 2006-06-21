Date: Wed, 21 Jun 2006 10:14:44 +0200 (CEST)
From: Mathias Sundman <mathias@...454...>
In-Reply-To: <000401c6947d$c10cc420$1601a8c0@...576...>
Message-ID: <Pine.LNX.4.64.0606211002070.31137@...210...>
References: <000401c6947d$c10cc420$1601a8c0@...576...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] DHCP on PocketPC port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Dave <dev@...575...>
Cc: 'Christer Lindell' <christer.lindell@...341...>, 'Kenneth Karlsson' <kenneth.karlsson@...341...>, openvpn-devel@lists.sourceforge.net

On Tue, 20 Jun 2006, Dave wrote:

> That's wild, and I haven't seen that behaviour with my bridging setup.  I
> do use bridging and do have a DHCP server inside the LAN.  I'll study the
> code to see if I introduced a bug though causing the DHCP packet to get
> forwarded even when it is processed.  It's possible, and your workaround
> with the firewall rules tends to indicate that it is likely.
>
> I do know many (most?) folks are using this configuration successfully --
> if for no other reason than because it used to be broken and there were
> complaints at that time.  It's possible that the problem is masked in the
> usual case and your device makes the problem visible.  What device are you
> using?

Qtek 2020i with Windows Mobile PocketPC 2003 SE.

> Also, how are you determining that there are two addresses on the TAP
> device?

Viewing the "Net" tab on the TAP device.

I just realized we're not using the latest version of your port. Have you 
done any changes in the code that could/should affect this in the latest 
relases? We'll update anyway and let you know if it makes any difference.

Cheers // Mathias

>> -----Original Message-----
>> From: openvpn-devel-bounces@lists.sourceforge.net
>> [mailto:openvpn-devel-bounces@lists.sourceforge.net] On
>> Behalf Of Mathias Sundman
>> Sent: Tuesday, June 20, 2006 9:10 AM
>> To: openvpn-devel@lists.sourceforge.net
>> Cc: Christer Lindell; Kenneth Karlsson
>> Subject: [Openvpn-devel] DHCP on PocketPC port
>>
>>
>> When pushing an IP to an OpenVPN client and using the DHCP
>> feature in the
>> TAP-Win32 driver to have it assigned to the windows client, I believe
>> OpenVPN or the TAP-Win32 driver is blocking the DHCP requests from
>> traversing the VPN tunnel. This is the behavior I'd expect as well.
>>
>> Now, while testing the PocketPC port, I just realized that I
>> recieved two
>> IP addresses! One from the TAP-Win32 driver, pushed from the OpenVPN
>> server, the correct one, but also one from my real DHCP server on the
>> remote network. We're using TAP and bridging... So obviously
>> the PocketPC
>> port does not block these packets, even though the build-in
>> DHCP server in
>> the TAP driver is replying to the DHCP requests.
>>
>> So, is this a bug in the PocketPC port of OpenVPN/TAP-Win32 or is
>> this expected behaviour? Or is there simply no blocking
>> feature in the
>> WinXP TAP-Win32 driver either, but these O/S only care about
>> the first
>> DHCP server that it gets a reply from?
>>
>> As a workaround, I just used iptables on my linux server to block
>> forwarding of UDP67/68 packets over the bridge and the things
>> worked just
>> fine.
>>
>> --
>> _____________________________________________________________
>> Mathias Sundman                  (^)   ASCII Ribbon Campaign
>> OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
>> http://openvpn.se/               / \   NO Word docs in e-mail

