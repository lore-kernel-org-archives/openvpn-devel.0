Date: Fri, 26 Jun 2015 22:18:21 +0200 (CEST)
Message-Id: <201506262018.t5QKILJd010421@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
Subject: [Openvpn-devel] [PATCH applied] Re: Del ipv6 addr on close of linux
	tun interface
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
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master and release/2.3 branch.

I've added a bit of text to the commit message to point to trac#141
and --ifconfig-noexec.

commit e5f71d674e3b119d6a252d7cef1c17b5c2b36a9a (master)
commit 40e6c586124e6d7a764b859dad8515998c89c693 (master)

Author: Holger Kummert
Date:   Thu Jun 25 18:01:20 2015 +0200

     Del ipv6 addr on close of linux tun interface

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9810
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


