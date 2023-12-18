Date: Mon, 18 Dec 2023 19:10:43 +0100 (CET)
Message-Id: <202312181810.3BIIAhCa070598@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231214111635.237429-1-frank@...2641...>
References: <20231214111635.237429-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests: disable automake
 serial_tests
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Simplification of the autoconf logic is definitely welcome...  tested
on FreeBSD 13.2 with autoconf 2.71 / automake 1.16, and it seems to
nicely run all the tests, with a nice and short summary

PASS: argv_testdriver
PASS: buffer_testdriver
PASS: crypto_testdriver
PASS: packet_id_testdriver
PASS: auth_token_testdriver
PASS: ncp_testdriver
PASS: misc_testdriver
PASS: pkt_testdriver
PASS: tls_crypt_testdriver
PASS: provider_testdriver
============================================================================
Testsuite summary for OpenVPN 2.7_git Unit-Tests
============================================================================
# TOTAL: 10
# PASS:  10

(for the auth_pam_testdriver, the output now explodes from "one test
run" to "and now a 10-line summary", but well...)


I look forward to the promised improvements for the test driver, though
- after

make  check-TESTS
SKIP: t_client.sh
PASS: t_lpback.sh

.. the thing just sits there for 2 minutes, with no indication what is
happening and why it's not finished yet (did it crash?) and then it
finally reaches

PASS: t_cltsrv.sh
============================================================================
Testsuite summary for OpenVPN 2.7_git System Tests
============================================================================
# TOTAL: 3
# PASS:  2
# SKIP:  1

.. and "make check V=99" does not improve things here, so this definitely
needs work.  Much worse if t_client.sh tests actually run, because then it
just stops at "make check-TESTS" for a looong time...


Your patch has been applied to the master branch.

commit 55d73959cc98241d0ef10dbd091ecf0061b175fe
Author: Frank Lichtenheld
Date:   Thu Dec 14 12:16:35 2023 +0100

     tests: disable automake serial_tests

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231214111635.237429-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27812.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


