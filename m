Date: Sun, 8 Mar 2020 20:42:54 +0100 (CET)
Message-Id: <202003081942.028Jgsks064914@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200205175944.432-1-simon@...2293...>
References: <20200205175944.432-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: uncrustify
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Thanks.  Verified with "git show -w" that it's indeed only whitespace
changes (without -w, the changes appear big, with -w, you see that it's
really just a few new line wraps, and /* after ifdef */ stuff)

The "#endif /* 1 */" bit makes me question myself, though, whether this
code could need a bit more cleanup... why have an #if 1 in the first
place?  Looks like a leftover from the first WINTUN patches... :-)

commit 9497b802cf4c41c3da3ac9a41f29d86788143818
Author: Simon Rozman
Date:   Wed Feb 5 18:59:44 2020 +0100

     tun.c: uncrustify

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200205175944.432-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19366.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


