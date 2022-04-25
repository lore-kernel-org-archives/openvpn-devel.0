Date: Mon, 25 Apr 2022 11:59:32 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1250450261.315455.1650880772683@...2642...>
In-Reply-To: <20220422134038.3801239-9-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422134038.3801239-9-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 08/28] Split out reliable_ack_parse from
 reliable_ack_read
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Changes look good to me, applies on current master and compiles.
One error in function documentation, but probably fixable on apply. See below.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 15:40 geschrieben:
[...]
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index cd80bbfb2..05426fd8c 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
> @@ -126,6 +126,28 @@ struct reliable
>  bool reliable_ack_read(struct reliable_ack *ack,
>                         struct buffer *buf, const struct session_id *sid);
>  
> +
> +/**
> + * Parse an acknowledgment record from a received packet.
> + *
> + * This function parses the packet ID acknowledgment record from the packet
> + * contained in \a buf.  If the record contains acknowledgments, these are
> + * stored in \a ack.  This function also compares extracts packet's session ID

Remove "compares".

> + * and returns it in \a session_id_remote

--
Frank Lichtenheld

