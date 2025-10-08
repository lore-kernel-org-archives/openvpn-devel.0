Date: Wed, 8 Oct 2025 12:18:31 +0200 (CEST)
Message-Id: <202510081018.598AIVqU080468@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008101014.5691-1-gert@...1296...>
References: <20251008101014.5691-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_options_parse: Start new
 UT for options_parse.c
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

"Because it makes sense" - tested on Linux/Cmocka, works.

GHA might need adjustments to test this on mingw->windows (opened an issue
for that).  I'm still not sure we need the __wrap_* dance here, but that
can be clarified (+changed if needed) later.

Your patch has been applied to the master branch.

commit 80981cf33880d9bf995da0dbd09becedce421d5e
Author: Frank Lichtenheld
Date:   Wed Oct 8 12:10:09 2025 +0200

     test_options_parse: Start new UT for options_parse.c

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1244
     Message-Id: <20251008101014.5691-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243816/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


