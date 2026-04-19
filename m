Date: Sun, 19 Apr 2026 18:22:15 +0200 (CEST)
Message-Id: <202604191622.63JGMFcF063630@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260407094643.28090-1-gert@...1296...>
References: <20260407094643.28090-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: Change arguments to
 setenv_dns_option to avoid sign-compare warning
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

I was not exactly eager to apply this, because it changes so many lines,
and I foresee a patch to this code coming up "for master and 2.7" which
will then create havoc on merging... but maybe I'm just a pessimist.

Whatever, this code is fine (in the revised %zu version), and gets rid
of a few #ifdef/#pragmas, so moving ahead...  compile tested on linux
(as this is !WIN32).

Your patch has been applied to the master branch.

commit 7f870c0753eccece035f682f8ae43f082e9af805
Author: Frank Lichtenheld
Date:   Tue Apr 7 11:46:37 2026 +0200

     dns: Change arguments to setenv_dns_option to avoid sign-compare warning

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1558
     Message-Id: <20260407094643.28090-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36531.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


