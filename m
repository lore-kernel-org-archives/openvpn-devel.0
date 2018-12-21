Date: Fri, 21 Dec 2018 11:06:14 +0100 (CET)
Message-Id: <201812211006.wBLA6E53070022@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <c042fd01f62d707477c37e0298e303f1@...2482...>
References: <c042fd01f62d707477c37e0298e303f1@...2482...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix error message when using
 RHEL init script
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
To: Richard van den Berg via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Whatever the future might bring for this script (like "going away in 
favour of systemd units"), this is a reasonable fix for now - never 
rely on shell variables to be non-empty in script comparisons.

Your patch has been applied to the master and release/2.4 branch.

As a side note: please use "git send-email" to avoid your patch getting
broken by your mail client (it was whitespace-massacred so needed manual
adjustment) and use "git commit -s" so we have a proper signed-off-by:
line.  No hard requirements for a mini-fix, but for the next and bigger
one you'll hopefully send one day :-)


commit 7e711035f12a25199c3a04193ee4e22e43930f6a (master)
commit d18fa4aab1b73074d71a4d8cbf894c73c689d2ec (release/2.4)
Author: Richard van den Berg via Openvpn-devel
Date:   Fri Dec 21 07:43:28 2018 +0100

     Fix error message when using RHEL init script

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <c042fd01f62d707477c37e0298e303f1@...2482...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18057.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


