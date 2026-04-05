Date: Sun, 5 Apr 2026 12:28:05 +0200 (CEST)
Message-Id: <202604051028.635AS5pm089569@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260404203335.30650-1-gert@...1296...>
References: <20260404203335.30650-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mtcp: Remove noop statement in
 multi_tcp_process_outgoing_link_ready
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

Another good catch :-) - and indeed, stare-at-code confirms your and
cppcheck's analysis.  Dead code.  From the dark times.  As for the last
patch, "master only" unless we want release/2.7 to be cppcheck-clean.

Your patch has been applied to the master branch.

commit d44ed886c279de51a936cc0652c9b72c943a6558
Author: Frank Lichtenheld
Date:   Sat Apr 4 22:33:30 2026 +0200

     mtcp: Remove noop statement in multi_tcp_process_outgoing_link_ready

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1609
     Message-Id: <20260404203335.30650-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36478.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


