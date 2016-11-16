Date: Wed, 16 Nov 2016 21:27:58 +0100 (CET)
Message-Id: <201611162027.uAGKRwX4019238@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479217256-21298-1-git-send-email-davids@...515...>
References: <1479217256-21298-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Remove --tls-remote
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK - does what it says on the lid (plus remove all cross-checks for
options that could have been set by --tls-remote)

Your patch has been applied to the master branch.

commit 10ce637066f44e8ad9f4af000b8d0c2a4012236d
Author: David Sommerseth
Date:   Tue Nov 15 14:40:56 2016 +0100

     options: Remove --tls-remote

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479217256-21298-1-git-send-email-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13070.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


