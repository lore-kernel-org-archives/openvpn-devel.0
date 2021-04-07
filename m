Date: Wed, 7 Apr 2021 09:07:38 +0200 (CEST)
Message-Id: <202104070707.13777cwY098810@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210406162518.4075-3-arne@...1227...>
References: <20210406162518.4075-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove a number of checks for
 functions/headers that are always present
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

I find these very reasonable changes (like, what, <stdio.h> or <ctype.h>,
these have been around since K&R day 1...).  

And Eurephia definitely needs dropping!

The buildbot army agrees that these changes are fine :-)

Your patch has been applied to the master branch.

commit b8510baa25b9b6fad0fa373d414a4bbf1565acd0
Author: Arne Schwabe
Date:   Tue Apr 6 18:25:16 2021 +0200

     Remove a number of checks for functions/headers that are always present

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210406162518.4075-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22053.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


