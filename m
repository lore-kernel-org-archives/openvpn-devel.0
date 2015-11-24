Date: Tue, 24 Nov 2015 13:58:42 +0100 (CET)
Message-Id: <201511241258.tAOCwgxO084306@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1447190223-8065-1-git-send-email-gert@...1296...>
References: <1447190223-8065-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix FreeBSD-specific
	mishandling of gc arena pointer in create_arbitrary_remote()
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

Patch has been applied to the master and release/2.3 branch.

commit b33e1355765bbf83f4c8b744c442c7d98df808fa (master)
commit 66a34601ecef2a099403468d239ea3f9b3a3b970 (release/2.3)

Author: Gert Doering
Date:   Tue Nov 10 22:17:03 2015 +0100

     Fix FreeBSD-specific mishandling of gc arena pointer in create_arbitrary_remote()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1447190223-8065-1-git-send-email-gert@...1296...>


--
kind regards,

Gert Doering


