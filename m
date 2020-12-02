Date: Wed, 2 Dec 2020 14:49:19 +0100 (CET)
Message-Id: <202012021349.0B2DnJHL003818@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201202115928.16615-1-arne@...1227...>
References: <20201202115928.16615-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove
 auth_user_pass.wait_for_push variable
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

I have pre-tested these changes extensively yesterday, trying 
to find new and exciting ways to break the combination of (async) 
plugin-auth, gen-auth-token, and --auth-nocache on the client - and 
this patchset finally makes this all work correctly :-)   

(my suggestion how to tackle this would have always stored the auth 
username, even if no token auth in use, which seems to violate the 
original principle of --auth-nocache)

Tested again with pristine master sources with only this patch
applied, and it still works.

Your patch has been applied to the master, release/2.5 and
release/2.4 branch (bugfix).

commit dfd624b52bce7ddd0eeaab516df9848e432f3242 (master)
commit 570f0564afb34ede41c99bf66f1f369bcf38b138 (release/2.5)
commit 607dfa9648e9967f89d2ce5bf949e90503011522 (release/2.4)
Author: Arne Schwabe
Date:   Wed Dec 2 12:59:28 2020 +0100

     Remove auth_user_pass.wait_for_push variable

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201202115928.16615-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21297.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


