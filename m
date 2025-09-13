Date: Sat, 13 Sep 2025 19:14:13 +0200 (CEST)
Message-Id: <202509131714.58DHEDmd047627@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250912132235.44304-1-frank@...2641...>
References: <20250912132235.44304-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Preserve --dhcp-option values
 from local config
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

So, I tried to reproduce this on Linux, opened a new GH issue (840), and
after discussion with Lev came to the conclusion that this is the same
problem after all - #839 talks on "upon interface reconnection", but both
for Lev's tests on Windows and for my tests on Linux with --dns-updown,
it did not work on the initial connect either (o->dhcp_options.servers is
NULL, so "nothing is attempted").

With the patch it works.

Added a test to my extended t_client set to ensure we will not break this
again...

As requested, I have reworded the commit message slightly.  Some unrelated
words escaped :-)

Your patch has been applied to the master branch.

commit 3cc7a9eb2666722889d1c9ce739bb0bdaa23b308
Author: Lev Stipakov
Date:   Fri Sep 12 15:22:35 2025 +0200

     Preserve --dhcp-option values from local config

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250912132235.44304-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32879.html
     URL: https://gerrit.openvpn.net/c/openvpn/+/1181
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


