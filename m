Date: Thu, 5 Mar 2026 09:00:42 +0100 (CET)
Message-Id: <202603050800.62580glZ078194@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260304164928.15819-1-gert@...1296...>
References: <20260304164928.15819-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win32-util: Handle return value
 from WideCharToMultiByte better
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

Makes sense, appeases the compiler, increases readability *and* has
an ACK from Arne (plus green BB) ;-)

Your patch has been applied to the master branch.

commit 71c6729c403a17492a68ce70b0f6fd17c07e3de0
Author: Frank Lichtenheld
Date:   Wed Mar 4 17:49:22 2026 +0100

     win32-util: Handle return value from WideCharToMultiByte better

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1495
     Message-Id: <20260304164928.15819-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35906.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


