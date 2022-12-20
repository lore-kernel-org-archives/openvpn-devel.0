Date: Tue, 20 Dec 2022 16:30:06 +0100 (CET)
Message-Id: <202212201530.2BKFU6lr080431@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221220140458.2666637-1-arne@...1227...>
References: <20221220140458.2666637-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make management password check
 constant time
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

Acked-by: Gert Doering <gert@...1296...>

Works.  Password entered must be the right one now, not shorter or longer :-)

Your patch has been applied to the master and release/2.6 branch.

I think it would also be appropriate for 2.5, but there is no min_uint()
(came as part of commit 3f8fb2b2c), so the patch "as is" breaks
compilation on older branches.

commit e567f34262b0670fd51cbbcb6c6866b046454cee (master)
commit 6a82929076ed97f6c37161de266d3dcbe14d55c8 (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 20 15:04:58 2022 +0100

     Make management password check constant time

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221220140458.2666637-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25784.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


