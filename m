Date: Wed, 3 Aug 2022 16:30:45 +0200 (CEST)
Message-Id: <202208031430.273EUjoo003758@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220802151604.2801-1-a@...2181...>
References: <20220802151604.2801-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: periodically check and
 possibly rotate/delete keys
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

Acked-by: Gert Doering <gert@...1296...>

The review of that was a combined effort, mostly Frank on mail and
Antonio and I on IRC - but the v3 is now easier to understand, and
"should work nicely".

I have slightly extended the comment before "swapping primary and
secondary keys" to make a bit clearer how we end there (we discussed
that comment on IRC).

This said, I have only tested the "no DCO in kernel" cases, as the
rest is still missing functinality - and for "no DCO", this becomes
fairly much "no change", as the only new code otherwise is guarded
with "if (!dco_enabled(&c->options))".

Your patch has been applied to the master branch.

commit cd4ba9279d9c4cf13cdc3d8c49143c57eb0fe448
Author: Antonio Quartulli
Date:   Tue Aug 2 17:16:04 2022 +0200

     dco: periodically check and possibly rotate/delete keys

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220802151604.2801-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24785.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


