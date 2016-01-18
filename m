Date: Mon, 18 Jan 2016 22:24:17 +0100 (CET)
Message-Id: <201601182124.u0ILOHZx028143@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1453150181-21453-1-git-send-email-steffan@...1856...>
References: <1453150181-21453-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: fix polarssl
	autodetection
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, fixes the problem with polarssl library autodetection for systems 
that need -lpolarssl.  If POLARSSL_CFLAGS= is set, it still need 
POLARSSL_LIBS= to be set as well - usually, you need both anyway, so
that's a particular special case that is now different - hereby 
documented.

Your patch has been applied to the master branch.

commit 417fe4a72c82accca8d95fb0488427f5b6dc4157
Author: Steffan Karger
Date:   Mon Jan 18 21:49:40 2016 +0100

     configure.ac: fix polarssl autodetection

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1453150181-21453-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11010
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


