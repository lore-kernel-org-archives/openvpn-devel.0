From: Tony <kb2wjw@...277...>
Date: Sun, 10 Sep 2006 19:18:21 +0400
Message-ID: <op.tfn4svxdioehzu@...596...>
References: <op.tfkgwnitioehzu@...603...>
	<op.tfmvibs8ioehzu@...596...> <200609100231.50356.uberlord@...594...>
Mime-Version: 1.0
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] MULTICAST: cannot join a group across the
	OpenVPN connection. Why?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sun, 10 Sep 2006 05:31:50 +0400, Roy Marples <uberlord@...594...>  
wrote:

> Or that most people here have nfc what multicasting is.
MULTICASTing vs BROADCASTing is (in short):
You broadcast to "all ones" IP address on a segment, i.e. for  
192.168.1.0/24 it is 192.168.1.255,
while multicasts go to imaginary IP address in the special range, in my  
example this is 239.255.20.1

The advantage of MULTICAST is that if noone on a given segment needs|wants  
your data - the data never enters such a segment. When some host decides  
it needs that data it "joins" a multicast group, i.e. informs it's closest  
router it needs to pass the multicasted data into a segment. When the last  
host on a segment decides to "leave a group" - the closest router again  
stops to route multicasted data into a segment.
With broadcasts it is not possible (for the receiving side) to control the  
presense of the data - receive it or not - the sender will flood all of  
your LAN with it's data.
Besides, in IPv6 there will be no conception of BROADCASTs any more, only  
MULTICASTs should be used instead.

Tony.


