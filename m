Message-ID: <40F43041.1050001@...83...>
From: webmaster <uni-webmaster@...83...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Change Connect to POST/GET in Proxy.c
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
Date: Tue Jul 13 11:56:03 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

because of the restart problem I mentioned before, I would like to 
modify the proxy.c by implementing the communication with HTTP "POST" 
and "GET" requests.
I've I'm right, proxy.c defines only the behavior of the client. Now I 
wondered where I find the Implementation of the server-side. Where does 
it receive the packets?

Besides this, is there any documentation, which discribes the 
architecure of openvpn?

Thanks

Ullrich

