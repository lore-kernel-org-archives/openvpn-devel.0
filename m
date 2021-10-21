Date: Thu, 21 Oct 2021 08:24:46 +0200 (CEST)
Message-Id: <202110210624.19L6Okf0035545@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-17-arne@...1227...>
References: <20211019183127.614175-17-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add message when decoding
 PKCS12 file fails.
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

"That was an easy one" :-) - error reporting is always useful, and
the code change is trivial enough.  Tested with "wrong password" only,
which now prints:

2021-10-21 08:24:01 OpenSSL: error:23076071:PKCS12 routines:PKCS12_parse:mac verify failure
2021-10-21 08:24:01 OpenSSL: error:23076071:PKCS12 routines:PKCS12_parse:mac verify failure
2021-10-21 08:24:01 Decoding PKCS12 failed. Probably wrong password or unsupported/legacy encryption
2021-10-21 08:24:01 SIGUSR1[soft,private-key-password-failure] received, process restarting

Your patch has been applied to the master branch.

commit 6ac4e63c577986ec11eae3519fe8516e8ca8ac0f
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:22 2021 +0200

     Add message when decoding PKCS12 file fails.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211019183127.614175-17-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23017.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


