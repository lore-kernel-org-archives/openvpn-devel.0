Date: Mon, 25 Mar 2024 17:43:25 +0100 (CET)
Message-Id: <202403251643.42PGhPW8042022@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240325125052.14135-1-gert@...1296...>
References: <20240325125052.14135-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use snprintf instead of sprintf
 for get_ssl_library_version
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

Your patch has been applied to the master and release/2.6 branch
(because this is good behaviour, even if we know there can not
be an overrun - today).

Tested on...

Linux, with "library versions: mbed TLS 2.28.7, LZO 2.10"
FreeBSD, with "library versions: mbed TLS 3.5.1, LZO 2.10"

commit 6a60d1bef424088df55f4d07efd45ce080fc7132 (master)
commit 11ca69cfac1c6d3ed34652650688a4b3c99573b0 (release/2.6)
Author: Arne Schwabe
Date:   Mon Mar 25 13:50:52 2024 +0100

     Use snprintf instead of sprintf for get_ssl_library_version

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240325125052.14135-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28458.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


