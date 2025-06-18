Date: Wed, 18 Jun 2025 18:13:47 +0200 (CEST)
Message-Id: <202506181613.55IGDl2u003926@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250618141328.4600-1-gert@...1296...>
References: <20250618141328.4600-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_server_null: print error when
 server startup fails
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
To: samuli.seppanen@...277...
Cc: openvpn-devel@lists.sourceforge.net

v3 looks good and does the job :-) - it needed a bit of massaging
because the context has changed (commit 4d104a385) and because it
really wants to go on top of #915 - but that's the wrong order, the
"we want to see the failures?!" patch needs to go in before the
one that triggers new failures...

So, adjustments to t_server_null_default.rc to adapt to this.

Your patch has been applied to the master branch.

commit 378c2e2f2c155d92989f988b6fffb0e8980fa83d
Author: Samuli Seppänen
Date:   Wed Jun 18 16:13:21 2025 +0200

     t_server_null: print error when server startup fails

     Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250618141328.4600-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31932.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


