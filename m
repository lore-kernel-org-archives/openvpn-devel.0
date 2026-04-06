Date: Mon, 6 Apr 2026 12:30:17 +0200 (CEST)
Message-Id: <202604061030.636AUHIe019762@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260406072617.27790-1-gert@...1296...>
References: <20260406072617.27790-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: push: Make prepare_push_reply
 return void
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

Interesting find.  I guess someone in some distant past assumed that
we might see failure modes for prepare_push_reply()...

stare-at-code says "this must be fine", but as it affects server code,
I subjected it to the t_server testbed which does excercise PUSH quite
a bit :-) - and everything still works.

Your patch has been applied to the master branch.

commit 5d7068fa181edd472cb55889bd8fdfe246ecede4
Author: Frank Lichtenheld
Date:   Mon Apr 6 09:26:11 2026 +0200

     push: Make prepare_push_reply return void

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1616
     Message-Id: <20260406072617.27790-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36514.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


