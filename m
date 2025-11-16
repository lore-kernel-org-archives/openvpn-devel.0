Date: Sun, 16 Nov 2025 12:43:41 +0100 (CET)
Message-Id: <202511161143.5AGBhf2J038088@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251116113230.31872-1-gert@...1296...>
References: <20251116113230.31872-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tapctl: make output of 'list'
 and 'create' commands more verbose
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

Stared at the code (looks good), built a test binary on ubuntu 24.04/mingw,
tested that (64 bit intel binary) on Win11 24H2/ARM, and everything works
and does what it says on the lid.

Do I see more room for output improvement?  Always :-) - but this is 
already improving things, so, ship it!

Your patch has been applied to the master branch.

commit c8f0e726f1d3d02d546d7eb3ef03eb7429c44272
Author: Lev Stipakov
Date:   Sun Nov 16 12:32:24 2025 +0100

     tapctl: make output of 'list' and 'create' commands more verbose

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1372
     Message-Id: <20251116113230.31872-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34451.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


