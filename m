Date: Fri, 13 Mar 2026 18:41:09 +0100 (CET)
Message-Id: <202603131741.62DHf93S070243@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260313153034.31872-1-gert@...1296...>
References: <20260313153034.31872-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: AWS-LC: Add missing return and
 cast in ssl_tls1_PRF
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

Obvious bugfix...

Your patch has been applied to the master and release/2.7 branch.

Release/2.6 does not have AWS-LC support yet.

commit 3541226a8b7767d87dfbec8724d7789966622004 (master)
commit 068598717a83a9576b82dbd65308d407ba5c7a0d (release/2.7)
Author: Arne Schwabe
Date:   Fri Mar 13 16:30:27 2026 +0100

     AWS-LC: Add missing return and cast in ssl_tls1_PRF

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1567
     Message-Id: <20260313153034.31872-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36107.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


