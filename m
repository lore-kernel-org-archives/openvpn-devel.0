Date: Tue, 21 Apr 2026 10:31:55 +0200 (CEST)
Message-Id: <202604210831.63L8Vtt7009570@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260420165923.14226-1-gert@...1296...>
References: <20260420165923.14226-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: port core/context
 infrastructure needed for backport of commit 7791f53
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for digging through this, and backporting what is needed.

I have "git blame"'d master, and compared this backport to the master
comments.  The first one is

    commit a699681bb86c6e9a2c9f205543f60400208aea4b
    Author: Antonio Quartulli <antonio@...2726...>
    Date:   Wed Jul 23 15:39:11 2025 +0200

	dco: only pass struct context to init function

.. which is fully included in this commit here, and pretty straightforward.

The second one is

    commit 7f5a6deae33a338a23d7e8ff8526db8fdddf4bc2
    Author: Antonio Quartulli <antonio@...2726...>
    Date:   Wed Jul 23 08:10:25 2025 +0200

	multi: store multi_context address inside top instance

which is more complex, as the master commit modifies "multi.c" which does
not exist in release/2.6 (mudp.c, mtcp.c) - and also changes more things,
so this is backporting the change we need (top->multi) to the distinct
UDP/TCP server loops.

I have run this with and without DCO on Linux and FreeBSD, client and 
server setups, and have test compiled the windows version.  BB has compiled
and client-tested all the rest.


Your patch has been applied to the release/2.6 branch.

commit 876a8cf5fd6166a22bfe6b6f37889d3cff3a17c6
Author: Ralf Lici
Date:   Mon Apr 20 18:59:17 2026 +0200

     dco: port core/context infrastructure needed for backport of commit 7791f53

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1631
     Message-Id: <20260420165923.14226-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36691.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


