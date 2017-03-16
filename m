Date: Thu, 16 Mar 2017 09:39:29 +0100 (CET)
Message-Id: <201703160839.v2G8dTC1097756@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170316082117.21020-1-a@...2181...>
References: <20170316082117.21020-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: CRL: use time_t instead of
	struct timespec to store last mtime
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  Tested on FreeBSD, unsurprisingly no problems.

Your patch has been applied to the master and release/2.4 branch.

commit f3705dd1e711ee9f8546b841e4b18e9e9a224975 (master)
commit 633138564d611b5abeff232c89dccb1b86def449 (release/2.4)
Author: Antonio Quartulli
Date:   Thu Mar 16 16:21:17 2017 +0800

     CRL: use time_t instead of struct timespec to store last mtime

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170316082117.21020-1-a@...2181...>
     URL: http://www.mail-archive.com/search?l=mid&q=20170316082117.21020-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


