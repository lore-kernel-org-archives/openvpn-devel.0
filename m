Date: Mon, 27 Jun 2022 10:36:02 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yrlr8uhcV0rUMhT6@...2678...>
References: <20220625234150.3398864-1-arne@...1227...>
 <20220625234150.3398864-4-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220625234150.3398864-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 4/5] Implement a function to
 calculate the default MTU
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

NACK. See below.

On Sun, Jun 26, 2022 at 01:41:49AM +0200, Arne Schwabe wrote:
> diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
> index 83572b827..ca595b0a5 100644
> --- a/tests/unit_tests/openvpn/test_crypto.c
> +++ b/tests/unit_tests/openvpn/test_crypto.c
> @@ -477,6 +477,22 @@ test_mssfix_mtu_calculation(void **state)
>      gc_free(&gc);
>  }
>  
> +
> +static void
> +test_mtu_default_calculation(void **state)
> +{
> +    struct options o = {0};
> +
> +    /* common defaults */
> +    o.ce.tun_mtu = 1400;
> +    o.ce.mssfix = 1000;
> +    o.replay = true;
> +    o.ce.proto = PROTO_UDP;
> +
> +    size_t mtu = frame_calculate_default_mtu(&o);
> +    assert_int_equal(1420, mtu);

As mentioned this is true for the specific options configured above.
But you can easily also get different values out of this function by
changing the options because frame_calculate_payload overhead does
not always return the same value.

There are various things you could do:
1) you could add a test here to show that this is expected
behavior.
2) you could add a comment here to the same effect
(although I would prefer an actual test)
3) you could change the function so that it actually always
returns the same value (e.g. by overriding fragment
and comp settings like you do for use_peer_id)

But doing nothing is not an option, IMHO. That will just
confuse others in the future.

Regards,
  Frank

