Date: Tue, 20 Apr 2021 13:21:01 +0200 (CEST)
Message-Id: <202104201121.13KBL1ul028874@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210415093454.18324-1-maximilian.fillinger@...2507...>
References: <20210415093454.18324-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Abort if CRL file can't be
 stat-ed in ssl_init
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

The actual code change looks very magical to me, and shrunk dramatically
between v1 and v3 of that code :-) - but if Antonio has tested this
and ACKs it, who am I to complain.  I have compile-tested it, at least.

Your patch has been applied to the master and release/2.5 branch (bugfix).

commit 940619c88067d95a1c9865795624bc3822a89bd7 (master)
commit 8a06459d0c969b083377b63be16e5da1245ce0ee (release/2.5)
Author: Max Fillinger
Date:   Thu Apr 15 11:34:54 2021 +0200

     Abort if CRL file can't be stat-ed in ssl_init

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210415093454.18324-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22118.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


