Date: Thu, 20 Jan 2022 20:01:09 +0100 (CET)
Message-Id: <202201201901.20KJ19Lj015878@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220120161616.13447-1-selva.nair@...277...>
References: <20220120161616.13447-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a unit test for external
 key provider
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

Combining Arne's ACK for 16+17 into this one.  As far as I can see
(not checked line-by-line) this is indeed the same code, just squashed
into one commit, not touching configure.ac (thanks).

And indeed, it now tests something :-)

[==========] Running 3 test(s).
[ RUN      ] xkey_provider_test_fetch
[       OK ] xkey_provider_test_fetch
[ RUN      ] xkey_provider_test_mgmt_sign_cb
[       OK ] xkey_provider_test_mgmt_sign_cb
[ RUN      ] xkey_provider_test_generic_sign_cb
[       OK ] xkey_provider_test_generic_sign_cb
[==========] 3 test(s) run.
[  PASSED  ] 3 test(s).
PASS: provider_testdriver

and just an empty "PASS: provider_testdriver" when compiled without
XKEY.

Your patch has been applied to the master branch.

commit 4fe50675946f4533a9a373f4332e417f1bbfeabe
Author: Selva Nair
Date:   Thu Jan 20 11:16:16 2022 -0500

     Add a unit test for external key provider

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220120161616.13447-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23608.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


