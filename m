Message-ID: <b2c9b370-43b8-40c3-843b-adeabef79891@...277...>
Date: Wed, 23 Oct 2024 17:47:51 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
 <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
 <ZxkLm_LadCi16JTV@...1296...>
From: Razvan Cojocaru <rzvncj@...277...>
In-Reply-To: <ZxkLm_LadCi16JTV@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in
 push replies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/23/24 17:43, Gert Doering wrote:
> Hi,
> 
> On Wed, Oct 23, 2024 at 05:40:43PM +0300, Razvan Cojocaru wrote:
>> In this case, we want to disconnect the client and it should stay
>> disconnected. A simple AUTH_FAILED for this scenario will have the client
>> attempt another connection. But if we invalidate the token, then the client
>> will not attempt to reconnect.
> 
> AUTH_FAILED should do this automatically - invalidate the token, that is.
> Can you show a log where this is (not) happening?

Of course:

2024-10-23 14:52:06 us=368754 PUSH: Received control message: 
'PUSH_REPLY,auth-token'
2024-10-23 14:52:06 us=368851 UDPv4 WRITE [90] to 
[AF_INET]69.162.107.71:1194: P_ACK_V1 kid=0 pid=[ #13 ] [ 8 7 6 5 4 3 2 
1 ] DATA len=0
2024-10-23 14:52:06 us=368936 UDPv4 READ [163] from 
[AF_INET]69.162.107.71:1194: P_CONTROL_V1 kid=0 pid=[ #12 ] [ 2 3 4 5 ] 
pid=9 DATA len=85
2024-10-23 14:52:06 us=368972 AUTH: Received control message: 
AUTH_FAILED,No Stairway to Heaven allowed in this guitar store
2024-10-23 14:52:06 us=369228 TCP/UDP: Closing socket
2024-10-23 14:52:06 us=369287 SIGUSR1[soft,auth-failure (auth-token)] 
received, process restarting
2024-10-23 14:52:06 us=369346 Restart pause, 1 second(s)

And with this patch:

2024-10-23 17:46:58 us=427109 PUSH: Received control message: 
'PUSH_REPLY,auth-token'
2024-10-23 17:46:58 us=427149 UDPv4 WRITE [90] to 
[AF_INET]69.162.107.71:1194: P_ACK_V1 kid=0 pid=[ #12 ] [ 8 7 6 5 4 3 2 
1 ] DATA len=0
2024-10-23 17:46:58 us=427371 UDPv4 READ [163] from 
[AF_INET]69.162.107.71:1194: P_CONTROL_V1 kid=0 pid=[ #12 ] [ 2 3 4 5 ] 
pid=9 DATA len=85
2024-10-23 17:46:58 us=427403 AUTH: Received control message: 
AUTH_FAILED,No Stairway to Heaven allowed in this guitar store
2024-10-23 17:46:58 us=427414 register signal: SIGTERM (auth-failure)
2024-10-23 17:46:58 us=427427 SIGTERM received, sending exit 
notification to peer
2024-10-23 17:46:58 us=427442 signal_reset: signal UNKNOWN is cleared
2024-10-23 17:46:58 us=427464 UDPv4 WRITE [90] to 
[AF_INET]69.162.107.71:1194: P_ACK_V1 kid=0 pid=[ #13 ] [ 9 8 7 6 5 4 3 
2 ] DATA len=0
2024-10-23 17:46:58 us=427501 UDPv4 WRITE [41] to 
[AF_INET]69.162.107.71:1194: P_DATA_V2 kid=0 DATA len=40
2024-10-23 17:46:59 us=679084 register signal: SIGTERM 
(exit-with-notification)
2024-10-23 17:46:59 us=679264 TCP/UDP: Closing socket
2024-10-23 17:46:59 us=679300 net_route_v4_del: 100.96.0.0/11 via 
100.96.1.1 dev [NULL] table 0 metric -1
2024-10-23 17:46:59 us=679388 sitnl_send: checking for received messages
2024-10-23 17:46:59 us=679406 sitnl_send: rtnl: received 36 bytes
2024-10-23 17:46:59 us=679437 net_route_v4_del: 100.80.0.0/12 via 
100.96.1.1 dev [NULL] table 0 metric -1
2024-10-23 17:46:59 us=679477 sitnl_send: checking for received messages
2024-10-23 17:46:59 us=679500 sitnl_send: rtnl: received 36 bytes
2024-10-23 17:46:59 us=679519 delete_route_ipv6(fd:0:0:8000::/49)
2024-10-23 17:46:59 us=679531 net_route_v6_del: fd:0:0:8000::/49 via :: 
dev tun1 table 0 metric -1
2024-10-23 17:46:59 us=679618 sitnl_send: checking for received messages
2024-10-23 17:46:59 us=679639 sitnl_send: rtnl: received 36 bytes
2024-10-23 17:46:59 us=679663 delete_route_ipv6(fd:0:0:4000::/50)
2024-10-23 17:46:59 us=679678 net_route_v6_del: fd:0:0:4000::/50 via :: 
dev tun1 table 0 metric -1
2024-10-23 17:46:59 us=679743 sitnl_send: checking for received messages
2024-10-23 17:46:59 us=679763 sitnl_send: rtnl: received 36 bytes
2024-10-23 17:46:59 us=679801 Closing tun/tap interface
2024-10-23 17:46:59 us=679817 net_addr_v4_del: 100.96.1.2 dev tun1
2024-10-23 17:46:59 us=679930 sitnl_send: checking for received messages
2024-10-23 17:46:59 us=679976 sitnl_send: rtnl: received 36 bytes
2024-10-23 17:46:59 us=679997 net_addr_v6_del: fd:0:0:8100::2/64 dev tun1
2024-10-23 17:46:59 us=680107 sitnl_send: checking for received messages
2024-10-23 17:46:59 us=680129 sitnl_send: rtnl: received 36 bytes
2024-10-23 17:46:59 us=725831 SIGTERM[soft,exit-with-notification] 
received, process exiting


Thanks,
Razvan

