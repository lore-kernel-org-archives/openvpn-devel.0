Date: Tue, 13 Aug 2024 08:33:45 +0200 (CEST)
Message-Id: <202408130633.47D6Xjiv082386@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240812232158.3776869-1-selva.nair@...277...>
References: <20240812232158.3776869-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_pkcs11.c: set file offset
 to 0 after ftruncate
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

Acked-by: Gert Doering <gert@...1296...>

"explanation makes sense, man ftruncate clearly says 'fd is not modified'"

smoke tested ("make check") on linux with --enable-pkcs11

Your patch has been applied to the master branch.

Not applied to 2.6 because the code in question does not exist there.

commit dcf735009c8caabf5e4a9feeb0d32907aafe8f17 (master)
Author: Selva Nair
Date:   Mon Aug 12 19:21:58 2024 -0400

     test_pkcs11.c: set file offset to 0 after ftruncate

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240812232158.3776869-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29010.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


