References: <20210520151148.2565578-1-arne@...1227...>
 <20210520151148.2565578-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8a521a85-b029-0fac-1d88-8afbe76ff13f@...2181...>
Date: Fri, 11 Jun 2021 10:32:21 +0200
MIME-Version: 1.0
In-Reply-To: <20210520151148.2565578-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 3/9] Add connection_established as
 state in tls_multi->context_auth
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 20/05/2021 17:11, Arne Schwabe wrote:
> the socket_info->connection_establish is set through
> link_socket_set_outgoing_addr when we reach FULL_SYNC. This patch
> introduces a new state in context_auth that replaces the
> connection_established state for TLS connections. This make the state
> machine easier to understand.
> 
> Patch v2: fix p2p mode server without (without ncp)
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Compile zoo is happy.

Performed various tests, including:
* classic server/client
* p2p+tls with ncp
* p2p+tls without ncp

All passed and renegotiation also worked as expected.

The patch looks sane (already reviewed v1 and the added change makes
sense) and it's a reasonable step forward towards making the state
machine simpler to understand.


Acked-by: Antonio Quartulli <antonio@...515...>
-- 
Antonio Quartulli

