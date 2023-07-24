Message-ID: <379eb705-2bb7-7695-188f-04c3e030f42f@...1227...>
Date: Mon, 24 Jul 2023 11:12:08 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <CALn4OiNv11FHk6ZhahbUYZPa15AW53H7C85Awi+qrtgeVRPm1Q@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CALn4OiNv11FHk6ZhahbUYZPa15AW53H7C85Awi+qrtgeVRPm1Q@...278...>
Subject: Re: [Openvpn-devel] Porting OpenVPN Problems
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
To: Swan Geon <swangeon@...277...>, openvpn-devel@lists.sourceforge.net

Am 24.07.23 um 10:43 schrieb Swan Geon:
> it still doesn't change where it hangs though interestingly enough if I 
> set the address within the command to that of the interface, then the 
> interface will respond with `read from TUN/TAP returned 44` followed by

That happens if we get an unexpected status code from the tun/tap 
interface. It is probably worth looking at the tun driver to understand 
when/why it reports that code 44.


> `Recursive routing detected, drop tun packet to []AF_INET]1.1.1.1:1194 
> <http://1.1.1.1:1194>` 1.1.1.1 being the address of the interface but 
> only once and that's it. 

Usually that happens when you have some kind of routing loop. If you 
give us a full log of the client that might help. If you are just 
starting I would also avoid tunneling everything over the tun interface 
(redirect-gateway) but instead just pick some random network like 
10.77.123.0/24 and only route that to the tun device and get that 
working to avoid the routing loops until that works solid.

Maybe I am confused about how that specific
> command works and/or I have something set up wrong somewhere down the 
> line. I know that this is a complicated issue with many facets and I am 
> new to OpenVPN so I'm not super sure how to debug it currently so please 
> please be patient with me and ask questions so that I can do my best to 
> answer them.

Sure no problem. For some reason your whole mail is formatted a single 
blob of text. Something seems to have stripped all formatting.

Arne

