Date: Sun, 25 Jan 2026 18:50:11 +0100 (CET)
Message-Id: <202601251750.60PHoBHR071759@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260122133050.117000-1-frank@...2641...>
References: <20260122133050.117000-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: Fix conversion warnings
 on BSDs
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

Ufff, ancient code that I avoid touching for fear things will fall off... but
I can confirm that it does not change anything on FreeBSD or OpenBSD
("openvpn --show-gateway" is excercising this code), and the change very
much looks correct :-) - plus ACK from Arne.

Your patch has been applied to the master branch.

commit 22a7010f5b80ec8c69e789d0ca7e31a8f34f2f78
Author: Frank Lichtenheld
Date:   Thu Jan 22 14:30:50 2026 +0100

     route: Fix conversion warnings on BSDs

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1481
     Message-Id: <20260122133050.117000-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35394.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


