Date: Fri, 13 Mar 2026 23:36:10 +0100 (CET)
Message-Id: <202603132236.62DMaAW4074023@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260313175324.12121-1-gert@...1296...>
References: <20260313175324.12121-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Show version and double check
 we use the right TLS library in Github Actions
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

Very reasonable addition - "make sure we actually built & linked the
TLS library we're trying to test".  Tested via GHA.

Your patch has been applied to the master and release/2.7 branch.

commit a659605d8c14be58d9b556bc82ea8660b4fe4192 (master)
commit 1b2518e67c9a34f6176ddcae38aa25ae667bdb97 (release/2.7)
Author: Arne Schwabe
Date:   Fri Mar 13 18:53:16 2026 +0100

     Show version and double check we use the right TLS library in Github Actions

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1566
     Message-Id: <20260313175324.12121-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36115.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


