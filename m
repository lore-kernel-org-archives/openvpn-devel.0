Date: Wed, 15 Jul 2020 14:40:51 +0200 (CEST)
Message-Id: <202007151240.06FCepRR067750@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-5-arne@...1227...>
References: <20200711093655.23686-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Refactor to use
 return values instead of modifying a passed-in flag
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

White space has been whacked as instructed :-)

Tested (yesterday) already on the server test rig, all good.

The code changes look good (though I find the patch granularity "too fine",
with all the extra calls to cc_check_return() added just to have them
removed again further down the series).  I object to the use of the term
"call-back" functions, because they aren't...  it's just a series of helpers
that are called via a function pointer array later on, but there is no "back"
involved anywhere ("pass a function pointer down to a library that does a
call-back into your code to do things").

commit 4f29b73b168904a764151f1acef0ea73c0fcece1
Author: Fabian Knittel
Date:   Sat Jul 11 11:36:46 2020 +0200

     client-connect: Refactor to use return values instead of modifying a passed-in flag

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200711093655.23686-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20286.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


