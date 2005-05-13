From: Bjoern Boschman <bjoern-spam@...397...>
MIME-Version: 1.0
Message-Id: <200505131608.09587.bjoern-spam@...397...>
Subject: [Openvpn-devel] Assertation in mroute.c
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
Date: Fri May 13 07:10:21 2005
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Openvpn-devel@lists.sourceforge.net

Hi list,

I'm using openvpn 2.0-2 (from debian/sid, also tried with 2.0-1 from sarge).
After setting up a normal roadwarrior scenario I reconfigured my daemons to 
make a site-to-site connection. 
But now I'm getting an assertation fault on the server side, but only if the 
clients wants to stop/terminate the tunnel?
I've raised the verb level on the server side. Here is the output:

May 13 15:39:58 freeman ovpn-server[19515]: MULTI TCP: multi_tcp_post 
TA_TIMEOUT -> TA_UNDEF
May 13 15:39:58 freeman ovpn-server[19515]: SCHEDULE: schedule_find_least 
wakeup=[Fri May 13 15:40:02 2005 us=50294] pri=1858427981
May 13 15:39:59 freeman ovpn-server[19515]: EP_WAIT[0] rwflags=0x0001 
ev=0x00000001 arg=0x080c21e8
May 13 15:39:59 freeman ovpn-server[19515]: MULTI: REAP range 32 -> 48
May 13 15:39:59 freeman ovpn-server[19515]: MULTI TCP: multi_tcp_action 
a=TA_SOCKET_READ p=0
May 13 15:39:59 freeman ovpn-server[19515]: MULTI TCP: multi_tcp_dispatch 
a=TA_SOCKET_READ mi=0x080c21e8
May 13 15:39:59 freeman ovpn-server[19515]: client1/84.151.194.254:39496 
STREAM: GET NEXT len=1591
May 13 15:39:59 freeman ovpn-server[19515]: client1/84.151.194.254:39496 
Connection reset, restarting [0]
May 13 15:39:59 freeman ovpn-server[19515]: client1/84.151.194.254:39496 
SIGUSR1[soft,connection-reset] received, client-instance restarting
May 13 15:39:59 freeman ovpn-server[19515]: MULTI: multi_close_instance called
May 13 15:39:59 freeman ovpn-server[19515]: Assertion failed at mroute.c:349
May 13 15:39:59 freeman ovpn-server[19515]: Exiting


My configfiles can be found here:
http://jesusch.homeip.net/~jesusch/tmp/server.conf
http://jesusch.homeip.net/~jesusch/tmp/client1 (ccd)
http://jesusch.homeip.net/~jesusch/tmp/client1.conf


If you need any more input from my side you are welcome to mail me


Cheers 

Bjoern



