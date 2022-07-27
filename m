Date: Wed, 27 Jul 2022 20:00:39 +0200 (CEST)
Message-Id: <202207271800.26RI0da5045524@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220721182425.1569798-1-gert@...1296...>
References: <20220721182425.1569798-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: introduce
 open_tun_dco_generic() to open dynamic or fixed-name DCO devices
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is a joint work with many iterations... so we have Antonio's ACK
on "the changes v10 to v11", and my ACK on the rest.

The patch has been tested on Linux with and without DCO enabled (passes
everything in both cases, as long as the system does not have a DCO
driver -> "no DCO" -> fallback).

With this patch, as it is, it will break on a DCO-in-kernel system if
built with --enable-dco, as half the functionality is missing - but on
any combination, it will fall back to non-DCO and that works.  For
"with DCO in kernel", I've tested this before sending the patch (on
top of the DCO tree).

For good measure, since this is touching non-linux code as well
(due to the extra argument to open_tun()) I've thrown it at the
rejuvenated buildbot army - thanks, Dirk! - and that one was happy too.

I have *not* tested the --mktun branch (trivial enough to stare at)
as we want to get rid of that functionality anyway.  Until then, it's
at least still working :-)

Your patch has been applied to the master branch.

commit 6a2fe47a482e270936bc1c9713fc55837b4551d5
Author: Antonio Quartulli
Date:   Thu Jul 21 20:24:25 2022 +0200

     dco: introduce open_tun_dco_generic() to open dynamic or fixed-name DCO devices

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220721182425.1569798-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24717.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


