Date: Tue, 2 Sep 2025 18:51:18 +0200 (CEST)
Message-Id: <202509021651.582GpItv071076@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250902115954.29021-1-gert@...1296...>
References: <20250902115954.29021-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: avoid printing mi prefix
 on float
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

Tested on Linux/DCO (my "float victim"), and it now is much less confusing
- there's clear "this is for a given peer" messages that include a prefix,
and there's low-level DCO informational messages which often come in
asynchronously, not related to the current mi peer.  With M_NOIPREFIX
these never get a prefix - and where relevant, they print the peer-id
anyway

+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer %u...", __func__, peer_id);

(and D_DCO_DEBUG is "verb 7", so there's enough messages that link peer-id
to a given client instance)

I'm not sure if we shouldn't do a bit larger rehaul of this, like always
include M_NOIPREFIX in the very definition of D_DCO_DEBUG (and all other
D_* levels that are similar in nature) - the whole "prefix" thing has been
there from day one, and we haven't really spent much thought on it (yet) -
but that might be a 2.8 topic, do what Selva has wanted to do for a long
time, and go with a fine comb over all the msg() and --verb levels...

The sig.c change is one of those places - ideally, everybody who 
raises a signal has the proper prefix beforehand (or resets it) - but
for "DCO has an error to raise" this is not really straightforward.


I have changed the commit message from "on float" to "on debug messages",
as this affected peer stats just as well - basically, any asynchronous
DCO event that wants to print infos.


Yet again, mail-archive.org is trying to annoy me - claiming there is
no such mail.  So, linking to sourceforge.net archive, again.

Your patch has been applied to the master branch.

commit 9e9ba09adbe08e93d91d8340efe63bae978f5f34
Author: Gianmarco De Gregori
Date:   Tue Sep 2 13:59:49 2025 +0200

     dco: avoid printing mi prefix on float

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250902115954.29021-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59228149/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


