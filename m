Date: Sat, 2 Dec 2023 16:56:10 +0100 (CET)
Message-Id: <202312021556.3B2FuATx085035@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231128104359.62967-1-frank@...2641...>
References: <20231128104359.62967-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix check_session_buf_not_used
 using wrong index
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

Indeed, that function seems to be slightly cursed... and this is the
right fix.  For this bug.

Tested more thoroughly :-) (full server test runs + GHA).

Your patch has been applied to the master and release/2.6 branch.

commit 59551b93cdb55397d63b2fe58ad99612821c0faf (master)
commit 5def8d935335619b16452b56b332d06f4d621d75 (release/2.6)
Author: Arne Schwabe
Date:   Tue Nov 28 11:43:59 2023 +0100

     Fix check_session_buf_not_used using wrong index

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231128104359.62967-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27576.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


