From: Nate Nielsen <nielsen-list@...505...>
Reply-To: nielsen@...505...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] new tap device for each connection
References: <437E7AE1.4030204@...503...> <437E91BE.3060301@...504...>
Message-Id: <20051119050613.5D34F70DC87@...506...>
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
Date: Fri Nov 18 20:54:01 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ian Berry <iberry@...504...>
Cc: Manolis Stamatogiannakis <mstamat@...503...>, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Ian Berry wrote:
> I ran into this exact situation. Based on my knowledge of how OpenVPN
> operates in "server mode", I figured that it would require a significant
> change to allow this. As a workaround, I run OpenVPN in "inetd mode",
> which forces a new openvpn process for each client and therefore a
> separate tap interface. Works great for me.

Note that this doesn't work with UDP, only with TCP. Tunneling via TCP
comes with it's own set of (very real) problems:

http://sites.inka.de/sites/bigred/devel/tcp-tcp.html

It also spawns a new process for every (and any) TCP connection coming
to port 1194 (or whatever you have configured) allowing an attacker to
launch thousands of processes on your machine. Configuring inetd
correctly can mitigate this, but in this case the attacker could DDOS
your VPN service without even breaking a sweat.

> Manolis Stamatogiannakis wrote:
>> If this is not possible, how much work would it be to implement it as
>> a patch? Would it fit with the OpenVPN internals, or it would need
>> major changes to fit?

I've tried, but gave up after my patch started growing way too big. I've
had reasonably experience patching all sorts of networking software,
kernels etc... The whole concept of one tun fd/socket is pretty deeply
intertwined into the OpenVPN logic. And the OpenVPN code is pretty
hairy, each of those (many many) options you see in the manual page is
intertwined with each other in interesting ways. But I'd say an OpenVPN
developer, someone who's very familiar with the internals, could
probably pull it off.

That said, I can send you may half done patches and tell you where I
left off if you're interested.

Cheers,
Nate


