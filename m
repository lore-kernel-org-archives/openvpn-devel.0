Date: Sat, 25 Feb 2023 18:01:41 +0100 (CET)
Message-Id: <202302251701.31PH1fCi078398@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230206130846.63415-1-frank@...2641...>
References: <20230206130846.63415-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: fix formatting of
 --disable-lz4 and --enable-comp-stub
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Makes sense".

Before:

  --disable-lzo           disable LZO compression support [default=yes]
  --disable-lz4           Disable LZ4 compression support
  --enable-comp-stub      Don't compile compression support but still allow limited interoperability with compression-enabled peers


After:

  --disable-lzo           disable LZO compression support [default=yes]
  --disable-lz4           disable LZ4 compression support [default=yes]
  --enable-comp-stub      disable compression support but still allow limited
                          interoperability with compression-enabled peers


("default=yes" is still confusing - does that mean "enabled by default" or
"disabled=yes by default"?, but that seems to be "the autoconf way")

Your patch has been applied to the master and release/2.6 branch.

commit 24e1d8ff87b189247d56261a9497b1f509b286df (master)
commit 91da6b9463745635b75df171678ab54b5dcdb0de (release/2.6)
Author: Frank Lichtenheld
Date:   Mon Feb 6 14:08:46 2023 +0100

     configure: fix formatting of --disable-lz4 and --enable-comp-stub

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230206130846.63415-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26156.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


