Date: Sun, 22 May 2022 13:09:41 +0200 (CEST)
Message-Id: <202205221109.24MB9f4M002666@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220519085428.6783-2-frank@...2641...>
References: <20220519085428.6783-2-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reformat for sp_after_comma=add
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

Yes, this is a good thing - "we do this", but uncrustify didn't check,
and so inconsistencies sneaked in.

I'll add this commit ID to .git-blame-ignore-revs in the next commit.

Verified with "git show -w" that this is indeed just trivial whitespace
changes, no line wraps, brackets, or anything.

Your patch has been applied to the master branch.

commit e51d9a73693ee742b36e19fb1718e5e27167831d
Author: Frank Lichtenheld
Date:   Thu May 19 10:54:27 2022 +0200

     Reformat for sp_after_comma=add

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220519085428.6783-2-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24399.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


