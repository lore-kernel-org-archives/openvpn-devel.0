Date: Wed, 14 Dec 2022 14:07:46 +0100 (CET)
Message-Id: <202212141307.2BED7kCm087992@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221205164103.9190-3-kprovost@...2661...>
References: <20221205164103.9190-3-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: Update counters when a
 client disconnects
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is indeed an important missing piece for correct stats (... to be
handed to --client-disconnect scripts, etc).

I have not tested the feature as such (kernel side support has landed
but I have not yet rebuilt that system).  I *have* tested the tree
on Linux/FreeBSD with/without DCO, and everything works as before.

Looking at the code: storing these in dco_context "to be able to 
transport to the caller" sounds like an reasonable approach, because
the dco_do_read() functions know "nothing else" - we could introduce
call-by-ref variables, but that won't make the code easier to read.

The nested nvlists (bytes->{in,out}) here add a level of trust to the
running kernel - should "in" be missing, nvlist_get_number(9) documents
"the program will be aborted".  The existance of "bytes" is checked,
so old/new kernel compat is fine (OTOH if we do not trust the kernel
module here, we're lost anyway).  Just sayin'.

Your patch has been applied to the master and release/2.6 branch.

commit 6674963debfb88c0dd3dd4eae4533010ffc319b1 (master)
commit f05c7a8a11329cc579d3751469b597e0eab1317f (HEAD -> release/2.6)
Author: Kristof Provost
Date:   Mon Dec 5 17:41:01 2022 +0100

     dco: Update counters when a client disconnects

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221205164103.9190-3-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25614.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


