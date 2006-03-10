Message-ID: <441195DA.3090700@...564...>
From: Kosta Welke <kosta@...564...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] float is broken when source port changes
References: <440D05E9.7030203@...564...> <1e6368e80603070813y6d2d144ex3cef3a8a26a02d9@...278...> <440DBD44.5060302@...564...> <440DD137.3060604@...41...> <440E24BE.3040904@...564...> <440E316F.5080200@...41...>
In-Reply-To: <440E316F.5080200@...41...>
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
Date: Fri Mar 10 07:06:04 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

James Yonan wrote:

> Okay, I understand what you are asking for -- If you were using static 
> key mode (which is stateless), you would get the behavior you are 
> looking for.  In TLS mode, however, OpenVPN doesn't allow a port or IP 
> change within a given TLS session (for security/DoS reasons).  The 
> behavior you should be seeing is that the new port and IP address is 
> only accepted by the server after a fresh TLS renegotiation.

Okai, I found out the the --float option allows for IP changes only 
after a timeout, so the port changes are handled like IP changes and 
everythings foine.

Sorry for the static :)

Kosta

