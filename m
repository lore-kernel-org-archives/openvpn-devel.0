Date: Tue, 28 Oct 2025 19:53:15 +0100 (CET)
Message-Id: <202510281853.59SIrFmK022943@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251021070825.20773-1-gert@...1296...>
References: <20251021070825.20773-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: management: ensure consistent
 BYTECOUNT timing on server
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

Took a bit between +2 and merge, but here we are :-)

Tested on FreeBSD+DCO with "bytecount 2", which used to do "10 seconds
and no less".  New code does 2s if 2s is ordered...  whether or not that
is *useful* depends on the management client, I'd say :-) - but having
consistent behaviour is a good thing.

Looking at the code, I did wonder why multi_get_timeout_instance()
lives in multi.h, when it is only used from multi.c - this is actually
a multisocket artefact.  2.6 calls this from mudp.c and mtcp.c, so
it made sense.  master/2.7 only calls this from multi.c, so we could
move it in there eventually.

Your patch has been applied to the master branch.

commit a5ee6a1d642ae365eae78fd04d51976c365b2b59
Author: Ralf Lici
Date:   Tue Oct 21 09:08:20 2025 +0200

     management: ensure consistent BYTECOUNT timing on server

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20251021070825.20773-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33812.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


