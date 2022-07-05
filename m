From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:32:09 +0200
Message-ID: <5469674.Wqm9v67MU2@...2664...>
In-Reply-To: <20220624083809.23487-23-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-23-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 22/25] dco-win: introduce low-level code
 for handling ovpn-dco-win in Windows
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

On Freitag, 24. Juni 2022 10:38:06 CEST Antonio Quartulli wrote:
> +int
> +dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
> +{
> +    msg(D_DCO, "%s: peer-id %d, slot %d called but ignored", __func__,
> peerid, +        slot);
> +    /* FIXME: Implement in driver first */

Suppose this is not critical and the driver gets rid of keys itself?




