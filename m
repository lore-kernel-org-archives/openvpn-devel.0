Date: Sat, 4 Apr 2026 17:05:33 +0200 (CEST)
Message-Id: <202604041505.634F5Xfi069172@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260331173403.3082-1-gert@...1296...>
References: <20260331173403.3082-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add unit test for printing
 various details of certificates
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

Extra unit tests are always welcome :-) - and as such, go to release/2.7
as well (especially since I think upcoming OSSL 4 compat patches will
benefit from having these unit tests).

Stared a bit at the code, tested the 2.7 version on Linux with OSSL 3,
passes...

[ RUN      ] crypto_test_print_cert_details
[       OK ] crypto_test_print_cert_details
[==========] ssl tests: 18 test(s) run.


Your patch has been applied to the master and release/2.7 branch.

commit 27d1b9a0da73c40db73cbe9000aef31d14dd5c92 (master)
commit 490364ce09f72fb68518d619b41807b7af445954 (release/2.7)
Author: Arne Schwabe
Date:   Tue Mar 31 19:33:57 2026 +0200

     Add unit test for printing various details of certificates

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1598
     Message-Id: <20260331173403.3082-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36389.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


