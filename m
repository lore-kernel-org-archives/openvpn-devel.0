References: <20210422151724.2132573-1-arne@...1227...>
 <20210501223545.3669495-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0cf4ecd5-6c4c-87b1-4ed8-baa8a1346eca@...2181...>
Date: Thu, 13 May 2021 22:03:58 +0200
MIME-Version: 1.0
In-Reply-To: <20210501223545.3669495-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Add connection_established as state in
 tls_multi->context_auth
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 02/05/2021 00:35, Arne Schwabe wrote:
> the socket_info->connection_establish is set through
> link_socket_set_outgoing_addr when we reach FULL_SYNC. This patch
> introduces a new state in context_auth that replaces the
> connection_established state for TLS connections. This make the state
> machine easier to understand.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This change indeed is another step towards the TLS state machine
simplification.

It gives a better meaning to the various states, introducing a first
concept of "order", with the first state being "offline" and the last
state being "online".

Acked-by: Antonio Quartulli <antonio@...515...>

Compiled on my zoo and tested in my basic linux setup with auth and
deferred-auth.

Regards,


-- 
Antonio Quartulli

