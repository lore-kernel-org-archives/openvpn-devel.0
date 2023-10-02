Date: Mon, 2 Oct 2023 10:29:42 +0200 (CEST)
Message-Id: <202310020829.3928TgMA073534@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231001174920.54154-1-selva.nair@...277...>
References: <20231001174920.54154-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log OpenSSL errors on failure
 to set certificate
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Good error messages are always an improvement, and not going on after
a "cannot use this certificate" error is propably also a good idea
(so, change M_WARN to M_FATAL makes sense).

For the "test on many different OpenSSL versions and OSes" I have
subjected this to the GH builds and my local MinGW test, and all
succeeded.

Backporting to 2.6 was not fully automatic, had to manually skip
the patch to test_pkcs11.c (which does not exist in 2.6).

Your patch has been applied to the master and release/2.6 branch.

commit 2671dcb69837ae58b3303f11c1b6ba4cee8eea00 (master)
commit ebfa5f3811e92863a3bbcc53b7a3f1b29dff1bc1 (release/2.6)
Author: Selva Nair
Date:   Sun Oct 1 13:49:20 2023 -0400

     Log OpenSSL errors on failure to set certificate

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20231001174920.54154-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27122.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


