Date: Fri, 27 Mar 2026 18:49:47 +0100 (CET)
Message-Id: <202603271749.62RHnl38067263@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260325124338.123477-1-frank@...2641...>
References: <20260325124338.123477-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change type of option flag from
 unsigned int to uint64_t
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

I do not like this approach very much - to the contrary, I think that
trying to differentiate "more than 32 different classes of option
types, of which most fall into the 'always pushable', 'never pushable',
'pushable unless --route-nopull is set' categories" is not making our
code easier to understand...

That said, my statement was stated, listened to, and ignored - which in
this case is okay (this is just mild grumbling, no hard opposition).

The technical change is okay, BB likes it, Frank likes it, so in it goes.

Your patch has been applied to the master branch.

commit 91fd9614f980b02772e4dfbb09144c822ec97df0
Author: Arne Schwabe
Date:   Wed Mar 25 13:43:38 2026 +0100

     Change type of option flag from unsigned int to uint64_t

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1583
     Message-Id: <20260325124338.123477-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36266.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


