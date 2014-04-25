Date: Fri, 25 Apr 2014 20:37:37 +0200 (CEST)
Message-Id: <201404251837.s3PIba2p027719@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1390164697-1590-1-git-send-email-gert@...1296...>
References: <1390164697-1590-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Repair --multihome on FreeBSD
	for IPv4 sockets.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

As announced at the IRC meeting yesterday, I decided to apply lazy ACK 
rules here.  The code is tested, fixes an actual bug, and nobody NAKed
it for 4 months...

Patch has been applied to the master and release/2.3 branches.

commit 661d914c8732a208580b1eab167255c85da162c9 (master)
commit fc759c2eb4fbf0792d0052966fcf36efebc5bf5d (master)

Author: Gert Doering
Date:   Sun Jan 19 21:51:37 2014 +0100

     Repair --multihome on FreeBSD for IPv4 sockets.

     Signed-off-by: Gert Doering <gert@...1296...>
     Lazy-Ack-by: Gert Doering <gert@...1296...>
     Message-Id: <1390164697-1590-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8250


--
kind regards,

Gert Doering


