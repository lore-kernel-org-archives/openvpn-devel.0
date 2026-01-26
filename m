Date: Mon, 26 Jan 2026 16:32:09 +0100 (CET)
Message-Id: <202601261532.60QFW96S093139@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260126145432.31249-1-gert@...1296...>
References: <20260126145432.31249-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Remove ifdef for
 SO_{RCV, SND}BUF
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

Kudos to our good friends from SRLabs... if they start staring at the
code, they will actually find stuff :-) - the initial report was "there
is an '#else return false;' missing", but it turned to an opportunity to
get rid of #ifdefs.  All the better.

Checked some of the oldest and weirdest systems we sort-of support 
(FreeBSD 7.4, AIX, Windows) and they all have these defines... out!

Your patch has been applied to the master branch.

commit 57e701129e1178c6e53f593558535ebebe6b2cd5
Author: Frank Lichtenheld
Date:   Mon Jan 26 15:54:26 2026 +0100

     socket: Remove ifdef for SO_{RCV, SND}BUF

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1486
     Message-Id: <20260126145432.31249-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35435.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


