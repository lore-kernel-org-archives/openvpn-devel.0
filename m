Date: Mon, 30 Nov 2020 17:35:55 +0100 (CET)
Message-Id: <202011301635.0AUGZtTA055563@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201130123928.21837-1-arne@...1227...>
References: <20201130123928.21837-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix auth-token not being
 updated if auth-nocache is set
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

Thanks for digging into this - this was an annoying and hard 
to diagnose "sometimes, TLS reconnects fail for users where 
it *should* succeed due to tokens being used" problem (that
openvpn considers tokens sensitive and never logs them 
didn't help pinpointing the issue :-) ).

I tested this with a client built with lots of extra
debug output, gen-auth-token and frequend tls-renegotiates - 
and indeed, "up->defined" goes to "0" after the first incoming 
token if auth-nocache is active - so, no *further* tokens are 
learned.  With the patch, we also look at "tk->defined", which 
is *then* defined, and tokens work even in that case.

Verified with a 2.4 client against a master server, including
a master restart without having to re-enter credentials on
the client.  Yay :-)

Your patch has been applied to the master, release/2.5 and
release/2.4 branch (bugfix, identical code in all branches).

commit fb789947ab1eba3e68fb8e4b3551d095a53962bd (master)
commit 95e183723fc6571c73ed070b22923df2ce666af2 (release/2.5)
commit f9b73042892c14b906772e72b3116d809457c721 (release/2.4)
Author: Arne Schwabe
Date:   Mon Nov 30 13:39:28 2020 +0100

     Fix auth-token not being updated if auth-nocache is set

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201130123928.21837-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21291.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


