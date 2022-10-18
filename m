Date: Tue, 18 Oct 2022 18:16:54 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y07RdvYxfDw+YLmC@...2685...>
References: <20220921104930.3452270-1-arne@...1227...>
 <20220921104930.3452270-3-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220921104930.3452270-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4 3/3] Add unit test for
 reliable_get_num_output_sequenced_available
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2699...>

Already acked in 1957647252.642516.1652264253337@...2642...

On Wed, Sep 21, 2022 at 12:49:30PM +0200, Arne Schwabe wrote:
> Patch v4: rebase
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  tests/unit_tests/openvpn/Makefile.am       |  5 +-
>  tests/unit_tests/openvpn/mock_get_random.c | 10 ++++
>  tests/unit_tests/openvpn/test_packet_id.c  | 55 ++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
> index 65cf9549c..c7846f3e6 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -61,7 +61,10 @@ packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
>  	$(openvpn_srcdir)/buffer.c \
>  	$(openvpn_srcdir)/otime.c \
>  	$(openvpn_srcdir)/packet_id.c \
> -	$(openvpn_srcdir)/platform.c
> +	$(openvpn_srcdir)/platform.c \
> +	$(openvpn_srcdir)/reliable.c \
> +    $(openvpn_srcdir)/session_id.c
> +
>  
>  pkt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
>  	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
> diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
> index d0d2574ae..787b5e33e 100644
> --- a/tests/unit_tests/openvpn/mock_get_random.c
> +++ b/tests/unit_tests/openvpn/mock_get_random.c
> @@ -26,6 +26,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <setjmp.h>
> +#include <stdint.h>
>  #include <cmocka.h>
>  
>  unsigned long
> @@ -34,3 +35,12 @@ get_random(void)
>      /* rand() is not very random, but it's C99 and this is just for testing */
>      return rand();
>  }
> +
> +void
> +prng_bytes(uint8_t *output, int len)
> +{
> +    for (int i = 0; i < len; i++)
> +    {
> +        output[i] = rand();
> +    }
> +}
> diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
> index a3d4db285..c610d9727 100644
> --- a/tests/unit_tests/openvpn/test_packet_id.c
> +++ b/tests/unit_tests/openvpn/test_packet_id.c
> @@ -36,6 +36,7 @@
>  #include <cmocka.h>
>  
>  #include "packet_id.h"
> +#include "reliable.h"
>  
>  #include "mock_msg.h"
>  
> @@ -156,6 +157,59 @@ test_packet_id_write_long_wrap(void **state)
>      assert_true(data->test_buf_data.buf_time == htonl(now));
>  }
>  
> +static void
> +test_get_num_output_sequenced_available(void **state)
> +{
> +
> +    struct reliable *rel = malloc(sizeof(struct reliable));
> +    reliable_init(rel, 100, 50, 8, false);
> +
> +    rel->array[5].active = true;
> +    rel->array[5].packet_id = 100;
> +
> +    rel->packet_id = 103;
> +
> +    assert_int_equal(5, reliable_get_num_output_sequenced_available(rel));
> +
> +    rel->array[6].active = true;
> +    rel->array[6].packet_id = 97;
> +    assert_int_equal(2, reliable_get_num_output_sequenced_available(rel));
> +
> +    /* test ids close to int/unsigned int barrier */
> +
> +    rel->array[5].active = true;
> +    rel->array[5].packet_id = (0x80000000u -3);
> +    rel->array[6].active = false;
> +    rel->packet_id = (0x80000000u -1);
> +
> +    assert_int_equal(6, reliable_get_num_output_sequenced_available(rel));
> +
> +    rel->array[5].active = true;
> +    rel->array[5].packet_id = (0x80000000u -3);
> +    rel->packet_id = 0x80000001u;
> +
> +    assert_int_equal(4, reliable_get_num_output_sequenced_available(rel));
> +
> +
> +    /* test wrapping */
> +    rel->array[5].active = true;
> +    rel->array[5].packet_id = (0xffffffffu -3);
> +    rel->array[6].active = false;
> +    rel->packet_id = (0xffffffffu - 1);
> +
> +    assert_int_equal(6, reliable_get_num_output_sequenced_available(rel));
> +
> +    rel->array[2].packet_id = 0;
> +    rel->array[2].active = true;
> +
> +    assert_int_equal(6, reliable_get_num_output_sequenced_available(rel));
> +
> +    rel->packet_id = 3;
> +    assert_int_equal(1, reliable_get_num_output_sequenced_available(rel));
> +
> +    reliable_free(rel);
> +}
> +
>  int
>  main(void)
>  {
> @@ -178,6 +232,7 @@ main(void)
>          cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
>                                          test_packet_id_write_setup,
>                                          test_packet_id_write_teardown),
> +        cmocka_unit_test(test_get_num_output_sequenced_available)
>      };
>  
>      return cmocka_run_group_tests_name("packet_id tests", tests, NULL, NULL);
> -- 
> 2.37.0 (Apple Git-136)
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
  Frank Lichtenheld

