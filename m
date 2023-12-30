Date: Sat, 30 Dec 2023 16:47:28 +0100 (CET)
Message-Id: <202312301547.3BUFlSDm041914@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231230143248.1625-1-gert@...1296...>
References: <20231230143248.1625-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: misc: make get_auth_challenge
 static
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

For whatever reason, doxygen documentation hunks for get_user_pass_cr()
sneaked into this patch - I have skipped those, as it's not related to
this patch and should go into the user_pass related patches (UT etc)
(maybe just a git rebase artefact anyway).

With the early return / ASSERT() it's a bit harder to see that the
code is "really just moved, unchanged, to avoid a forward call" - and
"git diff -w" doesn't help here either.  Verified by staring at the diff.

Your patch has been applied to the master branch.

commit 30751632b5d919d6a01a625be48060ee23b4f968
Author: Frank Lichtenheld
Date:   Sat Dec 30 15:32:48 2023 +0100

     misc: make get_auth_challenge static

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231230143248.1625-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27864.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


