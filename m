Date: Wed, 30 Dec 2015 19:20:40 +0100 (CET)
Message-Id: <201512301820.tBUIKeHo050559@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1451422957-23951-1-git-send-email-lstipakov@...277...>
References: <1451422957-23951-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Detecting and logging Windows
	versions
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Thanks.

Your patch has been applied to the master branch.

Changes as for release/2.3 patch - added text to Changes.rst and 
#if defined(WIN32) to ssl.c change (IV_PLAT_VER)

commit cdc65ea0f1f94974f55352d794627561c78c4151 (master)

Author: Lev Stipakov
Date:   Tue Dec 29 23:02:37 2015 +0200

     Detecting and logging Windows versions

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1451422957-23951-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10904
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


