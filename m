Date: Fri, 22 Sep 2023 14:06:02 +0200 (CEST)
Message-Id: <202309221206.38MC62en031304@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230922105055.37969-1-frank@...2641...>
References: <20230922105055.37969-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Warn user if INFO control
 command is too long
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

Have not tested it beyond "test compile", but change looks reasonable.

Your patch has been applied to the master and release/2.6 branch
("make things more robust").

commit df624fb6d63db6b2a3b0c40597cee74c61b8ab2c (master)
commit 785b50127ecf0c440c016f85cef0c59f56894fc4 (release/2.6)
Author: Lev Stipakov
Date:   Fri Sep 22 12:50:55 2023 +0200

     Warn user if INFO control command is too long

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230922105055.37969-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27062.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


