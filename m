Message-ID: <40C1BE37.9030606@...199...>
From: Mike Auty <m.auty@...199...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0 Yo-Yo effect...
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
Date: Sat Jun  5 05:37:01 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,
	Since I've upgraded to OpenVPN 2, I've started seeing an interesting 
effect.  Originally (way back at _test23) it didn't happen very much, 
and seemingly a restart of either the server or client would fix it, but 
recently it's been happening a lot.
	For historical reasons (I used to be on windows) I set my ping and 
ping-reset times to very low values (10 and 60) so that I'd see the 
adaptor go down within a minute of when my connection went down.  Under 
the old 1.5 vpns this was fine, but since the upgrade some of the 
windows installation's I've used have reported that the openvpn adaptor 
goes up and down every couple of minutes and in the recent _beta2 it 
seems to happen quite often (although it's still random in that 
sometimes it won't).
	So far I've observed this between windows-windows and windows-linux 
machines.  I haven't seen it between linux and linux boxes, but that may 
be because it's harder to spot (since there isn't an adaptor up/down 
indicator by default).  Having checked some recent logs I haven't seen 
it happen much between linux-linux (just the hourly key-expiration).
	Unfortunately the closest example I have to hand doesn't have client 
ping-reset as well as server ping-reset.  The log for the client list 
says it's starting up ok, then one line saying replay window backtrack 
and then no other messages (for about half a day in fact), and the 
server reports inactivity timesout approximately every minute or so.  As 
far as I'm aware the internet connections are fine.
	So basically I was wondering if there was something in the ping code, 
or the inactivity checker that may have changed that someone knows about 
which could account for this behaviour?  I'll be happy to provide 
configs/logs if they'd be at all helpful...
	Thanks,
	Mike  5:)

