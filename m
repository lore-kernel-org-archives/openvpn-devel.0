Date: Wed, 26 Nov 2025 12:11:06 +0100 (CET)
Message-Id: <202511261111.5AQBB6Ui025984@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251126104706.5378-1-gert@...1296...>
References: <20251126104706.5378-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: handle ignoring itf
 domains correctly
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

This looks reasonable (and was one of the things I wondered about in
reviewing the first 5 single-line patches near to it - "this cannot work
at all?").  BB says it compiles.  We have no unit or other systematic tests
for this, which - quite obviously - needs to be fixed...

Your patch has been applied to the master branch.

commit c0cb510257ac48d69c39388024beb1e75bee1893
Author: Heiko Hund
Date:   Wed Nov 26 11:47:01 2025 +0100

     iservice: handle ignoring itf domains correctly

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1394
     Message-Id: <20251126104706.5378-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34677.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


