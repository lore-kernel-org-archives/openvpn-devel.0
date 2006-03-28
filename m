Message-ID: <44294D0A.208@...101...>
From: inode <inode@...101...>
MIME-Version: 1.0
Subject: [Openvpn-devel] NTLM proxy problem.
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
Date: Tue Mar 28 06:50:54 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

I'm doing some test with openvpn, and I saw some problem using NTLM auth 
proxy.

I tested the software on a ISA server and all work fine, the problem is 
using a squid proxy with NTLM.

I recognized 2 different problem:

- The proxy authorization phase (one, two and three) are done all on the 
same connection, but the "Connection: keep-alive" or "Proxy-connection: 
keep-alive" are not set on the request. Some kind of proxy (like squid) 
after the first request drop the connection, and openvpn doesn't do 
another connect.

- NTLM domain, actualy on openvpn config file the user can't set the 
domain of the credentials sent to the proxy. An Microsoft ISA server 
will have a "default domain" to try the authentication, but that doesn't 
mean that "default domain" will be the right one... Also on squid the 
domain is required and a null domain will be refused.

I hope these info will help you to fix the authentication and made 
openvpn more reliable.

Cheers

inode

