From: Peter Meiser <meiser@...1833...>
Date: Sat, 06 Jul 2013 10:12:05 +0200
Message-ID: <kr8jgd$3v7$1@...1062...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Connect on Android fails to connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I run OpenVPN 2.3.2 with PolarSSL 1.2.8 on a MIPS embedded linux.

When trying to connect with OpenVPN Connect on Android (version 1.1.11), I see the following error message in the log:


21:35:11.463 -- Client exception in transport_recv_excode: PolarSSL: SSL read error : SSL - Verification of the message MAC failed


When OpenVPN is linked against OpenSSL, the smartphone connects successfully.

Could you help me finding out the issue?

Thanks in advance,
Peter


