Date: Tue, 15 Nov 2016 09:47:25 +0100 (CET)
Message-Id: <201611150847.uAF8lPxG093715@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20161113195228.74090-1-gert@...1296...>
References: <20161113195228.74090-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace WIN32 by _WIN32
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

Patch has been applied to the master branch.

I have changed the '#endif /* ENABLE_CRYPTOAPI */' as suggested (because
it obviously makes sense), and had to move one hunk from misc.c to 
options.c (someone moved warn_if_group_others_accessible() around while 
I was not looking).

Further, the change to m4/ax_socklen_t.m4 was already brought in by
commit 11eedcd00, so skipped that hunk.

commit 445b192a7c31187c7b5c66c8250a1886b04a2b2c
Author: Gert Doering
Date:   Sun Nov 13 20:52:28 2016 +0100

     Replace WIN32 by _WIN32

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20161113195228.74090-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13035.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


