From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:31:24 +0200
Message-ID: <5439977.94X2OUf111@...2664...>
In-Reply-To: <20220624083809.23487-15-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-15-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 14/25] dco: implement dco support for
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

On Freitag, 24. Juni 2022 10:37:58 CEST Antonio Quartulli wrote:
> +    uint8_t *ptr = BPTR(&dco->dco_packet_in);
> +    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
> +    if (op == P_DATA_V2 || op == P_DATA_V2)

This looks odd. Seems you wanted to check for a second opcode, or is it 
obsolete?

> +    const char *reason = "(unknown reason by ovpn-dco)";

Wouldn't "ovpn-dco: unknown reason" be better?





