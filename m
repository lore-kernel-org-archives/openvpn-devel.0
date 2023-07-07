Date: Fri, 7 Jul 2023 08:16:27 +0200 (CEST)
Message-Id: <202307070616.3676GRws051265@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230706171922.752429-1-heiko@...2662...>
References: <20230706171922.752429-1-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: work around false positive
 warning with mingw 12
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

Test compiled on Linux and FreeBSD, just to get two more compiler's
opinions...

Your patch has been applied to the master and release/2.6 branch.

commit d559affd313a8f995db15908887fbc8f16a24659 (master)
commit cbf295ab42affcbdc09261cf3a39eb1d3d9f9cb2 (release/2.6)
Author: Heiko Hund
Date:   Thu Jul 6 19:19:22 2023 +0200

     work around false positive warning with mingw 12

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230706171922.752429-1-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26831.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


