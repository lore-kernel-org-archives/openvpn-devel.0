Date: Mon, 1 Aug 2022 16:06:18 +0200 (CEST)
Message-Id: <202208011406.271E6ILA050747@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220728152012.18643-1-a@...2181...>
References: <20220728152012.18643-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: configure keys in DCO
 right after generating them
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Tests without --enable-dco (full server side test) - passes everything.

Test with --enable-dco but no Kernel support (client side only) - also
passes everything (spurious failure on one of the p2p tests, but that
was likely related to "too many tests running in parallel").

Did not test on a system with DCO kernel support, as we do not have all
bits and pices integrated yet.

I have not tested the "drop packet" case in forward.c (as that needs
a DCO enabled kernel).  Putting that on my "test with full DCO!" list
- the code certainly looks good.


Stared at code for a bit (even though it has the ACK).

Not sure I like the call chain ssl.c->dco.c->crypto.c for 
init_key_dco_bi() -> key_direction_state_init()... but changing
that would require a bit more ssl.c/crypto.c refactoring.

For the non-DCO cases, the _bi stuff has "key_ctx_update_implicit_iv()"
calls - are these done by the DCO kernel side?  Can't find anything
about IVs in the init_key_dco_bi()->... call chain...

Do the calls to "tls_session_update_crypto_params()" really need to
get a "session" parameter passed in now?  Since they get c->c2.tls_multi
now, "sesion" is just one pointer deref away...  so this might warrant
a cleanup patch later on.


Your patch has been applied to the master branch.

commit 6a5612fe82453915755aca945ff4e876a25f582a
Author: Antonio Quartulli
Date:   Thu Jul 28 17:20:12 2022 +0200

     dco: configure keys in DCO right after generating them

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220728152012.18643-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24758.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


