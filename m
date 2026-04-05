Date: Sun, 5 Apr 2026 12:23:15 +0200 (CEST)
Message-Id: <202604051023.635ANFpf089319@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260404203615.30863-1-gert@...1296...>
References: <20260404203615.30863-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove various unused structs
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

Easy to test for - "compile this on all relevant platforms and see if
something *does* needs the structures".  BB nicely did that for me :-) -
so I just stared a bit at the diff and wondered.

I see no real convincing need for this to go to release/2.7, so applied
to master only.  If we want release/2.7 to be cppcheck clean, we could
debate backporting these (but we didn't want to go there with the 
integer related cleanups either).

Your patch has been applied to the master branch.

commit b6cea99f4a36d170b2c11c89ba95b4dce255b3ee
Author: Frank Lichtenheld
Date:   Sat Apr 4 22:36:09 2026 +0200

     Remove various unused structs

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1607
     Message-Id: <20260404203615.30863-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36468.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


