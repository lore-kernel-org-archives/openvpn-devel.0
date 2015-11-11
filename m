Date: Wed, 11 Nov 2015 09:19:02 +0100 (CET)
Message-Id: <201511110819.tAB8J2eA014484@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1447192719-31381-1-git-send-email-gert@...1296...>
References: <1447192719-31381-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix possible heap overflow on
	read accessing getaddrinfo() result.
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

Your patch has been applied to the release/2.3 branch.

commit cdbadd00582af84aa8adf588743eec8d01910a0b
Author: Gert Doering
Date:   Tue Nov 10 22:58:39 2015 +0100

     Fix possible heap overflow on read accessing getaddrinfo() result.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1447192719-31381-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10479


--
kind regards,

Gert Doering


