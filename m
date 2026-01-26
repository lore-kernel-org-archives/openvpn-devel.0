Date: Mon, 26 Jan 2026 17:33:53 +0100 (CET)
Message-Id: <202601261633.60QGXrEA094494@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260122154751.155227-1-frank@...2641...>
References: <20260122154751.155227-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: status: Avoid conversion
 warnings in status_read/status_printf
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

I was a bit sceptical on the call to write(), but this is a windows
annoyance again - all reasonable platforms have a size_t here, and
windows uses an (unsigned int), triggering a senseless warning on
mingw.  Meh.  The other changes are straightforward "use the correct
types and cast where unavoidable"

Your patch has been applied to the master branch.

commit e1e3b9aed13d42fd5e298bec5b079598fdf3a04e
Author: Frank Lichtenheld
Date:   Thu Jan 22 16:47:51 2026 +0100

     status: Avoid conversion warnings in status_read/status_printf

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1485
     Message-Id: <20260122154751.155227-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35398.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


