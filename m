Date: Fri, 13 Feb 2026 23:06:26 +0100 (CET)
Message-Id: <202602132206.61DM6Qhd005061@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260211113315.25776-1-gert@...1296...>
References: <20260211113315.25776-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: port-share: log incoming
 connections at verb 3 only
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Here we go, the first "mini bugfix" to the 2.7 series :-) - this is
just a trivial log level change, but as the issue says, "error level"
for something informational is just... wrong.

Your patch has been applied to the master and release/2.7 branch.

(It also serves as a test to the build infra, with a new branch to
take care of)

commit 6f9ab9647cf0a3bc53e42e609437f892ce009e7a (master)
commit 27505a5f2c4d34ceca44416090dda558ff99ad34 (release/2.7)
Author: Gert Doering
Date:   Wed Feb 11 12:33:10 2026 +0100

     port-share: log incoming connections at verb 3 only

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1516
     Message-Id: <20260211113315.25776-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35589.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


