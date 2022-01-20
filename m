Message-ID: <6e6d7308-08dd-d265-1071-a63c35fbf99d@...1227...>
Date: Thu, 20 Jan 2022 15:29:50 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220120101125.31234-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220120101125.31234-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] unit-test: fix test_crypto when
 USE_COMP is not defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 20.01.22 um 11:11 schrieb Antonio Quartulli:
> This unit-test did not consider the case when USE_COMP is not defined,
> thus generating a compiler error.
> 
> Adapt the test to the case when no compression is available and while at
> it, decompose the expected MTU values by featureso that it is easier to
> understand.
> 
> Cc: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>   tests/unit_tests/openvpn/test_crypto.c | 52 +++++++++++++++-----------
>   1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
> index 19ce174e..851696fe 100644
> --- a/tests/unit_tests/openvpn/test_crypto.c
> +++ b/tests/unit_tests/openvpn/test_crypto.c
> @@ -255,7 +255,7 @@ test_occ_mtu_calculation(void **state)
>       o.ciphername = "none";
>       o.authname = "none";
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1400);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu);
>   
>       /* Static key OCC examples */
>       o.shared_secret_file = "not null";
> @@ -264,44 +264,51 @@ test_occ_mtu_calculation(void **state)
>       o.ciphername = "none";
>       o.authname = "none";
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1408);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 8);
>   
>       /* secret, cipher AES-128-CBC, auth none */
>       o.ciphername = "AES-128-CBC";
>       o.authname = "none";
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1440);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 8 + 32);
>   
>       /* secret, cipher none, auth SHA256 */
>       o.ciphername = "none";
>       o.authname = "SHA256";
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1440);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 8 + 32);
>   
> -    /* --secret, cipher BF-CBC, auth SHA1 */
> +    /* secret, cipher BF-CBC, auth SHA1 */
>       o.ciphername = "BF-CBC";
>       o.authname = "SHA1";
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1444);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 8 + 36);

if you want semantic things here that should be + 20 /*  sha1 */ + 16 
/*bf-cbc */

>   
> -    /* --secret, cipher BF-CBC, auth SHA1, tcp-client */
> +    /* secret, cipher BF-CBC, auth SHA1, tcp-client */
>       o.ce.proto = PROTO_TCP_CLIENT;
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1446);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 8 + 36 + 2);
>   
>       o.ce.proto = PROTO_UDP;
>   
> -    /* --secret, comp-lzo yes, cipher BF-CBC, auth SHA1 */
> +    int comp_bytes = 0;
> +#if defined(USE_COMP)
> +    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1 */
>       o.comp.alg = COMP_ALG_LZO;
> +    comp_bytes = 1;
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1445);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 8 + comp_bytes + 36);
> +#endif

why the extra variable and not just +1?
>   
> -    /* --secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
> +    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
>       o.ce.fragment = 1200;
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1449);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 8 + comp_bytes + 36 + 4);
>   
I would rather have this also under COMP_DEF than to add this different 
tests depending on compile flags.


> +    comp_bytes = 0;
> +#if defined(USE_COMP)
>       o.comp.alg = COMP_ALG_UNDEF;
> +#endif
>       o.ce.fragment = 0;
>   
>       /* TLS mode */
> @@ -309,32 +316,32 @@ test_occ_mtu_calculation(void **state)
>       o.tls_client = true;
>       o.pull = true;
>   
> -    /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth*/
> +    /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */
>       o.authname = "SHA1";
>       o.ciphername = "AES-128-CBC";
>       o.tls_auth_file = "dummy";
>   
>       linkmtu = calc_options_string_link_mtu(&o, &f);
> -    assert_int_equal(linkmtu, 1457);
> +    assert_int_equal(linkmtu, o.ce.tun_mtu + 5 + 8 + 32 + 12);


I think this one is wrong sha1 is 20 and aes-128-cbc is 16.


If we really want to split the magic nubmers, we should split them in 
the right way, otherwise it becomes more confsuing than it is helpful.

Arne



