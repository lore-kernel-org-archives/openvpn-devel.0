Date: Sun, 13 Feb 2022 13:03:51 +0100 (CET)
Message-Id: <202202131203.21DC3pHg060998@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210162632.3309974-7-arne@...1227...>
References: <20220210162632.3309974-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove frame->link_mtu
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

And another one in the "reap the benefits" series :-)

Stared at the code, ran client and server tests.  All good.

(For reference: this was 20/21 in v1+v2, 13/14 in v3, received no
comments in either series)

Your patch has been applied to the master branch.

commit 986559bfa3c0a21c2ce4a486125aa03040fde849
Author: Arne Schwabe
Date:   Thu Feb 10 17:26:31 2022 +0100

     Remove frame->link_mtu

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210162632.3309974-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23749.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


