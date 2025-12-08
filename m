Date: Mon, 8 Dec 2025 22:38:31 +0100 (CET)
Message-Id: <202512082138.5B8LcVh1027807@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251208193950.16969-1-gert@...1296...>
References: <20251208193950.16969-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests: Allow to override
 openvpn binary used
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

And finally, the backport to t_client.sh which is needed to make the
buildbot conditionals "does this openvpn binary have BF-CBC support?  if
not, skip this test!" work properly.

Again, no code change - just test scripts this time.

Your patch has been applied to the release/2.6 branch.

commit 966cdeb33d182a9b9d5474c26a7bfa8ac20231d5
Author: Frank Lichtenheld
Date:   Mon Dec 8 20:39:42 2025 +0100

     tests: Allow to override openvpn binary used

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230511101253.369196-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26648.html
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1424
     Message-Id: <20251208193950.16969-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34907.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


