From: Andrew McGill <andrew2004@...264...>
MIME-Version: 1.0
Message-Id: <200408311304.43081@...265...>
Subject: [Openvpn-devel] Making a lossy link work
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
Date: Tue Aug 31 04:10:16 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello

I am hoping someone will give me some pointers towards adding an 
optional semi-reliable data delivery mode to openvpn.

I would like to set up OpenVPN on an international link that has a 
~500ms round trip time, and a round trip packet loss of 50% to 60% 
(i.e. around 20% to 30% probability of loss in one direction). 

The design is currently like this:

 1. Data packets are incrementally numbered (e.g. 16 bits). Each 
sender maintains a buffer of packets sent

 2. Each packet is sent with information about data-packets received:
	Last received data-packet sequence number
	History of packets received: e.g. 16 bits, 1=received, 0=packet not 
seen

 3. When data packets are received, confirmations of received packets 
are tallied.  If a packet is confirmed un-delivered after a 
configurable timeout, it is retransmitted a maximum of 2 times 
(higher level protocols can handle duplicates and loss beyond this - 
that's their domain).

 4. A packet about which no further information is received is assumed 
to have been delivered.  

Now, questions:

 - Should I define a separate data protocol for semi-reliable 
delivery? (e.g. P_DATA_RETRY_V1) - or would it be possible to extend  
P_DATA_V1?

 - Where would I add code? - I think encrypt_sign() function in 
forward.c for a start, but pointers to other places would be welcome.  

 - Is there an existing sequence number for the data packets that I 
can re-use?

 - Should I use/adapt the existing reliable transport code?

&:-)

-- 
I don't believe in evolution or microsoft outlook

