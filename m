Message-ID: <408EFFED.7070303@...199...>
From: Mike Auty <m.auty@...199...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Many to one TCP question
References: <twig.1083092616.79848@...41...> <408EDB17.8090204@...203...>
In-Reply-To: <408EDB17.8090204@...203...>
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
Date: Tue Apr 27 17:53:02 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

Hi,
	I have never found any problems using UDP as the tunnel mechanism over 
the internet.  I was under the impression that UDP packets were less 
likely to be blocked at the firewall than TCP, since historically it has 
been under utilized.  These days with streaming video/media where speed 
is more important than reliability, UDP is really beginning to be used a 
lot and so I would have said the difficulties in using UDP through 
firewalls is equal to using TCP.
	The advantages of using UDP to tunnel data are that it reflects the 
underlying physical layer very well, whereas TCP has reliability 
controls built in.  These monitor the speed of connections, include 
timeouts in case of lag and various other mechanisms to maintain a 
connection.  Unfortunately if you then tunnel TCP on top of TCP, these 
mechanisms can interact poorly and produce very poor results.  At least 
that what I recall reading somewhere (after a quick dig it turns out the 
page was part of the CIPE project which was also based on the tun/tap 
virtual adaptor system, see 
http://sites.inka.de/sites/bigred/devel/tcp-tcp.html).
	Anyway, personally I would always use UDP, I currently have a LAN 
bridged with a many to one UDP openvpn (linux) server, all the various 
openvpn (windows and linux) clients can interact with the LAN clients as 
if they were all on the LAN (and vice versa).  I would definitely 
recommend this for road warrior solutions.  Hope this helps...
	Mike  5:)

