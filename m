Date: Sat, 28 Feb 2026 10:38:08 +0100 (CET)
Message-Id: <202602280938.61S9c8AT065258@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260227224745.3175-1-gert@...1296...>
References: <20260227224745.3175-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_freebsd: use AF_LOCAL
 sockets for ioctl() communication with DCO driver
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the review, thanks to Marek for reporting and testing.

Patch has been applied to the master, release/2.7 and release/2.6 branch
(it's something like "long-term compat" and we could argue that FreeBSD
will move to 2.7.x really soon now, so this is not needed - but it brings
an extra msg() that helps problem diagnosis, and there is a benefit - also
the change is very very isolated).

commit 5f19355d15da17cbc70624f833171f162adc4ea4 (master)
commit b215499c30581d8b2c5344ea5c4d6b1c25580955 (release/2.7)
commit a89186242f49b5cb7ed790f57430b9fc00b8973a (release/2.6)
Author: Gert Doering
Date:   Fri Feb 27 23:47:39 2026 +0100

     dco_freebsd: use AF_LOCAL sockets for ioctl() communication with DCO driver

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1551
     Message-Id: <20260227224745.3175-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35795.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


