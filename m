From: Gert Doering <gert@...1296...>
Date: Sat, 17 Sep 2016 11:53:40 +0200
Message-Id: <20160917095340.53580-1-gert@...1296...>
In-Reply-To: <1474104026-20615-1-git-send-email-davids@...515...>
References: <1474104026-20615-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] t_client.sh: Make OpenVPN write
	PID file to avoid various sudo issues
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
To: davids@...515...
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Because it make sense and I've been bitten by the bug, too :-)

Your patch has been applied to the following branches

commit e0926ebfe55347843af701216be9598827a1367a  (master)
commit 057b70f1642336b7eb939f8515de791d515b8d04  (release/2.3)
Author: David Sommerseth
Date:   Sat Sep 17 12:20:26 2016 +0300

     t_client.sh: Make OpenVPN write PID file to avoid various sudo issues

     Trac: #738
     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1474104026-20615-1-git-send-email-davids@...515...>
     URL: http://www.mail-archive.com/search?l=mid&q=1474104026-20615-1-git-send-email-davids@...515...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


