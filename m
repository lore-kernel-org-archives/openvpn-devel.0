Date: Wed, 27 Oct 2021 20:27:52 +0200 (CEST)
Message-Id: <202110271827.19RIRqvE028796@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-2-arne@...1227...>
References: <20211019183127.614175-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use new EVP_MAC API for HMAC
 implementation
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

I have lightly tested this ("make check" on 1.1.1 and 3.0.0 builds)
and it seems to do nicely.  Especially that we already merged the
HMAC test (unit_tests/test_crypto.c) gives confidence :-)

Your patch has been applied to the master branch.

commit 7865ffdcbc603894f268d892d638b111e8b61c36
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:07 2021 +0200

     Use new EVP_MAC API for HMAC implementation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23013.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


