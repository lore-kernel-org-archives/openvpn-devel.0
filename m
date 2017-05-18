Date: Thu, 18 May 2017 20:32:20 +0200 (CEST)
Message-Id: <201705181832.v4IIWK8R090053@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170413173129.87367-1-steven@...2262...>
References: <20170413173129.87367-1-steven@...2262...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix gateway detection with
	OpenBSD routing domains
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
To: Steven McDonald <steven@...2262...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  Sorry that it took so long, wanted to verify things and
then it got lost.  Since it's openbsd specific, I only did cursory 
checks ("the code looks sane and getrtable() is documented to do what
you say"), but did not set up a system with non-0 routing tables.

Your patch has been applied to the master and release/2.4 branch,
and adapted to release/2.3 ("IPv4 only").

commit 3dd30bfe5fdf9f34afe7f847b4e30156982d9ff0 (master)
commit 212e24ddc7b60fc2d2303ccf5893054e952232bb (release/2.4)
commit 50ba481c21a0e868491b02efe7a1d9c5664d8f58 (release/2.3)
Author: Steven McDonald
Date:   Fri Apr 14 03:31:29 2017 +1000

     Fix gateway detection with OpenBSD routing domains

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170413173129.87367-1-steven@...2262...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14461.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


