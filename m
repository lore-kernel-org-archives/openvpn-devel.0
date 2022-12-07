Date: Wed, 7 Dec 2022 19:43:32 +0100 (CET)
Message-Id: <202212071843.2B7IhWFw057835@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221207140259.1083577-1-arne@...1227...>
References: <20221207140259.1083577-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix unit test of test_pkt on
 little endian Linux
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

Fed this to Github actions, our buildbot army AND tested this on 
AIX and Linux. And FreeBSD.

Your patch has been applied to the master branch.

commit 0f904615bd2eac9d246055ff1ca4e4da95586f86 (master)
commit 9c923ef3b435f058a3f898691e3d0613a0357fe5 (release/2.6)
Author: Arne Schwabe
Date:   Wed Dec 7 15:02:59 2022 +0100

     Fix unit test of test_pkt on little endian Linux

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221207140259.1083577-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25633.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


