Date: Sun, 13 Apr 2014 21:23:01 +0200 (CEST)
Message-Id: <201404131923.s3DJN12r000327@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20140413130102.GR16637@...1296...>
References: <20140413130102.GR16637@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix SOCKSv5 method selection
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
To: Yawning Angel <yawning@...1897...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.3 branches (with some
small amendments to fix MSVC compilation and "const" rules as pointed
out by Arne Schwabe).

commit 2903eba5dfe35c981329a833845e24de3882161a (master)
commit 34df13fdb65242b81c9006ee8ac83be4cc3f9e09 (release/2.3)

Author: Yawning Angel
Date:   Mon Mar 10 03:47:58 2014 +0000

     Fix SOCKSv5 method selection

     URL: https://github.com/OpenVPN/openvpn/pull/14
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20140413130102.GR16637@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8488
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


