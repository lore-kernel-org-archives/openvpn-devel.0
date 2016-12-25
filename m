References: <80C9180A-6ED7-45C6-B057-5427244D65FF@...2219...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <450b7e31-18a2-b213-7ffa-1be336c16f93@...1856...>
Date: Sun, 25 Dec 2016 22:48:10 +0100
MIME-Version: 1.0
In-Reply-To: <80C9180A-6ED7-45C6-B057-5427244D65FF@...2219...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4-RC2: Authenticate/Decrypt packet
 error: bad packet ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 25-12-16 15:42, Franco Fichtner wrote:
> This is an issue seen on FreeBSD 10.3 (OPNsense 16.7) with the
> 2.4-RC2 version, while 2.3.14 works as expected (connection ok):
> 
> Dec 23 09:10:58 openvpn[76817]: SIGTERM[hard,] received, process exiting
> Dec 23 09:10:55 openvpn[76817]: /usr/local/sbin/ovpn-linkdown ovpns7 1500 1564 10.2.0.93 10.2.0.94 init
> Dec 23 09:10:54 openvpn[76817]: event_wait : Interrupted system call (code=4)
> Dec 23 09:10:46 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #9 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:46 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #8 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:36 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #7 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:36 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #6 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:26 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #5 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:26 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #4 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:15 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #3 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:15 openvpn[76817]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #2 / time = (1482480605) Fri Dec 23 09:10:05 2016 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
> Dec 23 09:10:07 openvpn[76817]: Peer Connection Initiated with [AF_INET]212.79.xx.xx:14900
> Dec 23 09:10:05 openvpn[76817]: Peer Connection Initiated with [AF_INET]212.79.xx.xx:49298
> 
> dev ovpns7                                                                                                                           
> verb 1                                                                                                                               
> dev-type tun                                                                                                                         
> tun-ipv6                                                                                                                             
> dev-node /dev/tun7                                                                                                                   
> writepid /var/run/openvpn_server7.pid                                                                                                
> #user nobody                                                                                                                         
> #group nobody                                                                                                                        
> script-security 3                                                                                                                    
> daemon                                                                                                                               
> keepalive 10 60                                                                                                                      
> ping-timer-rem                                                                                                                       
> persist-tun                                                                                                                          
> persist-key                                                                                                                          
> proto udp                                                                                                                            
> cipher AES-128-CBC                                                                                                                   
> auth SHA1                                                                                                                            
> up /usr/local/sbin/ovpn-linkup                                                                                                       
> down /usr/local/sbin/ovpn-linkdown                                                                                                   
> local 178.19.xx.xx                                                                                                                   
> ifconfig 10.2.0.93 10.2.0.94                                                                                                         
> lport 1210                                                                                                                           
> management /var/etc/openvpn/server7.sock unix                                                                                        
> secret /var/etc/openvpn/server7.secret                                                                                               
> route 10.255.252.0 255.255.255.0                                                                                                     
> route 172.16.0.0 255.255.255.0                                                                                                       
> tun-mtu 1500                                                       
> fragment 1300                                                
> mssfix
> 
> The other side is an identical FreeBSD/OPNsense with 2.3.14.  Any ideas or
> request for further input?

Just tried to reproduce this, but I didn't manage to do so.  2.3.14
works just fine against 2.4_rc2 in static key mode here.  I don't see
anything obviously wrong in the config or log.

Does this happen too if you use --cipher none?  If so, could you supply
a pcap of successively connecting with 2.4_rc2 and 2.3.14?  (The packet
ID is encrypted in CBC mode, so I need --cipher none to figure out what
is happening.)

-Steffan

