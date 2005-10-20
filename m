From: Mike Ireton <mike-openvpn@...479...>
Message-ID: <dj8ta7$d92$1@...165...>
References: <dj6pnr$gs4$1@...165...>	 <Pine.LNX.4.58.0510192103130.32723@...41...>	 <dj8pnu$1ea$1@...165...> <1e6368e80510201225r42c4181cl670f1e9ae227b709@...278...>
Mime-Version: 1.0
In-Reply-To: <1e6368e80510201225r42c4181cl670f1e9ae227b709@...278...>
Subject: [Openvpn-devel] Re: Bug report (long) - OpenVPN dropping small frames
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
Date: Thu Oct 20 13:10:18 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Leonard Isham wrote:
 >
 >>
 >>The problem with this test is that there are many hundreds of OpenVPN
 >>packets per second flying between machine a and machine b - coupla
 >>megabits per second in fact. There is no way to capture just the crypted
 >>udp packets carrying the tunneled data involved in the test seperate
 >>from normal data traffic.
 >
 >
 >Actually it is quite trivial using tcpdump/windump, ethereal. snoop,
 >sniffer, etc.
 >
 >If you traffic volume is too high then I'd say you may want to check
 >the performance of the equipment for bottlenecks.
 >

Leonard, I think you missed the point. There is no way to capture just 
the tunneled data involved in the test case because one encrypted udp 
frame will look the same as any other encrypted udp frame. That's the 
whole point of the vpn in the first place! Compounding the problem of 
the cryptography - which makes the use of packet capture tools useless 
for examining problems _inside_ the tunnel - is the fact that with it 
actively being used, there's no way to peform any kind of realistic 
traffic analysis either.  How do you propose to trivialy seperate out 
the 1 or 2 encrypted udp packets per scond which are the ones are 
carrying the ping packets for the test case, from the other hundreds of 
encrypted udp packets per second which are carrying pppoe session data 
for other applications and users??

You can't.


 >
 >You _have_ to do a packet capture to determine where the packets are
 >getting lost.
 >

My point is that according to the packet captures that can be done, it 
appears they're getting dropped in secret, in a way that I currently 
don't have any way to examine or test for without divine intervention. 
Once the packets hit openvpn (by way of being forwarded into the tap 
device), I have no way of examining the data until it comes out the 
other side.  The OpenVPN client could be dropping the frames due to a 
number of reasons such as failed hmac authenticiaton, failed decryption, 
failed some other sanity check. Or, the server could be creating invalid 
frames which pass all the checks, but is not what was actually passed to 
it in the first place. Or, the kernel in the OpenVPN client machine 
could be running low on some resource which is contributing to the problem.

By the way, here's the packet fragment statistics for various machines 
along the path:

OpenVPN server: (talking to 8 clients):
InDiscards:97972
ReasmTimeout: 1206 ReasmReqds:329076 ReasmOKs:163935 ReasmFails:1206 
FragsOKs:0 FragFails:1 FragCreates:1500526

OpenVPN client:
InDiscards:0
ReasmTimeout: 133045 ReasmReqds:640581 ReasmOKs:253756 ReasmFails:133045 
FragsOK s:0 FragFails:0 FragCreates:29208

Router A between Server to Client:
InDiscards:0
ReasmTimeout: 0 ReasmReqds:0 ReasmOKs:0 ReasmFails:0 FragsOKs:0 
FragFails:0 FragCreates:0

Router B between Client to Server:
InDiscards:0
ReasmTimeout: 0 ReasmReqds:96 ReasmOKs:48 ReasmFails:0 FragsOKs:0 
FragFails:0 FragCreates:0

According to the ip stack of all machines involved, the only 
fragmentation activity is happening inside the client and server.





Mike




