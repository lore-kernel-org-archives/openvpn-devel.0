Date: Tue, 14 Feb 2023 16:13:35 +0100 (CET)
Message-Id: <202302141513.31EFDZ4D024493@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230204004322.250210-1-selva.nair@...277...>
References: <20230204004322.250210-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: cryptoapi.c: simplify parsing
 of thumbprint hex string
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Patch looks reasonable, and compiles fine :-) - looking forward to merge
the unit test patch for it.

There is a similar code piece in options.c::parse_hash_fingerprint(), but
it has slightly different semantics wrt length and separators, so merging
these (my initial thought) would lead to a typical OpenVPN blabla_ex()
function 3 times as long with 10 arguments... so, no, this is simple
enough (and while sscanf() might be inefficient, it's easier to read 
than the old the character manipulations, and for "once per connection",
readability trumps "a few microseconds saved")

Your patch has been applied to the master and release/2.6 branch.

commit 94bbe98b2b135b2da74b694358e6c94c1defbffd (master)
commit 5a70f5025a3f1aee53b531b2e7713dd99fa175bb (release/2.6)
Author: Selva Nair
Date:   Fri Feb 3 19:43:22 2023 -0500

     cryptoapi.c: simplify parsing of thumbprint hex string

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230204004322.250210-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26146.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


