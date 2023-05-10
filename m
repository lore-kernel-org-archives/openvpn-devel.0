Date: Wed, 10 May 2023 10:13:29 +0200 (CEST)
Message-Id: <202305100813.34A8DTHL046895@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230509170517.2637245-1-selva.nair@...277...>
References: <20230509170517.2637245-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Bugfix: dangling pointer passed
 to pkcs11-helper
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

The patch itself looks trivial ("just move the structure to the outer
scope").

The interesting bit is "why" :-) - "set_pss_params()" is harmless (it
just fills the data in the structure), but then mech.pParameter is set
to &pss_params, and *this* is passed to pkcs11h_certificate_signAny_ex()
a few lines down, outside the original scope.

So - the patch makes sense, the bug is obvious in hindsight, and we
also have a confirmation in #323 that the patch fixes a real problem
"depending on compiler and OS", nasty.

For testing, I have only used the GH Action builds - there's two
instances that build with --enable-pkcs11 and run the tests (and I
have no suitable setup locally).

[==========] Running 3 test(s).
Slot 0 has a free/uninitialized token.
The token has been initialized and is reassigned to slot 379532672
[ RUN      ] test_pkcs11_ids
[       OK ] test_pkcs11_ids
[ RUN      ] test_tls_ctx_use_pkcs11
[       OK ] test_tls_ctx_use_pkcs11
[ RUN      ] test_tls_ctx_use_pkcs11__management
[       OK ] test_tls_ctx_use_pkcs11__management
Found token (541bef49-4423-01c1-e7c6-600c169f3580) with matching token label.
The token (softhsm2_tokens_Fi02IS/541bef49-4423-01c1-e7c6-600c169f3580) has been deleted.
[==========] 3 test(s) run.
[  PASSED  ] 3 test(s).
PASS: pkcs11_testdriver


Your patch has been applied to the master branch.

commit f4850745709c5b80ab7d09c03a86c5ceea6d10a2 (master)
commit 7e4becb4cd8be7f0d5ff80cf80877ea152f99830 (release/2.6)
Author: Selva Nair
Date:   Tue May 9 13:05:17 2023 -0400

     Bugfix: dangling pointer passed to pkcs11-helper

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230509170517.2637245-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26640.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


