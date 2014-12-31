Date: Wed, 31 Dec 2014 10:30:04 +0100 (CET)
Message-Id: <201412310930.sBV9U4IF002491@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1413315802-62359-4-git-send-email-alp@...1937...>
References: <1413315802-62359-4-git-send-email-alp@...1937...>
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

Just as a remark: the patch in master is more feature-complete as it 
benefits from the code cleanup/unification of all the BSDs and MacOS X 
in cab6305be749930eae - the 2.3 one can only show the gateway:

 Wed Dec 31 10:22:22 2014 ROUTE_GATEWAY 194.97.140.30

while the one in "master" can show netmask and interface as well:

 Wed Dec 31 10:24:12 2014 ROUTE_GATEWAY 194.97.140.30/255.255.255.224 IFACE=pcn0

.. but I'll leave it at that, to avoid more intrusive changes to 2.3.


Your patch has been applied to the release/2.3 branch.

commit b6dc199077079310d9f26fa8b366f4e71d32f6c9
Author: Alexander Pyhalov
Date:   Tue Oct 14 23:43:21 2014 +0400

     Default gateway can't be determined on illumos/Solaris platforms

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1413315802-62359-4-git-send-email-alp@...1937...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9128
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


