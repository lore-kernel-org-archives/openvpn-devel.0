Date: Sat, 8 Mar 2025 13:18:30 +0100 (CET)
Message-Id: <202503081218.528CIU7h083462@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250308100456.32383-1-gert@...1296...>
References: <20250308100456.32383-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove various unused function
 parameters
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

Stared-at-code, considered whether to keep some of the "this looks like
something was planned for future enhancements" things, decided against
it (like the multicast stuff) - we can bring the args back if someone
really wants to work on that.

Test compiled on MinGW, for good measure ;-) - but all of BB says
"all green", so not expecting any overlooked surprises.

Your patch has been applied to the master branch.

commit cedddc1d7419de4cf8c403efeb03fd9277fee40d
Author: Frank Lichtenheld
Date:   Sat Mar 8 11:04:55 2025 +0100

     Remove various unused function parameters

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250308100456.32383-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31064.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


