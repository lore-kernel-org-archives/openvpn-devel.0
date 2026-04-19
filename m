Date: Sun, 19 Apr 2026 17:51:09 +0200 (CEST)
Message-Id: <202604191551.63JFp9HB062570@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260419133947.21215-1-gert@...1296...>
References: <20260419133947.21215-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tapctl: Remove unused function
 dont_mute
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

This was a bit nonintuitive at first ("but it does get used... oh, wait,
it's a stub that always returns 'true'").  Well, I guess when Simon
imported the msg_test() function from openvpn/error.h wanted to leave 
those bits unchanged, for easier future adjustments... (which never
happened).

Anyway, out it goes.  Spring cleaning time.  Compile tested with MinGW.

Your patch has been applied to the master branch.

commit 6d54d7ca5d32ebd830298b303a1146365fb35bbc
Author: Frank Lichtenheld
Date:   Sun Apr 19 15:39:41 2026 +0200

     tapctl: Remove unused function dont_mute

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1615
     Message-Id: <20260419133947.21215-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36662.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


