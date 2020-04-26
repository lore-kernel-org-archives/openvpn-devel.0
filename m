Date: Sun, 26 Apr 2020 11:51:33 +0200 (CEST)
Message-Id: <202004260951.03Q9pXRS064959@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200420104435.7082-1-arne@...1227...>
References: <20200420104435.7082-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add tls-crypt-v2 test writing
 metadata
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

Your patch has been applied to the master branch.

Basic "make check" testing with cmocka on linux with openssl 1.1.1 and
mbedtls passed.

I have changed whitespaceing of the *new* lines, as instructed, but I
notice that this whole file is not according to coding conventions - so
it seems the last round of uncrustify patches overlooked the "tests/"
subdirectory.  Patch coming.

commit a17e73531404aeb9d26ef874d55e46754ec523ab (master)
Author: Arne Schwabe
Date:   Mon Apr 20 12:44:35 2020 +0200

     Add tls-crypt-v2 test writing metadata

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20200420104435.7082-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19798.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


