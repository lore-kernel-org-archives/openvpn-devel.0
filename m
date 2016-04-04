Date: Mon, 4 Apr 2016 21:36:54 +0200 (CEST)
Message-Id: <201604041936.u34Jasao045221@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1456993146-63968-5-git-send-email-james@...515...>
References: <1456993146-63968-5-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extended x509-track for OpenSSL
	to report SHA1 fingerprint.
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
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

As Steffan has requested, I have wrapped the long "sha1_fingerprint = ..."
line to keep line lengths below 80 characters.  Purely whitespace change.

commit f6608a15efab027e25553da3026c172dbc3aa73e (master)
Author: James Yonan
Date:   Thu Mar 3 01:19:01 2016 -0700

     Extended x509-track for OpenSSL to report SHA1 fingerprint.

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1456993146-63968-5-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11281
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


