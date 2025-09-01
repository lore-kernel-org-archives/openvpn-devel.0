Date: Mon, 1 Sep 2025 17:48:53 +0200 (CEST)
Message-Id: <202509011548.581FmrHU021990@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250826184904.22057-1-gert@...1296...>
References: <20250826184904.22057-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: manage: Make sure various
 management flags are treated as unsigned
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at code. This one looks a bit more complex than the trivial ones 
merged already, but it really isn't - it's just more groups of defines
(with the largest number being "1<<17"), and a single "flags" variable
changing to "unsigned".  BB tested this, but not really excercising
the management interface...  but I'll have to do that anyway in the
context of gerrit #869.

Your patch has been applied to the master branch.

commit cd58786548554263d18531f570d5350ec667fa0c
Author: Frank Lichtenheld
Date:   Tue Aug 26 20:48:57 2025 +0200

     manage: Make sure various management flags are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250826184904.22057-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32687.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


