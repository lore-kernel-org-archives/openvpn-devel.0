Date: Wed, 10 Nov 2021 16:53:53 +0100 (CET)
Message-Id: <202111101553.1AAFrrgx040575@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-21-arne@...1227...>
References: <20211019183127.614175-21-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add macos OpenSSL 3.0 and ASAN
 builds
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

Since most of the bits and pieces are in now, and "make check" succeeds
(unless doing t_client tests with BF-CBC), we can reasonably add this
to the build matrix.  No code change, just GH action.

Your patch has been applied to the master branch.

commit 96f27a29cd4c95dadc16f3ba22876742f426d1c2
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:26 2021 +0200

     Add macos OpenSSL 3.0 and ASAN builds

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211019183127.614175-21-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23018.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


