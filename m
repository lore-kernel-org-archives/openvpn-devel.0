Date: Sun, 19 Apr 2026 17:55:49 +0200 (CEST)
Message-Id: <202604191555.63JFtn0Q062852@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260419135116.22170-1-gert@...1296...>
References: <20260419135116.22170-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove various redundant
 conditionals
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

Verified each of the finding by staring at the code for long enough :-) - the
interactive.c one gave me a bit of headache, trying to understand why it
can never underrun (I'm fully in the "check with 'if (thing <= 0)' to be
guarded against miscalculations" camp).  Well, it cannot, because we have
a size_t here, so cppcheck is very obviously right - but the code itself
also ensures that we have a 0-byte at the end, and thus wcslen() can never
"escape" the boundaries of "size".

Out they go...  test compiled on mingw.  And BB all green, of course.

Your patch has been applied to the master branch.

commit 22062deb5dc04670b48511580d576df3c4682b2e
Author: Frank Lichtenheld
Date:   Sun Apr 19 15:51:11 2026 +0200

     Remove various redundant conditionals

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1613
     Message-Id: <20260419135116.22170-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36666.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


