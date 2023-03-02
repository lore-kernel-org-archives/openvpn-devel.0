Date: Thu, 2 Mar 2023 18:37:54 +0100 (CET)
Message-Id: <202303021737.322HbsBq003070@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230301091848.80760-1-kprovost@...2661...>
References: <20230301091848.80760-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: improve FreeBSD DCO
 check
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

Thanks for spotting & fixing this, and apologies for still
not having a FreeBSD 14 buildslave.

Indeed, the existing configure.ac hard breaks my FreeBSD 14 setup
(which I didn't look at for a while, "because it works")...

   checking for nvlist_create in -lnv... no
   configure: WARNING: Name/Value pair library not found.
   configure: error: DCO support can't be enabled

(because "./configure --enable-dco" -> succeed or error out).

With "enable DCO on auto", the existing code does

   checking for nvlist_create in -lnv... no
   configure: WARNING: Name/Value pair library not found.
   configure: WARNING: DCO support disabled

and proceeds to build a binary with no DCO!

With this patch applied, "no arguments" or "--enable-dco" both
succeed...

   checking for net/if_ovpn.h... yes
   configure: Enabled ovpn-dco support for FreeBSD

on earlier FreeBSD versions (7.4), it just disables DCO, and
proceeds happily - as it should be.

   configure: WARNING: DCO header not found.
   configure: WARNING: DCO support disabled



Your patch has been applied to the master and release/2.6 branch.

commit 6f261673dee26ae8cfdf58f77038098d4f81d84a (master)
commit 86fb085b6d2582916ef59b4bd8bd5e4a072964a3 (release/2.6)
Author: Kristof Provost
Date:   Wed Mar 1 10:18:48 2023 +0100

     configure: improve FreeBSD DCO check

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230301091848.80760-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26314.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


