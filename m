Date: Thu, 5 Mar 2026 10:18:54 +0100 (CET)
Message-Id: <202603050918.6259Iso9079775@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260302163557.18358-1-gert@...1296...>
References: <20260302163557.18358-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: management: stop bytecount on
 client disconnection
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This is a pretty direct backport of commit fccdb21733d2, which is easy
enough, and has been thoroughly tested in master (= I did not explicitly
test this again, beyond "buildbots are all green").  I assume that this
is a prerequisite patch for more DCO/bytecount fix backports to come :-)

Your patch has been applied to the release/2.6 branch.

commit ea8185ca76b5ba1b9247e1445f2805948ed09a34 (release/2.6)
Author: Ralf Lici
Date:   Mon Mar 2 17:35:51 2026 +0100

     management: stop bytecount on client disconnection

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1533
     Message-Id: <20260302163557.18358-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35825.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


