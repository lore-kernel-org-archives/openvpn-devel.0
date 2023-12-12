Date: Tue, 12 Dec 2023 08:13:33 +0100 (CET)
Message-Id: <202312120713.3BC7DXL6072423@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231211170549.85749-1-frank@...2641...>
References: <20231211170549.85749-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix building mbed TLS with
 CMake and allow specifying custom directories
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

The cmake stuff, I have no idea what it is :-) - but GHA builds are fine
with it.  The mbedtls_compat.h change is mostly reordering the conditions
(and at least for the mbedtls version our GHA builds test against, it
seems to do the right thing).

Your patch has been applied to the master branch.

commit 8656b85c7324fc9ae7f10a9f37227a58766aae33
Author: Arne Schwabe
Date:   Mon Dec 11 18:05:49 2023 +0100

     Fix building mbed TLS with CMake and allow specifying custom directories

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231211170549.85749-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27763.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


