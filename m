References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
	<20151121200637.GD24952@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5650E04B.2020002@...1227...>
Date: Sat, 21 Nov 2015 22:21:15 +0100
MIME-Version: 1.0
In-Reply-To: <20151121200637.GD24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Christian Pellegrin <chripell@...410...>
Cc: openvpn-devel@lists.sourceforge.net


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 

>> +++ b/src/openvpn/socket.c >> @@ -1670,7 +1670,7 @@ phase2_set_socket_flags (struct link_socket*
sock) >>      set_cloexec (sock->ctrl_sd); >>   >>    /* set Path MTU
discovery options on the socket */ >> -  set_mtu_discover_type
(sock->sd, sock->mtu_discover_type, sock->info.af); >> + 
set_mtu_discover_type (sock->sd, sock->mtu_discover_type,
sock->info.lsa->bind_local->ai_family); > > ... on a client with
--nobind, this immediately crashes as lsa->bind_local > is not set... >
> Sat Nov 21 21:01:48 2015 OpenVPN 2.3_git
[git:master/48c23dc92006e1d8+] i686-pc-linux-gnu [SSL (OpenSSL)] [LZO]
[LZ4] [EPOLL] [MH] [IPv6] built on Nov 21 2015 > Sat Nov 21 21:01:48
2015 library versions: OpenSSL 1.0.2d 9 Jul 2015, LZO 2.08 > Sat Nov 21
21:01:48 2015 TCP/UDP: Preserving recently used remote address:
[AF_INET]199.102.77.82:51194 > Sat Nov 21 21:01:48 2015 Socket Buffers:
R=[110592->110592] S=[110592->110592] > > Program received signal
SIGSEGV, Segmentation fault. > 0x0809c165 in phase2_set_socket_flags
(sock=0x80ee270) >     at ../../../openvpn/src/openvpn/socket.c:1673 >
1673      set_mtu_discover_type (sock->sd, sock->mtu_discover_type,
sock->info.lsa->bind_local->ai_family); > > (gdb) print
sock->info.lsa->bind_local > $1 = (struct addrinfo *) 0x0 > > > So,
overruling Arne's ACK and not applying it :-) > > > I wonder if the
*right* fix for this case wouldn't be to extend this > code block
(before calling phase2_set_socket_flags(), socket.c line 1880): >
>           if (sock->bind_local  && !sock->remote_host &&
sock->info.lsa->bind_local) >             { >               /* Warn if
this is because neither v4 or v6 was specified >                * and we
should not connect a remote */ >               if (sock->info.af ==
AF_UNSPEC) >                 msg (M_WARN, "Could not determine IPv4/IPv6
protocol. Using %s", >                     
addr_family_name(sock->info.lsa->bind_local->ai_family)); >
>               create_socket (sock, sock->info.lsa->bind_local);
>             } > > into... > >               if (sock->info.af ==
AF_UNSPEC) > +        { >                    msg (M_WARN, "Could not
determine IPv4/IPv6 protocol. Using %s", >                     
addr_family_name(sock->info.lsa->bind_local->ai_family)); > +          
sock->info.af = sock->info.lsa->bind_local->ai_family; > +        } > >
which would catch your case, but also the "--nobind and we have a
remote" > case (client). > > Arne, what do you think?

For clients you never get into that codeblock because a remote either
resolves (and then has an AF family or does not resolve). For a server
we also bail out if we cannot resolve the bind address (with :: or
0.0.0.0 being the default). The only case you can into that is with a
weird config like mtu-discovery.

@Christian, how did you manage to trigger the bug?

Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (MingW32)
 
iEYEARECAAYFAlZQ4EsACgkQe8+cMNS4zRd+cACgxx/d2wY7GdyNkb+/YY93Vxoq
TZUAoOWgpd0OgR0BtbWhwwpU/ZYzRq8O
=4VJ/
-----END PGP SIGNATURE-----


