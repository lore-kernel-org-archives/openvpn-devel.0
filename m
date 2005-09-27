Message-ID: <1e6368e80509271858682178b5@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] 400 vpn clients 20% of them loosing the route frequently
In-Reply-To: <1127848987.6861.117.camel@...399...>
MIME-Version: 1.0
References: <1127848987.6861.117.camel@...399...>
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
Date: Tue Sep 27 19:01:06 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

On 9/27/05, Marcelo Toledo <marcelo@...461...> wrote:
> I have one OpenVPN server version 2.0.2 using TCP port 1194 with TLS
> with about 400 clients connected to it. From time to time it's
> impossible to ping the client from the server, but if you log into the
> client and ping the server, the server now became able to ping the
> client. I made a lot of tests removing the bridge and trying a older
> versions of openvpn and the problem still hapenning with about 20% of
> the clients connected to the vpn.
>
> here is the config of the client and server:
>
> # SERVER CONFIG
> mode server
> port 1194
> proto tcp-server
> dev tap
[snip]

Observations:
1. 400 clients... 1 server only?
2. TAP means additional overhead full ethernet packet encapsulated in
TCP/IP packet.  Broadcasts, fragmented ethernet datagrams  and for 400
clients....
3. TCP over TCP is not recommended. The internal congestion control
can conflict with the external congestion control.
4. What is your full bandwidth and usable bandwidth at the server?

Troubleshooting:
Do packet captures on the real interfaces that the VPN tunnel is using
(there the TCP 1194 traffic is), the TAP interfaces.  Look for TCP
issues.

Recommendations:
1. switch to UDP
2. switch to TUN even if this requires additional configuration.  to
rely on broadcasts over a VPN is problematic.
3. Bandwidth may be a major bottleneck.  suggestions 1 & 2 will help,
but it may not be enough.
4. Server look for bottlenecks,  may require upgrade(s).  Removing one
bottleneck may reveal the next bottleneck...

--
Leonard Isham, CISSP
Ostendo non ostento.

