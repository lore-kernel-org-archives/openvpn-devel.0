Date: Thu, 9 Mar 2023 18:54:26 +0100 (CET)
Message-Id: <202303091754.329HsQSt093027@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230308151945.3670151-1-arne@...1227...>
References: <20230308151945.3670151-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set netlink socket to be
 non-blocking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

I cannot reproduce this particular problem on my Linux/DCO systems
here, but with the problem description, the patch makes sense.

Minimally tested on a Linux/DCO system.

Your patch has been applied to the master and release/2.6 branch.

commit 7aa3520768a68fb6a73ab64569c7be5d571f86fc (master)
commit 35104bdc937191d49c3505a354444eb6a267e9ee (release/2.6)
Author: Arne Schwabe
Date:   Wed Mar 8 16:19:45 2023 +0100

     Set netlink socket to be non-blocking

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230308151945.3670151-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26353.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


