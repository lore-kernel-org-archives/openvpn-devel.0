Date: Mon, 11 May 2026 19:12:13 +0200 (CEST)
Message-Id: <202605111712.64BHCDPG037261@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260508153458.13848-1-gert@...1296...>
References: <20260508153458.13848-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: Remove one useless if check
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

And indeed, cppcheck is right again... - best seen with "git show -w -U12"
(... I guess the outer clause was something like "DCO or wintun" at some
point in time...).

It's technically not even a bug just an ugly bit of code, so not backporting 
to release/2.7

Not tested.  Just stared at code, and at "buildbot all green"... *ahem*...
on Ubuntu, that is - the build fail on FreeBSD 14 is caused by 1675 v2,
and this one has not been pushed again.  t_client tested on FreeBSD :-)

Your patch has been applied to the master branch.

commit 1400926adada824973a3df001fdcc46f523d90ee
Author: Frank Lichtenheld
Date:   Fri May 8 17:34:53 2026 +0200

     tun: Remove one useless if check

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1677
     Message-Id: <20260508153458.13848-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36867.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


