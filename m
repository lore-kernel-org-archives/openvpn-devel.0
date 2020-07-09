Date: Thu, 9 Jul 2020 19:00:54 +0200 (CEST)
Message-Id: <202007091700.069H0s5j021702@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200709101603.11941-3-arne@...1227...>
References: <20200709101603.11941-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 process_incoming_push_reply from process_incoming_push_msg
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

Your patch has been applied to the master branch.

After some discussion on IRC regarding the "const" bit it was decided
to not *add* it to the function call, but to *remove* it from the
function definition of process_incoming_push_msg()  (which would
otherwise be done in the 5/8 patch of this series).  

With that changed the code compiles without warnings.  

Stared a bit at "git show -w --color-moved=zebra" and the change seems 
to make sense :-)

Tested with local t_client tests on Linux and FreeBSD - haven't done 
a full server test, because "it's client side code".

commit 5e78bf66fa97818e0587ab1504cf7ecfd73df944
Author: Arne Schwabe
Date:   Thu Jul 9 12:15:58 2020 +0200

     Extract process_incoming_push_reply from process_incoming_push_msg

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200709101603.11941-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20254.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


