From: Michael Grigoriev <mag@...34...>
Message-ID: <20020723005329.GA22266@...35...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Multiple VPN connections on the same port
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon Jul 22 16:48:03 2002
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

Firstly I'd like to thank you a prompt responce to my last question - 
it was most helpful.

Now I am looking into the posibility of setting up a VPN server that 
will accept incoming VPN connections from some number of clients. (I do 
realize that client/server only really applies to TLS-mode, by client I 
really just mean the machine that will initialize the connection, the 
one that will be started with --remote)  However I am not sure how to 
best implement this since I don't know the number of clients in 
advance, so I can't really have a port assigned to each client. Instead 
I would like to have all clients to connect to the server on the same 
port. I did not however find a way to do so with OpenVPN. When I tried 
to have to have two clients connect to the same server, they just kept 
periodically knocking each other off with error messages of the sort:
105: TLS Error: Unroutable control packet received from 
192.168.xx.xx:7000 (si=3 op=P_CONTROL_SOFT_RESET_V1)
So I guess my question is, is it supposed to work? The man page says 
that you "should" have all the connections use a different port, which 
would imply that it is possible to do the opposite, but I was not able 
to get it to work....
If it is not possible, as far as I understand it should not be too hard 
to implement... We could have the server start out bound to the 
listening port, but not connected, and when we get an incoming 
connection from some ip, we fork and call connect in the child, so that 
in the future all packets from that ip would go to that process. Right?

Would this work? Is there a better way to accomplish this?

--
Thanks in advance,
	mag
  

