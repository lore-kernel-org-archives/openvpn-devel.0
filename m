Date: Fri, 24 Jan 2025 14:44:03 +0100 (CET)
Message-Id: <202501241344.50ODi3JS023059@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250124115849.14638-1-gert@...1296...>
References: <20250124115849.14638-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multiproto: move generic event
 handling code in dedicated files
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Basically this patch is just "moving code around" and renaming things with
"_tcp_" in them to "_io_", generalizing the "store things" structure to
be used for TCP and UDP now.  I argued the "_protocol_" part of earlier
versions away ("HTTPS is also a 'protocol'") and I think the current version
is good enough to move forward.

I've stared a lot at the code, and ran various versions on the client/server
testbed - and they all passed all tests.

"git show --color-moved=zebra" is only half-helpful due to all the
renaming - but it does help to feel reasonably secure that this is
still doing the same thing.

Your patch has been applied to the master branch.

commit cbb0440ee884ba3c052066d915d6fd7ce86befd2
Author: Gianmarco De Gregori
Date:   Fri Jan 24 12:58:48 2025 +0100

     multiproto: move generic event handling code in dedicated files

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250124115849.14638-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30561.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


