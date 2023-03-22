Date: Wed, 22 Mar 2023 13:48:05 +0100 (CET)
Message-Id: <202303221248.32MCm5TB016516@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230322113408.2057-1-lstipakov@...277...>
References: <20230322113408.2057-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix '--inactive <time> 0'
 behavior for DCO
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  I have not actually tested this, but we've discussed this 
at length before - so this is "obviously correct".

The problem here (for readers of the list only) is that "a single packet"
is sufficient to keep the connection active if "--inactive ... 0" is
used - and "0 bytes" will be "abort".  With "if (new_bytes >= 0)", the
condition is always true in the DCO path, even if 0 packets have been
seen, so it never triggers.

It does cause an off-by-one, so if the limit is "1000 bytes", on DCO
it will need 1001 bytes now, while non-DCO will be fine with 1000 bytes,
but we decided that generally this is not "a single byte" precise, but
"lots of traffic" or "not much", so this is acceptable for a simpler
condition that people can actually understand in half a year...

Your patch has been applied to the master and release/2.6 branch.

commit 6c64b46b15476351ca19f9a8f3cb8185aa2c7e07 (master)
commit a3c9458d233d35d2afdb866aaa602bebaabf2f59 (release/2.6)
Author: Lev Stipakov
Date:   Wed Mar 22 13:34:08 2023 +0200

     Fix '--inactive <time> 0' behavior for DCO

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230322113408.2057-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=20230322113408.2057-1-lstipakov@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


