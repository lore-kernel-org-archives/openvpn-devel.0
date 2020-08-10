Date: Mon, 10 Aug 2020 14:42:47 +0200 (CEST)
Message-Id: <202008101242.07ACglSu012072@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200809141922.7853-1-arne@...1227...>
References: <20200809141922.7853-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rework NCP compability logic
 and drop BF-CBC support by default
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

As discussed on IRC, I have rewritten parts of the commit
message to take the v3 changes and Richard's language comments
into account.  I have also removed the whitespace change
hunks from multi.c that are not correct according to the 
Whitespace Governor.

I can't claim that I understand every single aspect of the
change set, but I have thoroughly tested this on the server
testbed.  It nicely exploded until I added "cipher BF-CBC"
to all server.conf settings - as documented and logged.  After
changing this, all tests pass - 2.2 to master clients, with
and without OCC, with and without --disable-ncp.

CAVEAT: setting an per-instance cipher from ccd/ is ignored
now, if the client is 2.4 (IV_NCP=2, but no IV_CIPHER) and 
is not already advertising the cipher in question (and in 
this case, it does need not do anything).  After some discussion 
between Arne, Steffan and me, we have decided to document 
this, and bring back the functionality in a followup patch 
if a compelling use case is found why we actually need it.


I have also tested the client side of this against a slightly
older master server, and that worked as well.  The --ncp-disable
cases "with cipher not set in the config" break (as documented), 
and want "--cipher bf-cbc" added to the client config.

CAVEAT: the particular funky case of "--client vs. a --tls-server
server" (--inetd) breaks, because the server decides that it
wants to "push BF-CBC", which the *client* then rejects based
on "not allowed - BF-CBC not in AES-256-GCM:AES-128-GCM" - I think
this might work if the server were not pushing anything, but it's 
a strange corner case anyway.  So, just documenting this here
(adding "--cipher BF-CBC" makes it work).


Your patch has been applied to the master branch.

commit 2c1d8c33d99d1d6d7902ea5845d7327aa6db9363
Author: Arne Schwabe
Date:   Sun Aug 9 16:19:21 2020 +0200

     Rework NCP compability logic and drop BF-CBC support by default

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200809141922.7853-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20656.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


