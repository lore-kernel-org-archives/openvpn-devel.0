Message-ID: <55dfca69-67f1-4afa-8b05-a0bfddb94929@...1227...>
Date: Thu, 24 Apr 2025 10:26:53 +0200
MIME-Version: 1.0
References: <20250423175843.104553-1-walter.openvpn@...2889...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20250423175843.104553-1-walter.openvpn@...2889...>
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
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
To: walter.openvpn@...2889..., openvpn-devel@lists.sourceforge.net

Am 23.04.25 um 19:58 schrieb walter.openvpn--- via Openvpn-devel:
> From: Walter Doekes <walter+github@...2889...>
> 
> When you're connected to a VPN which is used as the default gateway, a
> connection to a second VPN will cause a tunnel-in-tunnel. If the
> administrator of the second VPN wants to avoid that, by pushing its IP
> as net_gateway, this means that the client's source IP switches right
> after connect:
> 
>    the source IP switches from the first-VPN-exit-IP to the
>    regular-ISP-exit-IP
> 
> In openvpn 2.5 and below, this worked fine. Since openvpn 2.6, this
> triggers the "Disallow float to an address taken by another client"
> code. The root cause for this change of behaviour is as of yet
> unexplained.
> 
> This change allows one to switch to the new IP, if it is still in an
> unconnected state. That makes the use-case mentioned above work again.


I still do not really understanding what network setup you have to 
trigger this kind of bizzare behaviour of having a VPN connection.
It would really be helpful if you can describe that more. Since the 
current explainations do not really explain for me why there is already 
an existing half-established connection.

The scenario you are fixing seem like:

  * somehow a connection attempt is done from IP A
  * a connection is fully established for IP B
  * connection for IP B tries to move to IP A


You are also saying that there is a difference in OpenVPN 2.5 vs OPneVPN 
2.6. If that is indeed the case, a git bisect would be helpful to point 
to the commit that is breaking this.

 > msg(M_INFO, "peer %" PRIu32 " (%s) floating from %s to %s (m2 still 
setting up) state=%d/%d",

A user has no idea what m2 is. This message more confusing than helpful.


> +	/* if the new connection is fresh and the old one is already connected, this
> +	 * might be a legitimate move to a new IP by the original client;
> +	 * for example when the server IP is pushed as net_gateway to escape from
> +	 * a double VPN. */
> +	if (m1->multi_state == CAS_CONNECT_DONE && m2->multi_state == CAS_NOT_CONNECTED
> +		&& m1->locked_cert_hash_set && !m2->locked_cert_hash_set)

The code doesn't really do what the comment does. If you were trying to 
actually figure out if it is the same client you should rather compare 
the session ID of the tls state.

Also I think this code looks on the first glance to be broken in the way 
that an authorized client could just send a bunch of data packets with 
faked sender ip and then kill of other connections that are in the 
progress of connection.

Arne

