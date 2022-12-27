Message-ID: <bfdbb32a-3563-ffd8-7b20-885278960586@...1227...>
Date: Tue, 27 Dec 2022 21:39:30 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221224230807.1827964-1-gert@...1296...#>
 <20221227202614.2114971-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221227202614.2114971-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] bandaid fix for TCP multipoint
 server crash with Linux-DCO
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 27.12.22 um 21:26 schrieb Gert Doering:
> TCP multipoint servers with Linux-DCO can crash under yet-unknown
> circumstances where a TCP socket gets handed to the kernel (= userland
> shall not acceess it again) but the socket still lands in the event
> polling mechanism, and is passed to link_socket_read() with
> sock->fd being "-1" (SOCKET_UNDEFINED).
> 
> This is a bug, but it happens very unfrequently so not fixed yet.
> 
> When this happens, the server gets stuck in an endless loop of
> "trying recvfrom(-1, ..), getting an error, looging that error,
> continue" until the server's disk is full.
> 
> The situation is being made a bit more complex by the dco-win
> approach of treating "all kernel sockets as UDP", so the Linux
> implementation tries to access the -1 socket as UDP, confusing
> the picture more.
> 
> As a bandaid to avoid the crash, this patch changes
> 
>   - socket.h: only do the "if dco_installed, treat as UDP" for WIN32
>     (link_socket_read())
> 
>   - socket.c: add ASSERT(sock->fd >= 0); checks to all UDP socket paths
>     (we should never even hit those as this is a TCP specific problem,
>     but in the "sock->fd = -1" case, doing a clean server abort is
>     preferred to "the disk is full with non-helpful logfiles, and then
>     the server crashes anyway")
> 
>   - socket.c: in the TCP read function, link_socket_read_tcp(),
>     check for sock->fd < 0 and trigger "sock->stream_reset = true"
>     (+ write to the log what happened).
> 
> This change will kill this particular TCP client instance (SIGTERM),
> but leave the rest of the server running fine - and given that
> in our tests this issue seems to be triggered by inbound TCP RST
> in just the wrong moment, it seems to be "a properly-sized bandaid".
> 
> v2: rebase on top of "move dco_installed back to link_socket"
> v3: move sock->fd check inside !residual_fully_formed clause (so
>      we can still handle already-read packets)

Acked-By: Arne Schwabe <arne@...1227...>

The move of going the tcp read path and allowing the 
residual_fully_formed path to work makes the problem non-reproducible 
for me so far


