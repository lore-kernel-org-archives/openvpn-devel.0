Date: Tue, 7 Feb 2023 17:54:18 +0100 (CET)
Message-Id: <202302071654.317GsIws058954@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230207134333.52221-1-frank@...2641...>
References: <20230207134333.52221-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: fix wrong printf
 format in x_check_status
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

Test built on MinGW and Linux.  Haven't actually tried to trigger an error
message which would contain a fd=nnn output, but for "non windows" this
is a no-op change, and "for windows" it looks correct.

Your patch has been applied to the master and release/2.6 branch.

commit a95705be85cb1d3a5868efaeb960ec5d625d2f11 (master)
commit 37e23c9816754ceeb67d5365b639f0b37f804591 (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Feb 7 14:43:33 2023 +0100

     Windows: fix wrong printf format in x_check_status

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230207134333.52221-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26166.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


