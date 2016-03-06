Date: Sun, 6 Mar 2016 19:35:22 +0100 (CET)
Message-Id: <201603061835.u26IZMeG051475@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1456457091-3872-1-git-send-email-selva.nair@...277...>
References: <1456457091-3872-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor and move the
	block-outside-dns code to a new file (block_dns.[ch])
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

This is a bit bigger than "just move to new file" because it gets rid
of global variables at the same time (h_EngineHandle etc.) and simplifies
the error handling by introducing a CHECK_ERROR() macro - but as far as
I could figure out, it's still doing the same things.

I have not actually tested it, just "stare at code" - Samuli's buildbot
will make us a new installer based on this, and people using block_dns
functionality should thoroughly test it, with and without the iservice
running (iservice patch next).

As discussed on the list, I've added <winsock2.h> and <ws2ipdef.h> to
block_dns.c

Your patch has been applied to the master branch.

commit 6a33a34dee8f3b574275d8df1635fb550ec054f3
Author: Selva Nair
Date:   Thu Feb 25 22:24:50 2016 -0500

     Refactor and move the block-outside-dns code to a new file (block_dns.[ch])

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1456457091-3872-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11264
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


