Date: Sun, 19 Feb 2017 18:52:41 +0100 (CET)
Message-Id: <201702191752.v1JHqfl5094527@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <0e0d4a67192b563cd07d3f06685f85e34c304142.1487368114.git.logout@...260...>
References: <0e0d4a67192b563cd07d3f06685f85e34c304142.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: check for the SSL
	reason, not the full error
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
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

2.3 does not have this code, as far as I could see, so doesn't get 
the patch.

I can't reach sf.net right now (git.code.sf.net gives me "connection
refused"), so only pushed to github and gitlab.

commit 6ddc43d1bf9b3ea3ee5db8c50d56a98fe4db4c97 (master)
commit c4c359736e3ab7f06a21f1eab09e6fd4cf2bef2f (release/2.4)

Author: Emmanuel Deloget
Date:   Fri Feb 17 23:00:53 2017 +0100

     OpenSSL: check for the SSL reason, not the full error

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <0e0d4a67192b563cd07d3f06685f85e34c304142.1487368114.git.logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14087.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


