Date: Sat, 8 Oct 2022 22:42:55 +0200 (CEST)
Message-Id: <202210082042.298KgtfH099733@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220917134832.16359-1-a@...2181...>
References: <20220917134832.16359-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: auth-user-pass: add support for
 inline credentials
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

This is, amazingly, quite straightforward.  I assumed major complications
but our magic "ask for username and password" function *already* supports
inline, we just didn't use it for --aup yet...

I have stared at the code for a bit (looks good, though the multi-line
calls to get_user_pass_cr() could use some "folding up" now), and
tested with inline

 <auth-user-pass>
 username
 pass
 </auth-user-pass>

and also classic --auth-user-pass with/without filename combinations
(and, me twisted mind, multiple --auth-user-pass statements in the 
same invocation - "last one wins").

Works :-)


Your patch has been applied to the master branch.

commit 7d48d31b8226d5e3a5638e2369876381038bf5e2
Author: Antonio Quartulli
Date:   Sat Sep 17 15:48:32 2022 +0200

     auth-user-pass: add support for inline credentials

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220917134832.16359-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25236.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


