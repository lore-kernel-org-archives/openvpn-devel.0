From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] how to implement the multi client in openvpn?
References: <E1BXJZc-0006L0-Tw@...230...>
In-Reply-To: <E1BXJZc-0006L0-Tw@...230...>
MIME-Version: 1.0
Message-Id: <200406071602.52202.vda@...216...>
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
Date: Mon Jun  7 06:14:10 2004
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
To: 

On Monday 07 June 2004 15:45, oyk wrote:
> Hi=A3=ACguys
>    I want to know how the openvpn control the multi-client case in 2.0
> version. for example:
>   clientA---Internet---|             |----Internal Server1
>                        |----Server---|----Internal Server2
>   clientB---Internet---|             |----Internal Server3
>
> Based on my comprehension, clientA (10.1.0.2) and clientB (10.1.0.3) can
> make a tunnel with Server (10.1.0.1) respectively using TCP connection.
> clientA sockA----------Server SockA1
> clientB sockB----------Server SockB1
> When Server recieves the package from clientA or clientB, it pushs the
> packages to the tun/tap device. And the Server box could route the package
> to the internal server. And the internal server response the package to
> Server.

No. Internal server replies to client's IP address.
Whether it will be sent to client thru "Server" or not
depends on routing. Typically you will have symmetric
routing setup, and it will go thru "Server".

> My question is: when OpenVPN Server recieves one package from one internal
> server, how does it control the package and redirect to whom(clientA or
> clientB)?

By looking at destination IP.

>    Please help, thanks!
>
> PS: could I use windows version as OpenVPN Server?

As a last resort only ;)
--=20
vda

