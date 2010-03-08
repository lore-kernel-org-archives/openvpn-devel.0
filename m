Message-ID: <4B950E0B.1030908@...41...>
Date: Mon, 08 Mar 2010 07:47:39 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Linux tun/tap performance issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I believe this has been discussed before, but I noticed recently that a 
Linux-based OpenVPN client (Linux 2.6.24, OpenVPN 2.1.1) spends a lot 
more CPU time in kernel space than in user space.  This is surprising, 
given the fact that all of the CPU-intensive cryptographic operations 
are being done in user space.

Using the 'time' utility on the OpenVPN client, while a wget of a 50MB 
file was done over the VPN, I found that 80% of the CPU time was taken 
by the kernel, and 20% by user space (I should add that the Linux client 
was running as a VM on VMWare Fusion).

I'm wondering if anyone with kernel background has any insights on this. 
  Are there performance bottlenecks in the tun/tap driver?

James

