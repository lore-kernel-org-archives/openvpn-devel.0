Date: Sun, 12 Sep 2021 11:00:48 +0200 (CEST)
Message-Id: <202109120900.18C90m9T094186@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210827190014.12640-1-a@...2181...>
References: <20210827190014.12640-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove support for PF (Packet
 Filter)
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

I have added an entry to Changes.rst, as requested.

I have changed the // comment in openvpn/manage.h to /* */ as pointed
out by Matthias.

Code-wise, this is fairly straightforward (as it's mostly just "code inside 
#ifdef"), except for my nicely fixed-up plugin code :-) - but that one is 
good, too (and even had a comment on why it's "tls_final()").

NOTE: multi_process_incoming_link() now has an extra set of {} with
indentation, due to the old construct of having an "else" as the last
statement in the #endif (around line 3200) - we should fix this 
with a followup patch.


I have lightly tested this server/client side - I have no setup that
actually makes use of pf, so nothing breaks :-) - but all the rest seems 
to work just fine.

Your patch has been applied to the master branch.

commit 1308ccec9f85418b088723bb870855c0a933311b
Author: Antonio Quartulli
Date:   Fri Aug 27 21:00:14 2021 +0200

     Remove support for PF (Packet Filter)

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210827190014.12640-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22780.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


