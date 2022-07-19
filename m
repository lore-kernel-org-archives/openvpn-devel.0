Date: Tue, 19 Jul 2022 11:25:05 +0200 (CEST)
Message-Id: <202207190925.26J9P50G033957@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220718221757.545-1-a@...2181...>
References: <20220718221757.545-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: add option check - disable
 DCO if conflict is detected
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

Discussed this at length on IRC.  We put this in first (+08), so
*05* can go in without breaking non-DCO builds - because this one will
ensure "disable_dco" is set there.

Understanding the DCO and non-DCO code is a bit confusing - the whole
dco.c is #ifdef ENABLE_DCO, and dco_check_option_conflict() will
be a "static inline ... return false;" in that case - and the dco.h
bits of this came in via e34437c26b, so not obvious from this patch
how the pieces work together.

This said, I've thrown 07 v3 at the t_server test machinery (Gentoo,
with no "--enable-dco" at configure times) and it passed everything -
unsurprisingly, as the new code is not compiled in.

Testing with --enable-dco also caused no problems - this test basically
is a "will these parts compile correctly?" sanity check - the code
will detect "there is no DCO kernel support here" on my machine and
auto-disable DCO...

2022-07-19 11:06:31 Cannot find ovpn_dco netlink component: Object not found
2022-07-19 11:06:31 Note: Kernel support for ovpn-dco missing, disabling data channel offload.

On a machine *with* kernel support *and* --enable-dco, I assume this will
also do nothing (as open_tun() is not yet DCO'ed - that's 05).


I have only skimmed the actual option check - seems to make sense :-)
(and has an ACK from Arne, on 07 v1).

Whether the linux "fixed" check will work, we'll see after 05 is merged.


Your patch has been applied to the master branch.

commit 8989b0f2833d25c97654c25fa6a49d8fc0ef903d
Author: Antonio Quartulli
Date:   Tue Jul 19 00:17:57 2022 +0200

     dco: add option check - disable DCO if conflict is detected

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220718221757.545-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24701.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


