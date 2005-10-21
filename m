From: Mathias Sundman <mathias@...454...>
Subject: Re: [Openvpn-devel] Re: Bug report (long) - OpenVPN dropping small
 frames
In-Reply-To: <dj8pnu$1ea$1@...165...>
Message-ID: <Pine.LNX.4.61.0510210841210.29827@...210...>
References: <dj6pnr$gs4$1@...165...> <Pine.LNX.4.58.0510192103130.32723@...41...>
 <dj8pnu$1ea$1@...165...>
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
Date: Fri Oct 21 00:04:46 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Mike Ireton <mike-openvpn@...479...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 20 Oct 2005, Mike Ireton wrote:

> 	For the others who suggested reducing mss values and such - I'm 
> already doing it. In fact I have mss clamped down to 1312 right now for 
> testing. But, mss clamping doesn't have anything to do with the loss of the 
> lcp-echo frames I was complaining about.

I don't know if you have got any comments off-list, but I only said that 
--mssfix can usually help with MTU / packet fragmentation programs, but 
*won't* help you with this as it's not TCP based. My suggestion were 
therefor to try using --fragment which will cause OpenVPN to do internal 
fragmentation on ALL packets to avoid real IP fragmentation.

Janne also suggested that you could play with the MTU settings. I don't 
think you will get away with only changing the MTU when you're doing 
bridging though as you would then have to change the MTU on ALL hosts 
connected to both sides of the bridge as it's the transmitting hosts MTU 
that decides what frame size to use, not the recieving end (the openvpn 
machine).

I understand it's hard to play with these options in a production 
environment so if possible, I'd recommend setting up two new machines that 
takes the same network path to connect and continue the troubleshoting on 
these. As you can easily reproduce the problem with your ping, it 
shouldn't be to hard to "move" the problem into new machines. If you don't 
manage to "move" the problem to the new machines, well then you know where 
to continue looking for the problem.

If you have a spare NIC in each gateway you could setup a second instance 
of OpenVPN between your current machines, and just create a second bridge.

Cheers / Mathias

