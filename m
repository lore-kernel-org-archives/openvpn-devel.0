Date: Tue, 11 Aug 2020 10:45:43 +0200 (CEST)
Message-Id: <202008110845.07B8jhmE045741@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810143707.5834-14-arne@...1227...>
References: <20200810143707.5834-14-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove S_OP_NORMAL key state.
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

Server-side and client-side tested.

Not sure if I understand all possible implications of S_NORMAL_OP,
but indeed it is not *used* anywere, except in ">= S_ACTIVE".

The flow of "at which point in time we set must_negotiate = 0"
changes a bit - the old code would do it "when it expired AND
we're in >= S_ACTIVE", while the new code would do it "right
when setting S_ACTIVE" - which is the only place where S_ACTIVE
is set, so it would always catch said condition.  This should be 
totally fine.

Your patch has been applied to the master branch.

commit c13d20fae3961ba67de3c4c85c75ebd1ac802b26
Author: Arne Schwabe
Date:   Mon Aug 10 16:37:03 2020 +0200

     Remove S_OP_NORMAL key state.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810143707.5834-14-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20674.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


