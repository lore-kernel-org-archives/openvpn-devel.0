Date: Wed, 29 Mar 2023 11:23:20 +0200 (CEST)
Message-Id: <202303290923.32T9NK1v008759@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230322221456.1660425-3-selva.nair@...277...>
References: <20230322221456.1660425-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable pkcs11 an dtest_pkcs11
 in github actions
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

Ran this through GHA, it claims success, and claims having tested this...

[==========] Running 3 test(s).
Slot 0 has a free/uninitialized token.
The token has been initialized and is reassigned to slot 347291425
[ RUN      ] test_pkcs11_ids
[       OK ] test_pkcs11_ids
[ RUN      ] test_tls_ctx_use_pkcs11
[       OK ] test_tls_ctx_use_pkcs11
[ RUN      ] test_tls_ctx_use_pkcs11__management
[       OK ] test_tls_ctx_use_pkcs11__management
Found token (b36c3fa5-a027-3fc0-2be4-05ee94b33f21) with matching token label.
The token (softhsm2_tokens_53u42S/b36c3fa5-a027-3fc0-2be4-05ee94b33f21) has been deleted.
[  PASSED  ] 3 test(s).
[==========] 3 test(s) run.
PASS: pkcs11_testdriver

.. very nice!

Your patch has been applied to the master branch.

commit 9283c3980ff543e20f76fdfb4f4e59d5a9162d62
Author: Selva Nair
Date:   Wed Mar 22 18:14:56 2023 -0400

     Enable pkcs11 an dtest_pkcs11 in github actions

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230322221456.1660425-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26485.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


