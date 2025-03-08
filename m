Date: Sat, 8 Mar 2025 09:38:34 +0100 (CET)
Message-Id: <202503080838.5288cYu5075708@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250305171730.250444-1-frank@...2641...>
References: <20250305171730.250444-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Handle missing DCO peer by
 restarting the session
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks, and sorry for stalling since January.  This is still not 
"really really" pretty, but I am still convinced that dealing with DCO
related issues inside dco*.c is a better approach :-)

I have not actually excercised the code (I do not have experienced the
underlying issue yet, which smells like a race condition between kernel
and userland), just stared at it for a bit, and relied on the BB army
to verify that it compiles and passes t_client on all DCO-enabled
platforms (it does).

Not sure why we would ever hit dco_get_peer_stats() with peer_id == -1
(in that case userland should know "the peer is gone") but the check
won't harm - though slightly unrelated.  Good catch on the uint32_t.

Your patch has been applied to the master branch.

commit 6f9ba8bfd259742ee19b173898a9bfd20e22fcf3
Author: Ralf Lici
Date:   Wed Mar 5 18:17:30 2025 +0100

     Handle missing DCO peer by restarting the session

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250305171730.250444-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31022.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


