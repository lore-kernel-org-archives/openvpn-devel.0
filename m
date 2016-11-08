Date: Tue, 8 Nov 2016 14:58:24 +0100 (CET)
Message-Id: <201611081358.uA8DwOA8034692@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1478613043-27033-1-git-send-email-samuli@...515...>
References: <1478613043-27033-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow passing extra arguments
	to fping/fping6 in t_client.rc
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
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Tested with FPING_EXTRA_ARGS="-C 5" as "proof of concept".

Your patch has been applied to the master branch.

commit 6f17e18be0d6ab801704400abcc6b17d4fed9650
Author: Samuli Seppänen
Date:   Tue Nov 8 15:50:43 2016 +0200

     Allow passing extra arguments to fping/fping6 in t_client.rc

     Signed-off-by: Samuli Seppänen <samuli@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1478613043-27033-1-git-send-email-samuli@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12962.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


