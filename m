Date: Sun, 14 Aug 2022 10:47:15 +0200 (CEST)
Message-Id: <202208140847.27E8lFgV066507@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220813212040.113-1-lstipakov@...277...>
References: <20220813212040.113-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: error.c: remove unused crash()
 function
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Dead code indeed.  And if we want to crash, we can do this without help!

Test compiled on Linux.

Your patch has been applied to the master branch.

commit 1e1ec038168f22afa584aea79a0323a9fdf45095
Author: Lev Stipakov
Date:   Sun Aug 14 00:20:40 2022 +0300

     error.c: remove unused crash() function

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220813212040.113-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24924.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


