Date: Mon, 11 May 2026 14:10:33 +0200 (CEST)
Message-Id: <202605111210.64BCAXRi032394@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260508153108.13488-1-gert@...1296...>
References: <20260508153108.13488-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix some msg() calls with wrong
 number of arguments in Windows-only code
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

Impressive find.  Bug :-) - have not tried to figure out how to get
these messages printed (it's in the error handlers, so quite likely
"never, for most users").  Still, obviously correct fix.

Test compiled on mingw/ubuntu.

Your patch has been applied to the master and release/2.7 branch (bug).

commit af44c0f8929bc9817a11ac149ae01f3589959325 (master)
commit 815a3bd87d61b57d640551386efce9638aa014a0 (release/2.7)
Author: Frank Lichtenheld
Date:   Fri May 8 17:31:02 2026 +0200

     Fix some msg() calls with wrong number of arguments in Windows-only code

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1672
     Message-Id: <20260508153108.13488-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36862.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


