From: Mike Ireton <mike-openvpn@...479...>
Message-ID: <dj9drd$rn2$1@...165...>
References: <dj6pnr$gs4$1@...165...>	 <Pine.LNX.4.58.0510192103130.32723@...41...>	 <dj8pnu$1ea$1@...165...>	 <1e6368e80510201225r42c4181cl670f1e9ae227b709@...278...>	 <dj8ta7$d92$1@...165...> <1e6368e80510201438l719e0fdatdae0d77af89a6140@...278...>
Mime-Version: 1.0
In-Reply-To: <1e6368e80510201438l719e0fdatdae0d77af89a6140@...278...>
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
Date: Thu Oct 20 17:51:31 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Leonard Isham wrote:

> 
>  Merge the encrypted and unencrypted traffic for each side.  Look for
> missing unencrypted packets and then compare encrypted packets that
> follow and look for a correlation of one or more missing or out of
> order encrypted packets.  Also non-trivial.
> 


	I think you don't understand what encryption is or does.

	1) Yes, packets can be captured entering the server from outside.
	2) Yes, packets can be captured being forwarded into the tap device on 
server.

	3) NO, packets being forwarded out in crypted udp form CAN NOT BE 
CORRELATED to any particular input to the tap device. So there's no way 
to know if any particular input frame, is actually making it out as a 
crypted udp packet, nor can we see the results of any fragmentation 
decisions or anything else OpenVPN decides to do with the data. If the 
link was completely quiet except for test data, then we could surmise 
that all packets leaving in crypted form are the packets for the test 
case (This is called traffic analysis in crypto circles), but since the 
link is in moderate use, there's no way to do this. So, at the present 
time, we CAN'T know or independently verify that it's doing anything at 
all with the frames in questio nor what exactly is happening to them (by 
looking at the crypted udp output). And if you claim to be able to do 
this, then congratulations! you have set us up the bomb, you've broken 
openvpn and the entire ssl security model, and all our base are now 
belong to you!

	4) YES, crypted udp packets can be captured on the input ethernet 
entering the client. They cannot be further examined to determine any 
correlation to inputs at the server. And we know that we have 0 packet 
loss end to end between client and server.

	5) NO, packets being decrypted CAN NOT BE examined independently of 
OpenVPN, nor can we trace the write path of the packets, nor can we 
examine any packets that the kernel itself decides to hold on to for 
fragmentation purposes. We can only see the packets once they are 
decrypted and presented to the network layer were pcap can get to them.

	We've proven that the server to client link is good by passing 
non-tunneled data (my pings to static public ips) while at the same time 
passing pings to tunneled ips which fail. We can look at steps 1, 2, and 
4 and all we learn is that some particular tunneld data is not making it 
thru. But steps 3 and 5 can't be examined with packet captures, and it 
is at exactly these two points that silent packet corruption or dropping 
can take place, and with validity, and we won't know about it or any of 
the possible causes of it.


> Again I am not a developer...
> 

	You keep saying that.

	If anyone has any other ideas, I'm all ears. Espically if anyone knows 
how I might tune in to the linux kernel and get copies of any packets it 
decides to drop because it can't find the rest of its fragments. Doesn't 
icmp return a copy when it says reassembly failed? Maybe I could look at 
these - they should be in decrypted form. Hmmm...



Mike Ireton


