Date: Sat, 7 Jan 2023 18:01:43 +0100 (CET)
Message-Id: <202301071701.307H1hhf068883@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230103202330.1835-1-a@...2181...>
References: <20230103202330.1835-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: properly re-initialize
 dco_del_peer_reason
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

I've done a bit of stare-at-code, and it's nicely trivial :-) - but let
me repeat what I said on IRC, better coding style would be to do proper
initialization *before* calling dco_do_read(), not as an afterthought
at the end of the function (which also breaks "early return").

I have not tested this patch on its own (just compile-tested), as it's
trivial enough and has an ACK already.

For now this is fine, but we should come back here.

Your patch has been applied to the master branch.

commit e9889016fb7269d025a2dbba5f7079ee87e39520 (master)
commit aaccf88431eb146231a600971227a8a6c395b349 (release/2.6)
Author: Antonio Quartulli
Date:   Tue Jan 3 21:23:28 2023 +0100

     dco: properly re-initialize dco_del_peer_reason

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230103202330.1835-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25881.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


