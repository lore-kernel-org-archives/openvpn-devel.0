Date: Mon, 10 Aug 2020 17:11:58 +0200 (CEST)
Message-Id: <202008101511.07AFBwvc014375@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810143707.5834-5-arne@...1227...>
References: <20200810143707.5834-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Minor cleanup in push.c
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

"Trivially correct" (still tested, client side is enough to
excercise that code).

Unfortunately, the Whitespace Overlord required re-indentation
of the two lines of context, so I did that.

Your patch has been applied to the master branch.

commit 2fdd332979a69d6064706ba3bb875385333b6720
Author: Arne Schwabe
Date:   Mon Aug 10 16:36:54 2020 +0200

     Minor cleanup in push.c

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810143707.5834-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20678.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


