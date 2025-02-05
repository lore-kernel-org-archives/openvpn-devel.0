Date: Wed, 5 Feb 2025 13:39:35 +0100 (CET)
Message-Id: <202502051239.515CdZhM085635@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250205122341.4944-1-gert@...1296...>
References: <20250205122341.4944-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: disable dco in server
 mode if multiple --local options defined
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

As discussed on IRC - this is a preliminary patch for making sure the
windows "multi-peer support in DCO" patchset and the "multi-socket patchset"
can cooperate peacefully, while win-dco has no multi-socket capability yet
(due to the way win-dco socket handling differs from linux-dco/freebsd-dco,
the challenges are different).

There is also a GH issue to clean up the confusing code around --local
and <connection> later... so we'll see more code changes here.

Your patch has been applied to the master branch.

commit 4719687ef3ec8acefcdde584df0e7fa86ddcf333
Author: Lev Stipakov
Date:   Wed Feb 5 13:23:41 2025 +0100

     dco-win: disable dco in server mode if multiple --local options defined

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250205122341.4944-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30805.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


