Date: Tue, 28 Oct 2025 13:18:07 +0100 (CET)
Message-Id: <202510281218.59SCI7ct000834@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251028115953.22487-1-gert@...1296...>
References: <20251028115953.22487-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add ASSERT to afunix code that
 dev_node is always set up the way we expect
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

Looks reasonable, BB is happy, and the unit tests excercising tun_afunix
(t_server_null) still pass.  Also, I have a t_client test excercising
this, which still works :-)

I have updated the commit message a bit (language, Reported-By:), and
for one decided to try doing this in gerrit - it works, but is not the
best way to do it (it then does a "v2" of the patch, which hides the
test result of the actual patch, and creates extra noise on the list).

Your patch has been applied to the master branch.

commit 5bc0eae87ccf1abd6c400cb27d8e51819feb2036
Author: Arne Schwabe
Date:   Tue Oct 28 12:59:47 2025 +0100

     Add ASSERT to afunix code that dev_node is always set up the way we expect

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1320
     Message-Id: <20251028115953.22487-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33934.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


