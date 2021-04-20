Date: Tue, 20 Apr 2021 13:13:48 +0200 (CEST)
Message-Id: <202104201113.13KBDmgG021016@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210415091248.18149-1-maximilian.fillinger@...2507...>
References: <20210415091248.18149-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: In init_ssl,
 open the correct CRL path pre-chroot
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Looking at the code change looks reasonable.

I have not tested this beyond a basic "it compiles with 2.5 as well" test.

Your patch has been applied to the master and release/2.5 branch (bugfix).

commit 21a0b2494e7f4f1c6325b2972743158acad4f394 (master)
commit d91c14e815820d04c022677722f6f096b88770d6 (HEAD -> release/2.5)
Author: Max Fillinger
Date:   Thu Apr 15 11:12:48 2021 +0200

     In init_ssl, open the correct CRL path pre-chroot

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210415091248.18149-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22117.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


