References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <82cf3c7a-f738-2821-f294-1cd954a0b491@...277...>
Date: Wed, 24 Oct 2018 13:09:03 +0100
MIME-Version: 1.0
In-Reply-To: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Slow outbound network speed for Windows Server
 2016 only via the OpenVPN tunnel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

a completely different approach ..

On the Forum somebody claimed that the old Tap Adaptor works better
than the new one on W2012r2.

https://forums.openvpn.net/viewtopic.php?f=6&t=27288#p81973

Could you test that ?

Thanks
tct


On 03/10/2018 16:15, Rostyslav Maryliak wrote:
> Dear OpenVPN developers,
> 
> I've faced a very strange issue with slow outbound network speed from
> Windows Server 2016 Standard server via the OpenVPN tunnel.
> OpenVPN server is Windows Server 2012 R2, client is Windows Server 2016.
> The inbound network speed for Windows Server 2016 is great.
> But the outbound network speed is nearly 30-40 kbps. I've got the same
> results using several tests: iperf testings, file download via SMB,
> Web-based downloading (using HTTP) etc.
> 
> The tunnels is getting up and it works greatly, but only in one direction -
> from Windows Server 2012 R2 to Windows Server 2016.
> I've been using such server-client configurations setup for several years
> with Windows Server 2012 R2 servers and I've never faced such issue before.
> At first I thought that our ISP has some network limitations, but it turned
> out that the same tests shows great network speed results using the public
> IP addresses in both directions.
> The issue only occurs inside the VPN tunnel. I've spent 3 days tryng to
> figure it out, but failed. I've installed all latest Windows updates,
> reinstalled OpenVPN, tried to switch from UDP to TCP,
> played with performance settings in configs (link-mtu, sndbuf, rcvbuf etc)
> but still no luck. I've tested the same setup between two Windows Server
> 2012 R2 servers and it works greatly in both directions.
> Then I've tested it with another Windows Server 2016 Standard server
> (different server and different ISP) and it showed the same awful results
> in outbound direction.
> When I've set the same OpenVPN tunnel between two Windows Server 2016
> Standard servers I've got the same poor network speed in both directions.
> 
> I believe that the issue is somehow related only to the Windows Server 2016
> version and I am more than confident that it depends on server's TCP stack
> settings.
> I've noticed that Windows Server 2016 has a congestion control provider
> setting set to "default", while previous versions of Windows has this
> setting set to "none".
> 
> I've created a topic on OpenVPN Support Forum and it was suggested to post
> my issue to you and reference the thread.
> 
> You can reference to the
> https://forums.openvpn.net/viewtopic.php?f=6&t=27173 for config files and
> additional information.
> 
> Have you faced a similar issue before? Can you provide any hint how can I
> resolve the issue? What did I missed?
> I would be very grateful for any help. Thank you in advance.
> 
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

