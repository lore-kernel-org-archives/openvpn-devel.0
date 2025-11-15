Date: Sat, 15 Nov 2025 17:42:08 +0100 (CET)
Message-Id: <202511151642.5AFGg8Ms000802@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251114212112.6370-1-gert@...1296...>
References: <20251114212112.6370-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tapctl: factor out command
 handlers
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Reviewed ("this is all code that is the same as before, just moved into
dedicated functions, pointers renamed/adjusted, status signalling
adjusted...", so a bit less trivial than "git show --color-moved -w").

Reasonable change, much simpler "units of comprehension" now.

BB is happy, and so is my local Ubuntu + MinGW compile.

Your patch has been applied to the master branch.

commit ef4937f87280f68fb14459ca53d955c8d5d771e5
Author: Lev Stipakov
Date:   Fri Nov 14 22:21:07 2025 +0100

     tapctl: factor out command handlers

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1370
     Message-Id: <20251114212112.6370-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34432.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


