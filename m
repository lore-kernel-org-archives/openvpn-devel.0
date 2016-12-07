Date: Wed, 7 Dec 2016 19:44:31 +0100 (CET)
Message-Id: <201612071844.uB7IiVgt033736@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1481027162-12165-1-git-send-email-gert@...1296...>
References: <1481027162-12165-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor setting close-on-exec
	for socket FDs
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

Thanks for the test reports (Agi per Mail, Thermi on IRC) and ACK from
Arne.

Patch has been applied to the master branch ("this is a bugfix").

commit e35a788339497ec5c179a5d0a23f63824989ec3e
Author: Gert Doering
Date:   Tue Dec 6 13:26:02 2016 +0100

     Refactor setting close-on-exec for socket FDs

     URL: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=367716
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1481027162-12165-1-git-send-email-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13405.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


