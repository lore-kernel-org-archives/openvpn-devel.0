Date: Tue, 2 Sep 2025 17:28:23 +0200 (CEST)
Message-Id: <202509021528.582FSNQO067926@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250902103606.22181-1-gert@...1296...>
References: <20250902103606.22181-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor management bytecount
 tracking
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

Tested this on client and server side, with and without DCO.

Can confirm that "counters with DCO" did not work without this patch,
and also the change to just get the counters from DCO once for all
peers is obviously beneficial for larger instances.

It took me a while to understand the multiple levels of code 
complexity that were there *before* (management_bytes_client() doing
something totally different than management_bytes_server(), for 
example) - so thanks a lot for refactoring this, the result is
much easier to understand, and due to the event based timing,
bytecounts are properly printed "on schedule" now (sometimes +1-2
seconds due to coarse timer granularity).

The mailing list and mail-archive.org are not playing nicely today,
so I've linked to the sourceforge.net list archive instead.

Your patch has been applied to the master branch.

commit da309c1e8bed7b9c25e800499400c8ad908276db
Author: Lev Stipakov
Date:   Tue Sep 2 12:36:01 2025 +0200

     Refactor management bytecount tracking

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250902103606.22181-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59228150/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


