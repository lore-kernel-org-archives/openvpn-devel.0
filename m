From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] how to implement the multi client in openvpn?
References: <E1BXVKI-0006ya-HK@...110...>
In-Reply-To: <E1BXVKI-0006ya-HK@...110...>
MIME-Version: 1.0
Message-Id: <200406080841.11598.vda@...216...>
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
Date: Mon Jun  7 22:50:01 2004
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
To: 

On Tuesday 08 June 2004 04:18, oyk wrote:
> >>    I want to know how the openvpn control the multi-client case in 2.0
> >> version. for example:
> >>   clientA---Internet---|             |----Internal Server1
> >>
> >>                        |----Server---|----Internal Server2
> >>
> >>   clientB---Internet---|             |----Internal Server3
> >>
> >> Based on my comprehension, clientA (10.1.0.2) and clientB (10.1.0.3) c=
an
> >> make a tunnel with Server (10.1.0.1) respectively using TCP connection.
> >> clientA sockA----------Server SockA1
> >> clientB sockB----------Server SockB1
> >> When Server recieves the package from clientA or clientB, it pushs the
> >> packages to the tun/tap device. And the Server box could route the
> >> package to the internal server. And the internal server response the
> >> package to Server.
> >
> >No. Internal server replies to client's IP address.
> >Whether it will be sent to client thru "Server" or not
> >depends on routing. Typically you will have symmetric
> >routing setup, and it will go thru "Server".
>
> I am not sure whether my comprehension is right.
> ClientA(tap ip: 10.1.0.2, real ip: 1.2.3.4)
> Server(tap ip: 10.1.0.1, real ip: 5.6.7.8, internal subnet: 10.1.1.0/24)
> when ClientA connects an internal ServerB (10.1.1.2)
>
> The package from ClientA should be:
> |IPheader(src:1.2.3.4, dst:| 5.6.7.8)|TCPheader||etherheader|IPHeader10.1=
.0.2|.....||
>                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
content right?

not always. I am using udp, not tcp (tcp over tcp is prone
to 'internal meltdown' if your network losing packets,
and you _must_ design your network as if it does, even in reality it
works perfectly). Also, ethheader exists only on tap devices, not tun.
So, my picture is:

[ip(real ips)|udp|ip(tun ips)|.....]

> Server recieved the package, push the content into the tap/tun device.
> When the internal ServerB revieves the content, it response another packa=
ge
> to 10.1.0.2, right?
>
> When the Server recieved the response package, it encapsulate the package=
 into:
> |IPheader(src:5.6.7.8, dst:| 1.2.3.4)|TCPheader||etherheader|IPHeader10.1=
.0.2|.....||
>
> and send to ClientA, right?
> The OpenVPN Server differ clients' package based on the response package's
> IPHeader, right? Could you tell me where I can find the interrelated code?
> the OpenVPN source code is too much.

kernel does it IMHO. openvpn only knows that kernel said: "somebody wanted
to send this packet via tun/tap device you control, here's the packet".
I.e. kernel already did make routing decision that this packes goes to
this device.

I suggest reading some TCP/IP book/online docs. People scale far worse
than webpages 8)
--=20
vda

