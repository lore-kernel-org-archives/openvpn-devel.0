Date: Wed, 29 Oct 2025 08:22:13 +0100 (CET)
Message-Id: <202510290722.59T7MDNM048860@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251029065316.10182-1-gert@...1296...>
References: <20251029065316.10182-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix logic when pushed cipher
 triggers tun reopen and ignore more options
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

So there was a bit of discussion about this in gerrit, and the logic is
confusing and twisted.  The tun device needs to reopened on a cipher
change *if* the tun-mtu ("ifconfig tun0 mtu 1400") could change - and
if the config has tun_mtu_defined, the tun MTU is fixed, so the cipher
could be ignored.  I think there are still funny edge cases (like
"no tun-mtu or link-mtu defined", what then?) and the check maybe should
be double-checked for "if (!opt->ce.link_mtu_defined)" - because
"link-mtu <set>" is the trigger for "tun mtu <calculated>", so in that
case we can't skip this.

OTOH, this is a small edge of an edge case, namely "cipher *change* upon
reconnect", which is rare enough - so for this to make a real difference
you need --user nobody or windows-dco (so "reopen tun" would fail) *and*
a cipher change.

I have changed the Reported-by:/Found-by: tags to look "like on the last
few commits", so it's consistent (basically adding URL and full name).

Your patch has been applied to the master branch.

commit 911a69dc1af20bc54557a208b6fd4e76261b2bb2
Author: Arne Schwabe
Date:   Wed Oct 29 07:53:10 2025 +0100

     Fix logic when pushed cipher triggers tun reopen and ignore more options

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1321
     Message-Id: <20251029065316.10182-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33989.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


