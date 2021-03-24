References: <20210319153129.8734-2-arne@...1227...>
 <20210324220853.31246-1-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <145064f3-be4b-0c5c-8cfc-ac704bd49498@...277...>
Date: Wed, 24 Mar 2021 23:12:01 +0000
MIME-Version: 1.0
In-Reply-To: <20210324220853.31246-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2] Implement '--compress migrate' to
 migrate to non-compression setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I found a typo, so I double checked every comment.

On 24/03/2021 22:08, Arne Schwabe wrote:

<snipped and reviewed - AOK>

> diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
> index 741a7782..472aa591 100644
> --- a/src/openvpn/ssl_util.h
> +++ b/src/openvpn/ssl_util.h
> @@ -54,4 +54,19 @@ extract_var_peer_info(const char *peer_info,
>    */
>   unsigned int
>   extract_iv_proto(const char *peer_info);
> +
> +/**
> + * Takes a locally produced OCC string for TLS server mode and modifies as
> + * if the option comp-lzo was enabled. This is to send a client in
> + * comp-lzo migrate mode the expected OCC string.
> + *
> + * Note: This function excpets the string to be in the locally generated

typo: excpets

> + * format and does not accept arbitrary strings.
> + *
> + * @param options   the locally generated OCC string
> + * @param gc        gc_arena to allocate the returned string in
> + * @return          the modified string or options on error
> + */
> +const char *
> +options_string_compat_lzo(const char *options, struct gc_arena *gc);
>   #endif
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
> index 50f3a02e..44b77cc5 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am

<snipped and reviewed - AOK>

-- 

