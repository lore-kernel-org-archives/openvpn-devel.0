Date: Mon, 20 Mar 2023 18:34:18 +0100 (CET)
Message-Id: <202303201734.32KHYIHU067403@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230318144325.1316320-1-selva.nair@...277...>
References: <20230318144325.1316320-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Unit tests: add test for
 SSL_CTX_use_Cryptoapi_certificate()
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Unit tests are goood!!!! :-)

Stare-at-code looks good, and Github is happy with the result... (both
32 and 64 bit)

    [==========] Running 7 test(s).
    [ RUN      ] test_parse_hexstring
    [       OK ] test_parse_hexstring
    [ RUN      ] import_certs
    [       OK ] import_certs
    [ RUN      ] test_find_cert_bythumb
    [       OK ] test_find_cert_bythumb
    [ RUN      ] test_find_cert_byname
    [       OK ] test_find_cert_byname
    [ RUN      ] test_find_cert_byissuer
    [       OK ] test_find_cert_byissuer
    [ RUN      ] test_cryptoapi_sign
    [       OK ] test_cryptoapi_sign
    [ RUN      ] test_ssl_ctx_use_cryptoapicert
    [       OK ] test_ssl_ctx_use_cryptoapicert
    [==========] 7 test(s) run.
    [  PASSED  ] 7 test(s).

Your patch has been applied to the master and release/2.6 branch.

commit 85da9de524f34db3f6bd4ebc110b25c6bcbc273d (master)
commit 973083746727cb797248262de56fb0a707bcdb90 (release/2.6)
Author: Selva Nair
Date:   Sat Mar 18 10:43:25 2023 -0400

     Unit tests: add test for SSL_CTX_use_Cryptoapi_certificate()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230318144325.1316320-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26438.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


