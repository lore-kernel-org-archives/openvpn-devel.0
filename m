From: "Rob Fowler" <openvpn@...113...>
MIME-Version: 1.0
In-Reply-To: <twig.1063214225.90210@...41...>
Message-Id: <E1A48k9-0002kt-7s@...110...>
Subject: [Openvpn-devel] RE: [Openvpn-users] New TAP-Win32 driver needs stress testing
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Sep 29 17:52:23 2003
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

I have been testing openvpn-1.5-beta7.7 for the last few days between a dual
CPU windows XP machine, a windows 2000 and a Linux machine (kernel
2.4.23-pre5 #2 SMP). I have transfered well over 1TB gig of data using both
the tunnel and the tap devices. I have not had a single issue once the
tunnel was established.
James, I tried it in driver verify mode as well. The only difference in
driver verify mode was when I turned on the "low resources simulation"  the
rate dropped to 10s of K per second after a while. It all seemed to work. I
don't know much else about this tool. Do you have any suggestions?
I also started multiple ftp sessions to and from all the machines and
managed to get both the send and receiver up to 100% CPU

(P.s. with a 2.4GHz CPU on the desktop and a 2.6Gz CPU on the server I can
get 6MByte per second ftp transfers across the VPN)


