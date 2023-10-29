Date: Sun, 29 Oct 2023 22:50:05 +0100 (CET)
Message-Id: <202310292150.39TLo5O7043690@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231025121830.1030959-1-frank@...2641...>
References: <20231025121830.1030959-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for mbedtls 3.X.Y
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Max Fillinger <max@...2606...>
Cc: openvpn-devel@lists.sourceforge.net

Tested against mbedtls 3.5.0 locally installed.  Without this patch,
it complains about "2.x.x required", and with the patch it configures
and builds mostly fine.

crypto_mbedtls.c throws a warning here:

    crypto_mbedtls.c:568:1: warning: conflicting types for 'cipher_ctx_init' due to enum/integer mismatch; have 'void(mbedtls_cipher_context_t *, const uint8_t *, const char *, const mbedtls_operation_t)' {aka 'void(mbedtls_cipher_context_t *, const unsigned char *, const char *, const mbedtls_operation_t)'} [-Wenum-int-mismatch]
      568 | cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
	  | ^~~~~~~~~~~~~~~
    In file included from crypto.h:125,
		     from crypto_mbedtls.c:40:
    crypto_backend.h:352:6: note: previous declaration of 'cipher_ctx_init' with type 'void(cipher_ctx_t *, const uint8_t *, const char *, int)' {aka 'void(mbedtls_cipher_context_t *, const unsigned char *, const char *, int)'}
      352 | void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key,
	  |      ^~~~~~~~~~~~~~~

but the compilation succeeds...

    OpenVPN 2.7_git [git:vw/master/b096ce2b931347f4] x86_64-pc-linux-gnu [SSL (mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Oct 29 2023
    library versions: mbed TLS 3.5.0, LZO 2.10

as does "make check" with an exhaustive set of t_client stanzas.

All tests that require BF-CBC to succeed ("compatibility with 2.2 servers")
did fail, but the messages are clear enough

    2023-10-29 20:19:49 Unsupported cipher in --data-ciphers: BF-CBC

Building with older mbedTLS versions in GHA also succeeded.


Your patch has been applied to the master branch.

commit ace7a4f1c271550bb8ad276663e045ab97a46f16
Author: Max Fillinger
Date:   Wed Oct 25 14:18:30 2023 +0200

     Add support for mbedtls 3.X.Y

     Signed-off-by: Max Fillinger <max@...2606...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231025121830.1030959-1-frank@...2641...>
     URL: 
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


