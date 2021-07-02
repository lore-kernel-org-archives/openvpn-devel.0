Date: Fri, 2 Jul 2021 12:06:21 +0200 (CEST)
Message-Id: <202107021006.162A6LvP047768@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210520150932.2565217-1-arne@...1227...>
References: <20210520150932.2565217-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move examples into
 openvpn-examples(5) man page
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

I have adjusted the tab, and added openvpn-examples.5 to dist_man_MANS,
as instructed.

I have run "make distcheck" on a machine with and without py-docutils
(with docutils, it creates the openvpn-examples.5 page and packs it,
without, it fails - at it must be) and verified that the generated 
.5/.5.html files make it to the tarball.

Since *this* patch is only about splitting the man pages (and does not
concern itself with actual content which might depend on "is only in
master") it makes sense to have it in 2.5 as well -> done.

Your patch has been applied to the master branch.

commit 0c5380e906116b61ce9ed5310181291941b75227 (master)
commit 11fe49e31afd9b05da751d60680e8d2254fd9cd6 (release/2.5)
Author: Arne Schwabe
Date:   Thu May 20 17:09:31 2021 +0200

     Move examples into openvpn-examples(5) man page

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20210520150932.2565217-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22414.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


