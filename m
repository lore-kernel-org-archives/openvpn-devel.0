Message-ID: <3F8A8541.9070901@...61...>
From: julien Touche <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Need 1.5 beta testers for *BSD, Linux 2.2, OS
 X
References: <twig.1062309326.34391@...41...> <3F5B1FAE.1030801@...61...>, <3F5B1FAE.1030801@...61...> <twig.1066035744.55436@...41...>
In-Reply-To: <twig.1066035744.55436@...41...>
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
Date: Mon Oct 13 04:54:03 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> If you are asking if OpenVPN works with NAT, the answer is yes.

not really, would be more: does it work with one host having a remote 
publiv vpn server and the server treating with anyone having pass/cert 
without knowing its ip and not being able to join host ?


setup like this

host1 <- private network -> gateway1 <- internet -> host2

want a vpn between host and host2.

host1 has no public ip so it is able to join any public internet server 
like host2 but not the reverse if there is no established conn before.
is it sufficient for openvpn or not ?
in this setup, host2 cannot initiate conn to host1 (right ?), but host1 
can.


Regards

		Julien


