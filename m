Subject: Re: [Openvpn-devel] OpenVPN 2.0 Multi-client and transparent bridged firewalling
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1084300792.643@...41...>
In-Reply-To: <40A0D23D.30902@...199...>
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
Date: Tue May 11 11:40:06 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mike Auty <m.auty@...199...>, openvpn-devel@lists.sourceforge.net

Mike Auty <m.auty@...199...> said:

> James,
> 	Our current setup is one where we have staff and clients using the VPN 
> to connect into our network, staff for normal work, clients for remote 
> troubleshooting.  We'd like to block clients off from both each other 
> and the main network with connection tracking so that they cannot make 
> connections into staff areas, but staff can make connections into them. 
>   Also Staff must be allowed total access.
> 	As far as I understand it at the moment, even though the OpenVPN 2.0 
> system can work as it's own router, it will by default pass packets out 
> to the system for firewalling/routing etc.  This is exactly what I'm 
> after, so that's great.

Right, the --client-to-client flag (off by default) controls whether or not
OpenVPN internally routes client-to-client traffic.

> What I'm trying to do now is have the 
> --client-connect script determine which MAC addresses come from which 
> remote client and firewall them appropriately.  I was firstly wondering 
> if this was possible and secondly, assuming that at the moment it 
> wasn't, how best it might be handled in the new system.  Perhaps calling 
> a script when a MAC is learnt, or kernel packet tagging or creating many 
> virtual adaptors.  The last two ideas are neither scalable nor good 
> solutions, but the scripting idea also seems cumbersome unless the same 
> script is called with the common name and the new MAC learnt...

Interesting...  The client-connect script cannot know the remote TAP's MAC
address because the initial ARP sequences to establish it haven't happened
yet.  But I don't think it would be difficult to add a new validation script
which is called for every new MAC learned and includes the common-name and IP
address of the client.

James

> 	My current ideas for work arounds are to parse the logs looking for 
> "MULTI: learn" lines, then call scripts and firewall based on that.  The 
> other more feasible idea is since there are only really two divisions 
> (staff and clients) to set up two adaptors and have one allow only 
> clients, and the other only staff.  This however sidesteps the issue of 
> linking a certificate common name to network traffic in some way.  Any 
> ideas/comments would be appreciated...
> 	Thanks,
> 	Mike  5:)
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
> higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




