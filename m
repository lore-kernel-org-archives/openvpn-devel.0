References: <20200426095402.65047-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7f2a7b8e-8134-308c-8506-a53f28976d4e@...1856...>
Date: Sun, 26 Apr 2020 12:00:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200426095402.65047-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Uncrustify the tests/unit_tests/ part
 of our tree.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 26-04-2020 11:54, Gert Doering wrote:
> Apply uncrustify 0.70.1 (FreeBSD port) with our rules to that part
> of the tree, which followed a more compact coding style so far.
> ---
> 
> @@ -155,20 +157,21 @@ test_packet_id_write_long_wrap(void **state)
>  }
>  
>  int
> -main(void) {
> +main(void)
> +{
>      const struct CMUnitTest tests[] = {
> -            cmocka_unit_test_setup_teardown(test_packet_id_write_short,
> -                    test_packet_id_write_setup, test_packet_id_write_teardown),
> -            cmocka_unit_test_setup_teardown(test_packet_id_write_long,
> -                    test_packet_id_write_setup, test_packet_id_write_teardown),
> -            cmocka_unit_test_setup_teardown(test_packet_id_write_short_prepend,
> -                    test_packet_id_write_setup, test_packet_id_write_teardown),
> -            cmocka_unit_test_setup_teardown(test_packet_id_write_long_prepend,
> -                    test_packet_id_write_setup, test_packet_id_write_teardown),
> -            cmocka_unit_test_setup_teardown(test_packet_id_write_short_wrap,
> -                    test_packet_id_write_setup, test_packet_id_write_teardown),
> -            cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
> -                    test_packet_id_write_setup, test_packet_id_write_teardown),
> +        cmocka_unit_test_setup_teardown(test_packet_id_write_short,
> +                                        test_packet_id_write_setup, test_packet_id_write_teardown),
> +        cmocka_unit_test_setup_teardown(test_packet_id_write_long,
> +                                        test_packet_id_write_setup, test_packet_id_write_teardown),
> +        cmocka_unit_test_setup_teardown(test_packet_id_write_short_prepend,
> +                                        test_packet_id_write_setup, test_packet_id_write_teardown),
> +        cmocka_unit_test_setup_teardown(test_packet_id_write_long_prepend,
> +                                        test_packet_id_write_setup, test_packet_id_write_teardown),
> +        cmocka_unit_test_setup_teardown(test_packet_id_write_short_wrap,
> +                                        test_packet_id_write_setup, test_packet_id_write_teardown),
> +        cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
> +                                        test_packet_id_write_setup, test_packet_id_write_teardown),
>      };

This now exceeds 80 chars by a fair amount. Perhaps rewrap?

Otherwise this looks good to me. I think having consistent style over
the code base, including tests, would be good.

-Steffan

