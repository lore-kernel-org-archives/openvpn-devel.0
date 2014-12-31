Date: Wed, 31 Dec 2014 10:30:10 +0100 (CET)
Message-Id: <201412310930.sBV9UAH1007026@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1413315802-62359-5-git-send-email-alp@...1937...>
References: <1413315802-62359-5-git-send-email-alp@...1937...>
Subject: [Openvpn-devel] [PATCH applied] Re: Default gateway can't be
	determined on illumos/Solaris platforms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alexander Pyhalov <apyhalov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Tested on OpenSolaris 10 (5.11), works as advertised, has no
impact on other platforms.

Your patch has been applied to the master branch.

commit 01bfdf3a38059cf907bec60d6fd36a5eeef59032

Author: Alexander Pyhalov
Date:   Tue Oct 14 23:43:22 2014 +0400

     Default gateway can't be determined on illumos/Solaris platforms

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1413315802-62359-5-git-send-email-alp@...1937...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9129
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


