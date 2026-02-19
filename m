Date: Thu, 19 Feb 2026 10:11:08 +0100 (CET)
Message-Id: <202602190911.61J9B80r029712@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260218214738.27158-1-gert@...1296...>
References: <20260218214738.27158-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: fix discards 'const'
 qualifier from pointer target type
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
To: Rudi Heitbaum <rudi@...2993...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for your contribution.

Your patch has been applied to the master and release/2.7 branch.

The way this was handled might look a bit confusing - normally "patch
on the list, ACK on the list, take it from there and merge it" is perfectly
fine, but in this case it went through our Gerrit to verify that the
change would not cause -Werror fails on other platforms.  So we basically
have 3 copies of the patch now, "list", "gerrit master" and "gerrit 2.7",
and they are all the same.

I'm taking the "gerrit master" one, and cherrypick to 2.7, because that's
less work for me (and it's the normal workflow "patches to master, cherrypick
from there to all affected branches").

commit 0157e7fb8ae29b637537a6b98ce85217c6daf5a3 (master)
commit 188d3d68855e2f0d0bd2afc21b66cbe3d98bc41f (release/2.7)
Author: Rudi Heitbaum
Date:   Wed Feb 18 22:47:33 2026 +0100

     dns: fix discards 'const' qualifier from pointer target type

     Signed-off-by: Rudi Heitbaum <rudi@...2993...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1542
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20260218214738.27158-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35730.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


