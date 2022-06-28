From: Heiko Hund <heiko@...2662...>
Date: Tue, 28 Jun 2022 14:36:51 +0200
Message-ID: <10501487.6ZjQEG7bFu@...2664...>
In-Reply-To: <20220628082024.19059-1-a@...2181...>
References: <20220628082024.19059-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] do not push route-ipv6 entries that
 are also in the iroute-ipv6 list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Dienstag, 28. Juni 2022 10:20:24 CEST Antonio Quartulli wrote:
> A server should push a route to a client only if there is no matching
> iroute for the same client.
> 
> While this logic works fine for IPv4, there is no IPv6 counterpart.
> 
> Implement the same check for IPv6 routes and discard matching ones
> from the push list.
> 
> Trac: #354
> Cc: Gert Doering <gert@...1296...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

ACK





