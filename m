From: Brian J <brian@...645...>
Message-ID: <loom.20060526T112250-991@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Connection problems ports
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
Date: Fri May 26 03:26:04 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hallo

I am newbie in openvpn so please don't shout at me

I am looking at differente problems with openvpn

Windows XP pro as server and as client.

1. problem
  I can connect to my openvpn server if I use port 1194 
  and open this in router.

  However I tried to change port number in Server file 
  and client file and open port in router. (port 5000)
  But when client try to connect it still write -> Thu 
  May 25 14:03:20 2006 UDPv4 link remote:   xxx.xxx.xxx.xxx:1194

  And I get no connection

  Any idear what I am making wrong? Reason i like to 
  change port are that at one place where I like
  to install openvpn only ports I have avalible are 21 
  and port 80. I don't have access to router.


  My setup files


  Server file start______________________

  port 5000
  proto tcp
  dev tap
  dev-node vpn
  server-bridge 192.168.1.4 255.255.255.0 192.168.1.231 192.168.1.241
  keepalive 10 120
  persist-key
  persist-tun
  verb 3
  ___________end server file_____________

  Client file start______________________


  client
  dev tap
  proto udp
  remote xxx.xxx.xxx.xxx:5000
  remote-random
  resolv-retry infinite
  nobind
  persist-key
  persist-tun
  ca "c:\\jzp\\ca.crt"
  cert "c:\\jzp\\client1.crt"
  key "c:\\jzp\\client1.key"
  comp-lzo
  verb 3 
  ____________end client file_____________

2. problem
  
  As far as I understand using dev tab then when connected to server It should 
be possible to bridge clint lancard and tap32 driver together so that both end 
of vpn connection looks like one big lan. but This seams not possible at least 
with above config files.

In this case lan on server end 192.168.10.x by dhcp in router and on client 
end 192.168.1.x by dhcp in router

Hope sombody can give me a kick in the correct direction

Best regards

Brian 




  






