Date: Mon, 4 Mar 2019 20:01:22 +0100 (CET)
Message-Id: <201903041901.x24J1Mvf096273@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190225183531.27399-1-stefan.strogin@...277...>
References: <20190225183531.27399-1-stefan.strogin@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use correct ifdefs for LibreSSL
 support
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
To: Stefan Strogin <stefan.strogin@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.

Tested on OpenBSD 6.3 (haven't upgraded that box to 6.4 yet)...

OpenVPN 2.5_git [git:d2master/a47508606be2c635+] x86_64-unknown-openbsd6.3 [SSL (OpenSSL)] [LZO] [LZ4] [MH/RECVDA] [AEAD] built on Mar  4 2019
library versions: LibreSSL 2.7.2, LZO 2.10

.. and passed t_client tests.

Your patch has been applied to the master branch.

commit a47508606be2c6359d4b27c3b65b72dfe4786222
Author: Stefan Strogin
Date:   Mon Feb 25 20:35:31 2019 +0200

     Use correct ifdefs for LibreSSL support

     Signed-off-by: Stefan Strogin <stefan.strogin@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20190225183531.27399-1-stefan.strogin@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18239.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


