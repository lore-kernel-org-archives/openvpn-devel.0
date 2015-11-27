From: Arne Schwabe <arne@...1227...>
References: <1447254557-22524-1-git-send-email-heiko.hund@...1489...>
Message-ID: <56582FD0.7000009@...1227...>
Date: Fri, 27 Nov 2015 11:26:24 +0100
MIME-Version: 1.0
In-Reply-To: <1447254557-22524-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] extend management interface command
 "state"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net



Am 11.11.15 um 16:09 schrieb Heiko Hund:
>        and EXITING to show the reason for the disconnect),
> -  (d) optional TUN/TAP local IP address (shown for ASSIGN_IP
> -      and CONNECTED), and
> -  (e) optional address of remote server (OpenVPN 2.1 or higher).
> +  (d) optional TUN/TAP local IPv4 address
> +  (e) optional address of remote server,
> +  (f) optional port of remote server,
> +  (g) optional local address,
> +  (h) optional local port, and
> +  (i) optional TUN/TAP local IPv6 address.
> +
> +Fields (e)-(h) are shown for CONNECTED state,
> +(d) and (i) are shown for ASSIGN_IP and CONNECTED states.
> +
> +(e) is available starting from OpenVPN 2.1
> +(f)-(i) are available starting from OpenVPN 2.4


Should we add a note that e,f are the connect time and changed because
of --float? Otherwise ACK from me.

Arne

