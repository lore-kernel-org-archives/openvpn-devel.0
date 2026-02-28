Date: Sat, 28 Feb 2026 11:00:20 +0100 (CET)
Message-Id: <202602281000.61SA0KpE065768@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260217135605.154129-1-frank@...2641...>
References: <20260217135605.154129-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: drop useless init_gc
 param for init_options()
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Well spotted... on the first glance, this was like "uh, would that be
safe?  what if anything else relies on gc_owned?", but on more thorough
reading it's really as you say - all callers pass "true", and this field
is not used anywhere ever again ("confirmed by grep and buildbot" ;-) ).

Your patch has been applied to the master and release/2.7 branch
(prerequisite for a subsequent bugfix).

commit 92937c267b20e3e1ffd4e0e80d8048a57da7edb6 (master)
commit acbe874c71444afffa2238a0b8b45d330b78f86c (release/2.7)
Author: Antonio Quartulli
Date:   Tue Feb 17 14:56:05 2026 +0100

     options: drop useless init_gc param for init_options()

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1536
     Message-Id: <20260217135605.154129-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35695.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


