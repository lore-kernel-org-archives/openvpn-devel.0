Date: Wed, 20 Dec 2023 18:07:15 +0100 (CET)
Message-Id: <202312201707.3BKH7FCj058263@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231220123659.55542-1-frank@...2641...>
References: <20231220123659.55542-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: cmake: create and link
 compile_commands.json file
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

Since this is build system (-only) and won't affected generated code,
I have not tested it.  I have an ACK, and the buildbots are happy with it.

Your patch has been applied to the master branch.

commit 855030f3d76324bdb614c05ec0ca5b86d66653bb
Author: Heiko Hund
Date:   Wed Dec 20 13:36:59 2023 +0100

     cmake: create and link compile_commands.json file

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231220123659.55542-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27840.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


