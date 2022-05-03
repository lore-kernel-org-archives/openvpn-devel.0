Date: Tue, 3 May 2022 12:06:13 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1141587845.38358.1651572373479@...2642...>
In-Reply-To: <20220422142953.3805364-14-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-14-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 23/28] Optimise three-way handshake
 condition for S_PRE_START to S_START
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

Change makes sense to me, only some commit message/comment
suggestions.
Still applies on top of 18 v3 + 22 v3 (with git am -3).
Compile/UT tested only.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> We move to the S_START when we have finished the three-way handshake. After
> the three way handshake is done, the client will send the TLS Client Hello
> packet.
> 
> Currently we consider the three way handshake only complete if all
> outgoing packet have been acked (which in this case is the one

"packets"

> HARD_RESET_CLIENT or HARD_RESET_SERVER) and also all akcs for incoming

"ACKs"

> packets are send out.

"sent" I think?

> 
> The outgoing packet ack is important as it signal that the other side is
> really responding. The need to send out all ACKs before moving to the next
> state also breaks piggybacking the ACKs onto the next control packet.

I found this paragraph confusing. Maybe something like:

"Waiting for the ack of our own packet is important as it signals that the other
side is really responding. However, the need to also send out all ACKs for
packets we received before moving to the next state breaks piggybacking the
ACKs onto the next control packet."

> 
> With this change both server and client will only send a P_CONTROL_V1 with
> the TLS Client Hello and the TLS Server Hello with piggybacked ack instead
> sending an P_ACK_V1 + P_CONTROL_V1, recuding the number of packets in a

"reducing"

> handshake by 2.
> 
> This also allows the server to avoid resending P_CONTROL_HARD_RESET_V2
> to complete the three-way handshake with HMAC. Only packets with
> an ACK contain the remote session id that we need for HMAC session id
> verification. The ACK_V1 packet that complets this three-way handshake
> can get lost. But the P_CONTROL_V1 with the piggybacked ACK will get
> retransmitted. This allows to put the burden of retransmission fully on
> the client.
> 
> The S_GOT_KEY/S_SENT_KEY -> S_ACTIVE is similar. We do not need to wait
> for the ack packet to be sent to move the state forward. This has however
> no effect on actual packets since there are normally no outstanding ACKs
> here.
> ---
>  src/openvpn/ssl.c                   | 15 +++++----------
>  tests/unit_tests/openvpn/test_pkt.c |  8 ++++----
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 5e1a23ccd..e3101c7fa 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
[...]
> @@ -2646,8 +2639,10 @@ tls_process_state(struct tls_multi *multi,
>          goto error;
>      }
>  
> -    /* Wait for Initial Handshake ACK */
> -    if (ks->state == S_PRE_START && no_pending_reliable_packets(ks))
> +    /* Check if the initial three-way Handshake is complete.
> +     * This handshake can be considered to be complete when our own
> +     * initial packet can been successfully acked. */

"has been successfully acked" ?

> +    if (ks->state == S_PRE_START && reliable_empty(ks->send_reliable))
>      {
>          ks->state = S_START;
>          state_change = true;

Regards,
--
Frank Lichtenheld

