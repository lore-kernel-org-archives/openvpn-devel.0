Date: Mon, 15 Dec 2025 16:41:50 +0100 (CET)
Message-Id: <202512151541.5BFFfoXQ059174@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251215145528.18047-1-gert@...1296...>
References: <20251215145528.18047-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: Fix type handling for
 hashes, mostly inotify_watchers
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

This code does not really cater to my sensitivities... but having a long
get_random() go into an uint32_t won't work without either some cast, or
adding a new get_random_u32()... which would be a bit overdoing things
as well (that said, looking at get_random()'s signedness, questions 
do arise).

Anyway.  The changes look reasonable.  The hash stuff will not become
any more pretty - if a pointer is stored, but we really compare "integer
keys" (pointer-as-integer, not pointer-to-integer) casts are needed...

Not tested this beyond "BBs are happy", but the inotify stuff will be
excercised by the server side testbed (which will tell me tomorrow if
it *did* break something).

Your patch has been applied to the master branch.

commit e2c97f3833a5616004da4d84fb9e0d023c9033e5
Author: Frank Lichtenheld
Date:   Mon Dec 15 15:55:23 2025 +0100

     multi: Fix type handling for hashes, mostly inotify_watchers

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1312
     Message-Id: <20251215145528.18047-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35072.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


