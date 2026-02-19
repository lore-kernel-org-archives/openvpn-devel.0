Date: Thu, 19 Feb 2026 10:59:58 +0100 (CET)
Message-Id: <202602190959.61J9xw0w030578@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260218214712.27119-1-gert@...1296...>
References: <20260218214712.27119-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: auth-pam: fix discards 'const'
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Same thing as Rudi's dns.c/ntlm.c const fixes, just another file that did
not come up yet - but our own arch buildbots got updated, and flagged it...

*This* one goes to all 3 branches as well.

Your patch has been applied to the master, release/2.7 and release/2.6 branch.

commit eeaedd13628e27225c8893c2d8bdf5381fc33ba9 (master)
commit 2fd42e6d1da93655d97aeb32f549d684728d3fbd (release/2.7)
commit 7ec8cbe636fa938587e573de7e74e934b39f090e (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Feb 18 22:47:06 2026 +0100

     auth-pam: fix discards 'const' qualifier from pointer target type

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1543
     Message-Id: <20260218214712.27119-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35728.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


