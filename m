Date: Thu, 21 Apr 2016 19:48:27 +0200 (CEST)
Message-Id: <201604211748.u3LHmRAq025797@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
References: <A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix buffer overflow by user
	supplied data
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
To: Jens Neuhalfen <jens@...2127...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.3 branch.

As discussed downthread, I've added <stdint.h> to fix the MAX_SIZE
compilation error on Linux and FreeBSD.

commit 7c0ecd1191e66fa242708f93baa4006ba0a73c7a (master)
commit b15d511aa6ca75c643a46b703b5536016a77d395 (release/2.3)

Author: Jens Neuhalfen
Date:   Tue Apr 19 20:42:55 2016 +0200

     Fix buffer overflow by user supplied data

     Signed-off-by: Jens Neuhalfen <jens@...2127...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11477
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


