Date: Sun, 5 Apr 2026 16:32:45 +0200 (CEST)
Message-Id: <202604051432.635EWjq6093470@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260405102209.31528-1-gert@...1296...>
References: <20260405102209.31528-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: Fix nrpt_dnssec flag
 handling
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

Good catch, and obvious bug... and use of enum for a "bit map style"
flags thing was not really a good approach in the first place.  Now it
will work ("any value *but* 0 will work"), but when this is extended
to cover "more than 1 flag", going away from the enum would be a good
plan.  For the bug fix, a minimal approach is suitable.

I have not tested this beyond "does it compile on Ubuntu/MinGW", but
it looks very obviously correct ("stare at 'git grep nrpt_dnssec'").

Your patch has been applied to the master and release/2.7 branch.

commit 08a19843a184c6cb8850ac9e6bf7ce0cd4d15d37 (master)
commit 2aaa5e4d7c5bae35d7befdebeed065c634292151 (release/2.7)
Author: Frank Lichtenheld
Date:   Sun Apr 5 12:22:04 2026 +0200

     win: Fix nrpt_dnssec flag handling

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1606
     Message-Id: <20260405102209.31528-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36487.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


