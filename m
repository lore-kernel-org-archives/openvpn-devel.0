Date: Mon, 16 Mar 2026 16:04:10 +0100 (CET)
Message-Id: <202603161504.62GF4A8n032781@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260314170948.2898-1-gert@...1296...>
References: <20260314170948.2898-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_mbedtls: Avoid conversion
 and sign-compare warnings
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

Makes sense.  The overflow check is much easier to understand this way, too.

BB confirms that we're not hitting these ASSERT()s either :-) - in addition
to that, tested on FreeBSD 14 to see if I messed up apply ordering, creating
new -Werror fails (no).

(JFTR, v5 is just a rebase of v4)

Your patch has been applied to the master branch.

commit a04a3cedd41a3b552e56d19dafc7042b95dd527d
Author: Frank Lichtenheld
Date:   Sat Mar 14 18:09:43 2026 +0100

     ssl_mbedtls: Avoid conversion and sign-compare warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1559
     Message-Id: <20260314170948.2898-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36137.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


