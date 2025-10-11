Date: Sat, 11 Oct 2025 12:31:53 +0200 (CEST)
Message-Id: <202510111031.59BAVrFV056361@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251010211154.2780-1-gert@...1296...>
References: <20251010211154.2780-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_user_pass: Check fatal
 errors for empty username/password
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

This needed a few rounds on my end - the patch adds a new file that
consists of "CR+NL" line endings, and "git am --whitespace=fix" 
helpfully fixed that... pushing to GHA still worked(!), seems the
test magic running this on a windows machine restored the line endings
- my own tests on FreeBSD and Linux failed.  Applied with "=ignore",
and magic!

 ============================================================================
 Testsuite summary for OpenVPN 2.7_beta2 Unit-Tests
 ============================================================================
 # TOTAL: 15
 # PASS:  15

(it's not possible to run this test driver "just so" from the command
line, though :( ).

Github action also still succeeds, BB all green, and the changes look
good and tests for the user/password parsing are most welcome - we've
had our share of bugs in this, so, more tests, less surprises.

Your patch has been applied to the master branch.

commit e7fdde7cb8d39a51a4a38b0d16f23a18d086cfe2
Author: Frank Lichtenheld
Date:   Fri Oct 10 23:11:47 2025 +0200

     test_user_pass: Check fatal errors for empty username/password

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/474
     Message-Id: <20251010211154.2780-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59245149/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


