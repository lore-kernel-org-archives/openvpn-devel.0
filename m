Date: Tue, 24 May 2022 12:28:25 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <303267131.358836.1653388105093@...2642...>
In-Reply-To: <20220422142953.3805364-19-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-19-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 28/28] Always include ACKs for the last
 seen control packets
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

I'm convinced that this does what it is supposed to do.
Some typo fixes and one potential improvement to the UT noted below.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> This adds an LRU cache for the last seen packets from the peer to send acks
> to all recently packets. This also packets to be acknowledged even if a single

"recent"? Or "recently received"?

"This also packets" -> "This leads to packets" ? Still not pretty but at least
somewhat readable.

> P_ACK_V1 gets lost, avoiding retransmissions. The downside is that we add up
> to 28 byte to an P_ACK_V1 (7* packet_id) and up to 24 bytes to other control
> channel packets (4* packet_id + peer session id). However these small increases
> in packet size are a small price to pay for increased reliability.
> 
> Currently OpenVPN will only send the absolute minimum of ACK messages. A single
> lost ACK message will trigger a resend from the peer and another ACK message.
> 
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index 28f99d187..3792089a9 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -213,10 +213,56 @@ reliable_ack_parse(struct buffer *buf, struct reliable_ack *ack,
>      return true;
>  }
>  
> +/**
> + * Copies the first n acks from \c ack to \c ack_lru
> + */
> +void
> +copy_acks_to_lru(struct reliable_ack *ack, struct reliable_ack *ack_lru, int n)
> +{
> +    ASSERT(ack->len >= n);
> +    /* This loops is backward to ensure the same order as in ack */

Either "loop" or "loops backwards"

> +    for (int i = n-1; i >= 0; i--)
> +    {
> +        packet_id_type id = ack->packet_id[i];
> +
> +        /* Handle special case of ack_lru empty */
> +        if (ack_lru->len == 0)
> +        {
> +            ack_lru->len = 1;
> +            ack_lru->packet_id[0] = id;
> +        }
> +
> +        bool idfound = false;
> +
> +        /* Move all existing entry one to the right */

"entries"

> +        packet_id_type move = id;
> +
> +        for (int j = 0; j < ack_lru->len; j++)
> +        {
> +            packet_id_type tmp = ack_lru->packet_id[j];
> +            ack_lru->packet_id[j] = move;
> +            move = tmp;
> +
> +            if (move == id)
> +            {
> +                idfound = true;
> +                break;
> +            }
> +        }
> +
> +        if (!idfound && ack_lru->len < RELIABLE_ACK_SIZE)
> +        {
> +            ack_lru->packet_id[ack_lru->len] = move;
> +            ack_lru->len++;
> +        }
> +    }
> +}
> +
>  /* write a packet ID acknowledgement record to buf, */
>  /* removing all acknowledged entries from ack */
>  bool
>  reliable_ack_write(struct reliable_ack *ack,
> +                   struct reliable_ack *ack_lru,
>                     struct buffer *buf,
>                     const struct session_id *sid, int max, bool prepend)
>  {
[...]
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index c80949525..e55507015 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
[...]
> @@ -370,6 +374,19 @@ bool reliable_ack_acknowledge_packet_id(struct reliable_ack *ack, packet_id_type
>   */
>  struct reliable_entry *reliable_get_entry_sequenced(struct reliable *rel);
>  
> +
> +
> +/**
> + * Copies the first n acks from \c ack to \c ack_lru
> + *
> + * @param ack The reliable structure to copy the acks from
> + * @param ack_lru the reliable structure to insert the acks into

"The" for consistency

> + * @param n The number of ACKS to copy
> + */
> +void
> +copy_acks_to_lru(struct reliable_ack *ack, struct reliable_ack *ack_lru, int n);
> +
> +
>  /**
>   * Remove an entry from a reliable structure.
>   *
[...]
> diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
> index 96d3e870d..84c6455eb 100644
> --- a/tests/unit_tests/openvpn/test_packet_id.c
> +++ b/tests/unit_tests/openvpn/test_packet_id.c
> @@ -210,6 +210,39 @@ test_get_num_output_sequenced_available(void **state)
>      reliable_free(rel);
>  }
>  
> +
> +static void
> +test_copy_acks_to_lru(void **state)
> +{
> +    struct reliable_ack ack = { .len = 4, .packet_id = {2, 1, 3, 2} };
> +
> +    struct reliable_ack lru_ack = { 0 };
> +
> +    /* Test copying to empty ack structure */
> +    copy_acks_to_lru(&ack, &lru_ack, 4);
> +    assert_int_equal(lru_ack.len, 3);
> +    assert_int_equal(lru_ack.packet_id[0], 2);
> +    assert_int_equal(lru_ack.packet_id[1], 1);
> +    assert_int_equal(lru_ack.packet_id[2], 3);
> +
> +    /* Copying again should not change the result */
> +    copy_acks_to_lru(&ack, &lru_ack, 4);
> +    assert_int_equal(lru_ack.len, 3);
> +    assert_int_equal(lru_ack.packet_id[0], 2);
> +    assert_int_equal(lru_ack.packet_id[1], 1);
> +    assert_int_equal(lru_ack.packet_id[2], 3);
> +

I would suggest adding a call to copy_acks_to_lru where n is 0
and test that it leaves lru_ack unchanged.
AFAICT the current code is correct, but doesn't hurt to have a test.

> +    struct reliable_ack ack2 = { .len = 7, .packet_id = {5, 6, 7, 8, 9,10,11} };
> +
> +    /* Adding multiple acks tests if the a full array is handled correctly */
> +    copy_acks_to_lru(&ack2, &lru_ack, 7);
> +
> +    struct reliable_ack expected_ack = { .len = 8, .packet_id = {5, 6, 7, 8, 9, 10, 11,2}};
> +    assert_int_equal(lru_ack.len, expected_ack.len);
> +
> +    assert_memory_equal(lru_ack.packet_id, expected_ack.packet_id, sizeof(expected_ack.packet_id));
> +}
> +
>  int
>  main(void)
>  {

Regards,
--
Frank Lichtenheld

