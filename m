Date: Thu, 16 Mar 2023 11:03:06 +0100 (CET)
Message-Id: <202303161003.32GA36lH067386@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230315013516.1256700-5-selva.nair@...277...>
References: <20230315013516.1256700-5-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a test for signing with
 certificates in Windows store
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

More tests are always welcome :-) - stared at the code (looks good),
tested on MinGW->W10 and GHA.

    [==========] Running 6 test(s).
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
    [==========] 6 test(s) run.
    [  PASSED  ] 6 test(s).

Your patch has been applied to the master and release/2.6 branch.

commit 0267649a21a2af1b60fbddcb78b0ed642080d6fd (master)
commit f970ad99a1a1f30d091853b111e678dbdc3dede9 (release/2.6)
Author: Selva Nair
Date:   Tue Mar 14 21:35:16 2023 -0400

     Add a test for signing with certificates in Windows store

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230315013516.1256700-5-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26416.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


