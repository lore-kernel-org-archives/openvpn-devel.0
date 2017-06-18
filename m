Date: Sun, 18 Jun 2017 22:35:38 +0200 (CEST)
Message-Id: <201706182035.v5IKZcCt002247@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170618194104.25179-1-gert@...1296...>
References: <20170618194104.25179-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix potential 1-byte overread
 in TCP option parsing.
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

Patch has been applied to the master, release/2.4, 2.3 and 2.2 branch.

commit 22046a88342878cf43a9a553c83470eeaf97f000 (master)
commit 529de430ce07d0c3210a4636b1cb4c89cc6c8fc1 (master)
commit 4d343fbe9166e14187775567db00c0a91017df83 (release/2.3)
commit 2cc3583ddbc7ce98d859475422cb4e1c217c8083 (release/2.2)
Author: Gert Doering
Date:   Sun Jun 18 21:41:04 2017 +0200

     Fix potential 1-byte overread in TCP option parsing.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20170618194104.25179-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20170618194104.25179-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


