Date: Wed, 14 May 2025 19:30:30 +0200 (CEST)
Message-Id: <202505141730.54EHUUPJ053411@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250514135334.14377-1-gert@...1296...>
References: <20250514135334.14377-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: apply settings via script
 on unixoid systems
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

At last!

I have stared long and hard at this code, and tried my best to break it
on various platform... and with v25, could no longer break it :-)

Tested on
  - FreeBSD 13 (openresolv script)
  - OpenBSD 7.6 + OpenSolaris (resolvconf_file script)
  - Gentoo + Debian "testing" (systemd-dns script, /etc/resolv.conf updating)
  - Ubuntu 20.04 (systemd-dns script, resolvectl part)

I have not found a Linux system with resolvconf, so that is not tested,
and I have not tested the more advanced systemd-dns/resolvectl features
(DoT, DoH, DNSSEC, different ports, split DNS - most of which are not
available on any other Unixoid system today).  There might be surprises
lurking.  More Linux+resolvectl testers welcome.

NOTE1: --dhcp-option DNS will *not* be passed to --dns-updown *yet*
       (upcoming in #904)

NOTE2: do not use this together with --user <nonroot>, as it will change
       your DNS config, and won't be able to restore it at openvpn end
       (feature added in upcoming #839).

Your patch has been applied to the master branch.

commit fef5c4b4e8d22dd1ffd7271c8f27d7a91ac4f47f
Author: Heiko Hund
Date:   Wed May 14 15:53:27 2025 +0200

     dns: apply settings via script on unixoid systems

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250514135334.14377-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31639.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


