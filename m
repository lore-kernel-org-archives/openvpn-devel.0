Date: Sat, 30 May 2020 20:28:40 +0200 (CEST)
Message-Id: <202005301828.04UISeIU065165@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200520183404.54822-1-code@...2557...>
References: <20200520183404.54822-1-code@...2557...>
Subject: [Openvpn-devel] [PATCH applied] Re: Switch assertion failure to
 returning false
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
To: Jeremy Evans <code@...2557...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch (bugfix).

Thanks.  I do hope Steffan finds time to track down the root cause of 
this - from your log, it smells like a timing issue if multiple clients 
connect in quick succession and multiple instances of the plugin are
called.  Making "something" not finish initializing before the first 
client sends his PUSH_REQUEST.  Or so.

commit 984bd1e1601e4b9562dbc88b02a8db60b884286f (master)
commit 098edbb1f5a2e1360fd6a4ae0642b63bec12e992 (release/2.4)
Author: Jeremy Evans
Date:   Wed May 20 11:34:04 2020 -0700

     Switch assertion failure to returning false

     Signed-off-by: Jeremy Evans <code@...2557...>
     Acked-by: Steffan Karger <steffan.karger@...2507...>
     Message-Id: <20200520183404.54822-1-code@...2557...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19914.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


