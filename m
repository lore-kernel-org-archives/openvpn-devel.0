Date: Tue, 26 Nov 2013 15:50:15 +0100
Message-Id: <201311261450.rAQEoFux025737@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385382680-5912-1-git-send-email-arne@...1227...>
References: <1385382680-5912-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Split link_socket_init_phase2
	into smaller more managable/readable functions. No functional
	changes
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  This really is just moving code bits around without any actual
change I could spot.  And it passes my test rig :-)

Patch has been applied to the master branch, with some whitespace fixes.

commit 48f1d41a80b1f2aa9e47b38f645dc880bd7090a4

Author: Arne Schwabe
Date:   Mon Nov 25 13:31:12 2013 +0100

     Split link_socket_init_phase2 into smaller more managable/readable functions. No functional changes

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385382680-5912-1-git-send-email-arne@...1227...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


