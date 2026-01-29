Date: Thu, 29 Jan 2026 12:17:38 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aXtB0gCc1MRNG6Dw@...2915...>
References: <20260128124410.429529-1-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20260128124410.429529-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 1/3] ovpn: set sk_user_data
 before overriding callbacks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

2026-01-28, 13:44:08 +0100, Ralf Lici wrote:
> During initialization, we override socket callbacks and set sk_user_data
> to an ovpn_socket instance. Currently, these two operations are
> decoupled: callbacks are overridden before sk_user_data is set. While
> existing callbacks perform safety checks for NULL or non-ovpn
> sk_user_data, this condition causes a "half-formed" state where valid
> packets arriving during attachment trigger error logs (e.g., "invoked on
> non ovpn socket").
> 
> Set sk_user_data before overriding the callbacks so that it can be
> accessed safely from them. Since we already check that the socket has no
> sk_user_data before setting it, this remains safe even if an interrupt
> accesses the socket after sk_user_data is set but before the callbacks
> are overridden.
> 
> This also requires initializing all protocol-specific fields (such as
> tcp_tx_work and peer links) before calling ovpn_socket_attach, ensuring
> the ovpn_socket is fully formed before it becomes visible to any
> callback.
> 
> Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
> Changes since v1:
> - reset sk_user_data to NULL in case of error
> - removed a redundant goto sock_release in ovpn_socket_new
> - expanded commit message with additional information on the purpose of
>   this change
> - added explanation in the commit message of why the per-protocol
>   ovpn_sock initialization code in ovpn_socket_new was moved
> - added Fixes tag

Reviewed-by: Sabrina Dubroca <sd@...2891...>

Thanks!

-- 
Sabrina

