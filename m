Date: Sun, 14 Sep 2025 19:38:01 +0200 (CEST)
Message-Id: <202509141738.58EHc1qA097119@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250914135128.19621-1-gert@...1296...>
References: <20250914135128.19621-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: events: Make sure rwflags are
 treated as unsigned
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Straightforward enough... and still passes all t_client tests related to
proxy connections.  Good enough :-)

Your patch has been applied to the master branch.

commit e15bb6338308caa6d6123b411db4054d76e58c32
Author: Frank Lichtenheld
Date:   Sun Sep 14 15:51:20 2025 +0200

     events: Make sure rwflags are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     URL: https://gerrit.openvpn.net/c/openvpn/+/1107
     Message-Id: <20250914135128.19621-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32918.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


