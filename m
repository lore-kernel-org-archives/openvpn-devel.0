Date: Sun, 14 Feb 2021 16:19:36 +0100 (CET)
Message-Id: <202102141519.11EFJaIF011452@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210125125628.30364-3-arne@...1227...>
References: <20210125125628.30364-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement client side handling
 of AUTH_PENDING message
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

I'm not sure I understand the code, though.  It receives the new timeout
from the server (that is easy), but then caps it by "hand_window", which
is never increased - so the maximum timeout stays at "60", unless increased
manually on the client.  Where am I misreading this?  Or is this a 
prerequisite for this functionality?

    c->c2.push_request_timeout = ks->established + min_uint(max_timeout, server_timeout);

(or am I totally misunderstanding push_request_timeout, and this has
nothing to do with hand-window, except "it's using this as a default
value", but only for triggering re-sends, not for "final give up"?)

However, for my standard test cases, this does not break anything, and
the code looks reasonable.  So in it goes :)

commit 3f8fb2b2c1d664f421d36181846da89c4330c6cc
Author: Arne Schwabe
Date:   Mon Jan 25 13:56:19 2021 +0100

     Implement client side handling of AUTH_PENDING message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210125125628.30364-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21491.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


