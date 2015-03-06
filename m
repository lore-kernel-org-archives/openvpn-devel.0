Date: Fri, 6 Mar 2015 19:57:43 +0100 (CET)
Message-Id: <201503061857.t26Ivhuj004791@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <54F8CC9B.9040104@...1856...>
References: <54F8CC9B.9040104@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix CN maximum length
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK. Your patch has been applied to the master and release/2.3 branches.

commit ecd934b1ef83eec58eb2df5d3a98309ca56d5812 (master)
commit d7d61b4c2d1f1dd47e779ca38b936f9b99042c82 (release/2.3)

Author: Steffan Karger
Date:   Thu Mar 5 22:37:31 2015 +0100

     Allow for CN/username of 64 characters (fixes off-by-one)

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <54F8CC9B.9040104@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9508
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


