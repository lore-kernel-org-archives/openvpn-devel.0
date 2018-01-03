MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Tue, 2 Jan 2018 21:22:52 -0500
Message-ID: <CAKuzo_gJK_1jU5juC1YQzKzm=25Cm+c-3X7-pT1DW_fkkW_9dQ@...278...>
Subject: [Openvpn-devel] openvpn segfaults on --management-external-key with
 ECC certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I expected an error message saying only RSA certs are supported for
--management-external-key, but openvpn appears to segfault if a cert
with an ECC key is used with that option.

A stack trace shows it fails in ssl_openssl.c line 1117 when trying to
copy n and e. In fact the call

pub_rsa = EVP_PKEY_get0_RSA(pkey);

before that (line 1104) should have failed and the code does correctly
check its return value. But that call succeeds for some reason.
Instead, RSA_get0_key() returns invalid n and e pointers and passing
those to BN_dup() fails.

This is with openssl 1.0.1 and that could be the problem -- it may not
have EVP_PKEY_get0_RSA() in which case the compatibility interface in
use is probably not smart enough...

Is this a known issue or is it just me?

Selva

P.S.

FWIW, here is where it blows up: master built with --disable-lzo and CLFAGS = -g

#0  0x00007ffff73fdc49 in BN_copy () from
/usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0
#1  0x00007ffff73fdd46 in BN_dup () from
/usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0
#2  0x0000000000488932 in tls_ctx_use_external_private_key
(ctx=0x7fffffffded0, cert_file=0x70faa8 "sansel-ecc.crt",
    cert_file_inline=0x0) at ssl_openssl.c:1117
#3  0x000000000047e88d in init_ssl (options=0x7fffffffd730,
new_ctx=0x7fffffffded0) at ssl.c:658
#4  0x00000000004240e4 in do_init_crypto_tls_c1 (c=0x7fffffffd730) at
init.c:2514
#5  0x00000000004244ce in do_init_crypto_tls (c=0x7fffffffd730,
flags=3) at init.c:2617
#6  0x0000000000424f64 in do_init_crypto (c=0x7fffffffd730, flags=3)
at init.c:2866
#7  0x00000000004271a8 in init_instance (c=0x7fffffffd730,
env=0x707c90, flags=4) at init.c:4083
#8  0x0000000000426d6f in init_instance_handle_signals
(c=0x7fffffffd730, env=0x707c90, flags=4) at init.c:3894
#9  0x00000000004445bc in tunnel_point_to_point (c=0x7fffffffd730) at
openvpn.c:91
#10 0x00000000004449c4 in openvpn_main (argc=3, argv=0x7fffffffe618)
at openvpn.c:305
#11 0x0000000000444ac8 in main (argc=3, argv=0x7fffffffe618) at openvpn.c:388

