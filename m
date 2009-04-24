Message-ID: <49F1B322.6030705@...1032...>
Date: Fri, 24 Apr 2009 15:40:02 +0300
From: =?ISO-8859-1?Q?Siim_P=F5der?= <siim@...1032...>
MIME-Version: 1.0
Subject: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

We are running a couple of openvpn servers with relatively high load
(Opterons 2xDC, e1000, recent kerneles) and it seems as if most of the
CPU time is not used on cryptography, but in softirq (send/recv for udp
and read/write on tun?). This has lead us to suspect that most of the
time is spent pumping data between userspace and kernelspace.

Now, we are still investigating this, but I thought I'd ask around too:.
Does anyone have a take on this, could a considerable (upwards of 10%)
increase in openvpn capacity be accomplished by optimizing udp/tun
interfaces of the kernel (a mechanism like ring buffers?) or are we on a
wrong track? Furthermore (if it is possible) would anyone care to
develop such a solution? You'd get compensated for your trouble, naturally.

Thanks for your attention,
Siim

