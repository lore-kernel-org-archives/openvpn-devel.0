Date: Sun, 21 Jun 2020 10:42:29 +0200 (CEST)
Message-Id: <202006210842.05L8gTa0035037@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200605112519.22714-3-arne@...1227...>
References: <20200605112519.22714-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add unit test for cipher name
 translations
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

"It works"...

[==========] Running 2 test(s).
[ RUN      ] crypto_pem_encode_decode_loopback
[       OK ] crypto_pem_encode_decode_loopback
[ RUN      ] crypto_translate_cipher_names
[       OK ] crypto_translate_cipher_names
[==========] 2 test(s) run.
[  PASSED  ] 2 test(s).
PASS: crypto_testdriver


Tested on:

  Linux with mbedTLS 2.22.0-r1
  Linux with OpenSSL 1.1.1
  FreeBSD 11.3 with OpenSSL 1.0.2s
  FreeBSD 12.1 with OpenSSL 1.1.1d

Your patch has been applied to the master branch.

commit 3bc12aefd571ab24543cff4cba2f0e25d3268941
Author: Arne Schwabe
Date:   Fri Jun 5 13:25:19 2020 +0200

     Add unit test for cipher name translations

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200605112519.22714-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19968.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


