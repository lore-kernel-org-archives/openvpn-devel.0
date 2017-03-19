Date: Sun, 19 Mar 2017 19:30:33 +0100 (CET)
Message-Id: <201703191830.v2JIUXNm035467@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170130152658.15786-1-a@...2181...>
References: <20170130152658.15786-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: ignore remote-random-hostname
	if a numeric host is provided
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

ACK.  "Makes sense and the code does what it says on the lid" (tested!)

Your patch has been applied to the master and release/2.4 branch.

commit 3c748aeb5e4b82c449e7de28846a3915ab45aeec (master)
commit 0dc790818876dac6e1cf1a82eda8ea15a538a333 (master)

Author: Antonio Quartulli
Date:   Mon Jan 30 23:26:58 2017 +0800

     ignore remote-random-hostname if a numeric host is provided

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170130152658.15786-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13993.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


