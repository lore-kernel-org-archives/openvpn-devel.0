Date: Tue, 8 Nov 2016 14:39:11 +0100 (CET)
Message-Id: <201611081339.uA8DdBri034337@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1478609729-25222-2-git-send-email-samuli@...515...>
References: <1478609729-25222-2-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix update_t_client_ips.sh for
	out of tree builds
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

ACK.  Code change looks good, and verifiably fixes the problem :-)

(Note that there needs to be 5/4 that resets up='' when not needed...)

Your patch has been applied to the master branch.

commit 2af1fa8b19e9723b29f4a4c198f61478ae9e688e
Author: Samuli Seppänen
Date:   Tue Nov 8 14:55:26 2016 +0200

     Fix update_t_client_ips.sh for out of tree builds

     Signed-off-by: Samuli Seppänen <samuli@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1478609729-25222-2-git-send-email-samuli@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12952.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


