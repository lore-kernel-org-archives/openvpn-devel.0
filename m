From: Heiko Hund <heiko@...2662...>
Date: Mon, 01 Aug 2022 15:10:12 +0200
Message-ID: <5552893.KpEyC1MltH@...2664...>
In-Reply-To: <20220728195501.3253-1-a@...2181...>
References: <20220728195501.3253-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 14/25] dco: implement dco support for
 p2mp/server code path
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

On Donnerstag, 28. Juli 2022 21:55:01 CEST Antonio Quartulli wrote:
> This change introduces ovpn-dco support along the p2mp/server code path.
> Some code seems to be duplicate of the p2p version, but details are
> different, so it couldn't be shared.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Changes from v1:
> * fix if condition P_DATA_V2 -> P_DATA_V1
> * fix unknown reason string

Acked-by: Heiko Hund <heiko@...2662...>



