Date: Mon, 16 Feb 2026 17:27:36 +0100 (CET)
Message-Id: <202602161627.61GGRaI3070033@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260211150747.113906-1-frank@...2641...>
References: <20260211150747.113906-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change
 stream_buf_read_setup_dowork parameter to struct steam_buf
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is a fairly straightforward change, and it passes all build- and
system tests...  in itself it is not very useful, but it simplifies
an upcoming patch that is an actual bugfix (so this thing needs to
go into release/2.7 as well).

Your patch has been applied to the master and release/2.7 branch.

commit 6ac80e99092feb31223507a9f5b32c296125b86b (master)
commit 9c8d28c722aab2ade700f58bee750f09b899ec64 (release/2.7)
Author: Arne Schwabe
Date:   Wed Feb 11 16:07:47 2026 +0100

     Change stream_buf_read_setup_dowork parameter to struct steam_buf

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1483
     Message-Id: <20260211150747.113906-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35595.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


