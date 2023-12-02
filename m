Date: Sat, 2 Dec 2023 20:50:20 +0100 (CET)
Message-Id: <202312021950.3B2JoK0I092581@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231128103704.61046-1-frank@...2641...>
References: <20231128103704.61046-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename state_change to
 continue_tls_process
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

This is really straightforward rename + added comments.  Gave it a
full test nonetheless :-)

One could argue that the debug print with "tls_process: chg=%d" could
use an adjustment as well ("cont=%d"?).

Your patch has been applied to the master branch.

commit 8ba03f91388970754f3536866f9687759b07a63c (master)
Author: Arne Schwabe
Date:   Tue Nov 28 11:37:04 2023 +0100

     Rename state_change to continue_tls_process

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20231128103704.61046-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27571.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


