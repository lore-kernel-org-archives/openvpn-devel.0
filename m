Date: Fri, 10 Oct 2025 11:56:12 +0200 (CEST)
Message-Id: <202510100956.59A9uCBM078443@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251010094753.2825-1-gert@...1296...>
References: <20251010094753.2825-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: console: Simplify
 query_user_add interface
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Yeah, having a "prompt_len" field in there for the unlikely case of having
a prompt that is not 0-terminated, and then all the backends just do not
use this at all - functions should have been named ..._ex(), to be prepared
for all eventualities...

Stared at code, change was less intrusive than I expected when seeing
"oh, so many files", and is very straightforward.

Smoke-tested with a corp VPN profile which has a crypted privkey plus
username + password, and that all still works.

Your patch has been applied to the master branch.

commit aea7727f2de8c4f34d71a8c14756bdf395cb5f2f
Author: Frank Lichtenheld
Date:   Fri Oct 10 11:47:44 2025 +0200

     console: Simplify query_user_add interface

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1216
     Message-Id: <20251010094753.2825-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59244794/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


