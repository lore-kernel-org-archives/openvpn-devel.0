Date: Sat, 20 Sep 2025 23:33:42 +0200 (CEST)
Message-Id: <202509202133.58KLXglC087618@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250919173838.28092-1-gert@...1296...>
References: <20250919173838.28092-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: list: Make types of hash
 elements consistent
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

Stared at the code (looks reasonable).  Played a bit with --hash-size
and watched "MULTI: REAP" messages on verb 7.  t_server test runs also
find everything working.

Your patch has been applied to the master branch.

commit a69aac41c4b2ccff1084736c158d7cf8474be533
Author: Frank Lichtenheld
Date:   Fri Sep 19 19:38:32 2025 +0200

     list: Make types of hash elements consistent

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1119
     Message-Id: <20250919173838.28092-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33108.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


