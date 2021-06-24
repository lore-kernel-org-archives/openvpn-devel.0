Date: Thu, 24 Jun 2021 16:36:36 +0200 (CEST)
Message-Id: <202106241436.15OEaawp079900@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210604143938.779193-1-arne@...1227...>
References: <20210604143938.779193-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make waiting on auth an
 explicit state in the context state machine
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

Stared at the code a bit, discussed on IRC about "what state does what?"
- so this new state is "TLS is ok, waiting for (deferred) authentication" 
and CAS_PENDING* is "waiting for (deferred) *client-connect* things" - 
which MUST NOT run before authentication is finished (= CVE...).

With that explanation, the changes looks straightforward enough, with the
new state added and the explanation given.

Arne also stated that a patch will come that better documents all 
CAS_ values.


Tested on the client side (no surprises) and on the server side test
rig, with all the nasties - deferred plugin auth, deferred client connect,
deferred script auth, succeeding and failing, config from ccd/ and from
--client-connect scripts - and it behaved nicely.

[Note: I still have no test rig with management auth, so we need to trust
the AS QA team to test all these cases...]

This still does not fix the "PUSH_REPLY is sent too quickly" CVE in
all cases, it seems.  But with the *next* one, it is finally fixed.

As discussed on IRC, added a note about the CVE to the commit message.

Your patch has been applied to the master branch.

commit 489c45fb373adfb22c2f1dd0a524bde17c686876
Author: Arne Schwabe
Date:   Fri Jun 4 16:39:38 2021 +0200

     Make waiting on auth an explicit state in the context state machine

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210604143938.779193-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22491.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


