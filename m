References: <1183acb8-7045-88b1-216b-652a4b6ac0fc@...1856...>
 <20200427012627.27568-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5e8d7dc1-b8da-49ca-e757-4e45b7267d42@...1856...>
Date: Sun, 3 May 2020 19:18:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200427012627.27568-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Do not write extra 0 byte for
 --gen-key with auth-token/tls-crypt-v2
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

On 27-04-2020 03:26, Arne Schwabe wrote:
> Change crypto_pem_encode to not put a nul-terminated terminated
> string into the buffer. This was  useful for printf but should
> not be written into the file.
> 
> Instead do not assume that the buffer is null terminated and
> print only the number of bytes in the buffer. Also fix a
> similar case in printing static key where the 0 byte was
> never added to the buffer
> 
> Patch V2: make pem_encode behave more like other similar functions in OpenVPN
>           and do not null terminate.
> 
> Patch V3: also make the mbed TLS variant of pem_decode behave like other
>           similar functions in OpeNVPN and accept a not null-terminated
>           buffer.

Thanks, this looks better. Two more things:

> @@ -273,9 +270,25 @@ crypto_pem_decode(const char *name, struct buffer *dst,
>          return false;
>      }
>  
> +    /* mbed TLS requires the src to be null-terminated */
> +    struct gc_arena gc = gc_new();
> +    struct buffer input;
> +
> +    if (*(BLAST(src)) == '\0')
> +    {
> +        input = *src;
> +    }
> +    else
> +    {
> +        /* allocate a new buffer to avoid modifying the src buffer */
> +        input = alloc_buf_gc(BLEN(src) + 1, &gc);
> +        buf_copy(&input, src);
> +        buf_null_terminate(&input);
> +    }
> +
>      size_t use_len = 0;
>      mbedtls_pem_context ctx = { 0 };
> -    bool ret = mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(src),
> +    bool ret = mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input),
>                                                 NULL, 0, &use_len));
>      if (ret && !buf_write(dst, ctx.buf, ctx.buflen))
>      {

Maybe a matter of taste, but why not always alloc the buffer? That
simplifies the code, and performance nor memory footprint is relevant
here. Just a suggestion. I'm also fine with keeping it like this.

> diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
> index 366b48d5..f4b1f860 100644
> --- a/tests/unit_tests/openvpn/test_tls_crypt.c
> +++ b/tests/unit_tests/openvpn/test_tls_crypt.c
> @@ -530,7 +530,8 @@ test_tls_crypt_v2_write_server_key_file(void **state) {
>      const char *filename = "testfilename.key";
>  
>      expect_string(__wrap_buffer_write_file, filename, filename);
> -    expect_string(__wrap_buffer_write_file, pem, test_server_key);
> +    expect_memory(__wrap_buffer_write_file, pem, test_server_key,
> +                  strlen(test_server_key));
>      will_return(__wrap_buffer_write_file, true);
>  
>      tls_crypt_v2_write_server_key_file(filename);
> @@ -542,7 +543,8 @@ test_tls_crypt_v2_write_client_key_file(void **state) {
>  
>      /* Test writing the client key */
>      expect_string(__wrap_buffer_write_file, filename, filename);
> -    expect_string(__wrap_buffer_write_file, pem, test_client_key);
> +    expect_memory(__wrap_buffer_write_file, pem, test_client_key,
> +                  strlen(test_client_key));
>      will_return(__wrap_buffer_write_file, true);
>  
>      /* Key generation re-reads the created file as a sanity check */
> 

ASAN tells me you're missing another one:

==26863==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x6180000023d6 at pc 0x0000004310c8 bp 0x7fffbae53b90 sp 0x7fffbae53338
READ of size 847 at 0x6180000023d6 thread T0
    #0 0x4310c7 in strcmp
(tests/unit_tests/openvpn/tls_crypt_testdriver+0x4310c7)
    #1 0x7f9234541c6e  (/lib/x86_64-linux-gnu/libcmocka.so.0+0x2c6e)
    #2 0x7f92345446f9 in _check_expected
(/lib/x86_64-linux-gnu/libcmocka.so.0+0x56f9)
    #3 0x4cd414 in __wrap_buffer_write_file
tests/unit_tests/openvpn/../../.././../openvpn/tests/unit_tests/openvpn/test_tls_crypt.c:108:5
    #4 0x4cc23b in tls_crypt_v2_write_client_key_file
tests/unit_tests/openvpn/../../.././../openvpn/src/openvpn/tls_crypt.c:709:15
    #5 0x4d0f15 in test_tls_crypt_v2_write_client_key_file_metadata
tests/unit_tests/openvpn/../../.././../openvpn/tests/unit_tests/openvpn/test_tls_crypt.c:592:5
    #6 0x7f92345444e0  (/lib/x86_64-linux-gnu/libcmocka.so.0+0x54e0)
    #7 0x7f9234544ec4 in _cmocka_run_group_tests
(/lib/x86_64-linux-gnu/libcmocka.so.0+0x5ec4)
    #8 0x4cd75a in main
tests/unit_tests/openvpn/../../.././../openvpn/tests/unit_tests/openvpn/test_tls_crypt.c:645:15
    #9 0x7f92341fd0b2 in __libc_start_main
/build/glibc-YYA7BZ/glibc-2.31/csu/../csu/libc-start.c:308:16
    #10 0x41d92d in _start
(tests/unit_tests/openvpn/tls_crypt_testdriver+0x41d92d)

-Steffan

