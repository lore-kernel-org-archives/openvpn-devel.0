Date: Mon, 19 Jan 2026 12:40:05 +0100 (CET)
Message-Id: <202601191140.60JBe5K8041805@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260116135729.40545-1-frank@...2641...>
References: <20260116135729.40545-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: cryptoapi: Avoid conversion
 warnings
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

Patch looks reasonable, has an ACK from Selva, and gets rid of a pair
of conversion #pragmas.  And BB is happy.  Ship it!

Your patch has been applied to the master branch.

commit 2ece9a5df5ed14ca4beb026eef0687f448322245
Author: Frank Lichtenheld
Date:   Fri Jan 16 14:57:29 2026 +0100

     cryptoapi: Avoid conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1464
     Message-Id: <20260116135729.40545-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35304.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


