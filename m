References: <AM0PR04MB53313168AE080837CBFD8ECDB1699@...2601...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cd38a67c-abf1-12f3-7a83-f44e644fd2e8@...1227...>
Date: Wed, 24 Mar 2021 23:19:24 +0100
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB53313168AE080837CBFD8ECDB1699@...2601...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] reliable: retransmit if 3 follow-up
 ACKs are received
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
To: Maximilian Fillinger <maximilian.fillinger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 18.03.21 um 20:27 schrieb Maximilian Fillinger via Openvpn-devel:

The sender is strange, this strange sender ends up in git as author.

> Hi!
> 
> I'm currently preparing the OpenVPN-NL 2.5 release at Fox-IT. (We're a
> bit behind the times...) I thought that one of our patches, by Steffan
> Karger, could be useful in regular OpenVPN. He said that he hadn't
> submitted it yet, and thought it would be a good idea to ask.

This paragraph ends up in the commit message which is probably
suboptiomal. Better use the --cover-letter option and put text like into
the 0000 mail.

> The patch increases the performance of the control channel when there is
> a small amount of packet loss by resending packets more aggressively. In
> reliable_send, packets are resent before the timeout expires if at least
> 3 later packets have been ACK'd.
> 
> The reasoning is that if we receive ACKs for later packets, the
> connection seems to be functional and we should be able to try again.
> 
> This policy is similar to many TCP implementations.
> 
> Please let me know if you think this is useful, and if you would like me
> to make any changes to the patch.

The code is fine but I would like to have a few more
comments/documentation to make easier to understand. See below:

>  #include "memdbg.h"


Comment here what this defines controls

> +#define N_ACK_RETRANSMIT 3
> +
>  /*
>   * verify that test - base < extent while allowing for base or test wraparound
>   */
> @@ -382,7 +384,10 @@ reliable_send_purge(struct reliable *rel, const struct reliable_ack *ack)
>                  }
>  #endif
>                  e->active = false;
> -                break;
> +            }
> +            else if (e->active && e->packet_id < pid)
> +            {

Add a comment like:

		   /* We have received an ACK for a packet with higher
		      PID, either the packet got lost or we received ACKS out of order */

> +                e->n_acks++;
>              }
>          }
>      }
> @@ -555,7 +560,7 @@ reliable_can_send(const struct reliable *rel)
>          if (e->active)
>          {
>              ++n_active;
> -            if (now >= e->next_try)
> +            if (now >= e->next_try || e->n_acks >= N_ACK_RETRANSMIT)
>              {
>                  ++n_current;
>              }
> @@ -581,7 +586,8 @@ reliable_send(struct reliable *rel, int *opcode)
>      for (i = 0; i < rel->size; ++i)
>      {
>          struct reliable_entry *e = &rel->array[i];
> -        if (e->active && local_now >= e->next_try)
> +        if (e->active
> +            && (e->n_acks >= N_ACK_RETRANSMIT || local_now >= e->next_try))
>          {
>              if (!best || reliable_pid_min(e->packet_id, best->packet_id))
>              {
> @@ -599,6 +605,7 @@ reliable_send(struct reliable *rel, int *opcode)
>          /* constant timeout, no backoff */
>          best->next_try = local_now + best->timeout;
>  #endif
> +        best->n_acks = 0;
>          *opcode = best->opcode;
>          dmsg(D_REL_DEBUG, "ACK reliable_send ID " packet_id_format " (size=%d to=%d)",
>               (packet_id_print_type)best->packet_id, best->buf.len,
> @@ -686,6 +693,7 @@ reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf,
>              e->opcode = opcode;
>              e->next_try = 0;
>              e->timeout = 0;
> +            e->n_acks = 0;
>              dmsg(D_REL_DEBUG, "ACK mark active incoming ID " packet_id_format, (packet_id_print_type)e->packet_id);
>              return;
>          }
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index a84d4290..bf0b561b 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
> @@ -72,6 +72,7 @@ struct reliable_entry
>      interval_t timeout;
>      time_t next_try;
>      packet_id_type packet_id;

I would like to see here a description what this does, like:

/* Number of ACKs received for packets with higher pid.
   Used for fast retransmit after 3 ACKS */

> +    size_t n_acks;
>      int opcode;
>      struct buffer buf;
>  };
> 


