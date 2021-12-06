Date: Mon, 6 Dec 2021 17:44:21 +0100 (CET)
Message-Id: <202112061644.1B6GiLlt041453@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211206150852.3142891-1-arne@...1227...>
References: <20211206150852.3142891-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix handling an optional
 invalid cipher at the end of data-ciphers
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

Acked-by: Gert Doering <gert@...1296...>

Sorry for the chaos.  This indeed fixes the behaviour I saw on "1/9 v1"
(and it adds a test case!).  Thanks.

2021-12-06 17:43:08 Unsupported optional cipher in --data-ciphers: Vollbit
2021-12-06 17:43:08 Unsupported optional cipher in --data-ciphers: Littlebit
2021-12-06 17:43:08 Unsupported cipher in --data-ciphers: nixbit
Options error: --data-ciphers list contains unsupported ciphers or is too long.

(and vice versa, all combinations of optional/non-optional unsupported
do what one would expect now)

Your patch has been applied to the master branch.

commit 868433857fbf8d71515ac0ffecb98eae893515dc
Author: Arne Schwabe
Date:   Mon Dec 6 16:08:52 2021 +0100

     Fix handling an optional invalid cipher at the end of data-ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211206150852.3142891-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20211206150852.3142891-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


