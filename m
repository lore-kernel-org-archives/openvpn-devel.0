Date: Thu, 21 Oct 2021 08:30:55 +0200 (CEST)
Message-Id: <202110210630.19L6UtsF042283@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-18-arne@...1227...>
References: <20211019183127.614175-18-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add small unit test for testing
 HMAC
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Unit tests are good :-) - tested with OpenSSL 1.1.1 and mbedTLS builds

[==========] Running 4 test(s).
[ RUN      ] crypto_pem_encode_decode_loopback
[       OK ] crypto_pem_encode_decode_loopback
[ RUN      ] crypto_translate_cipher_names
[       OK ] crypto_translate_cipher_names
[ RUN      ] crypto_test_tls_prf
[       OK ] crypto_test_tls_prf
[ RUN      ] crypto_test_hmac
[       OK ] crypto_test_hmac
[==========] 4 test(s) run.
[  PASSED  ] 4 test(s).
PASS: crypto_testdriver


Your patch has been applied to the master branch.

commit bf079db4888381791308e08b1de9b87670a72c95
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:23 2021 +0200

     Add small unit test for testing HMAC

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211019183127.614175-18-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23012.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


