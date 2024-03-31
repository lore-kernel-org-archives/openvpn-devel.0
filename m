Date: Sun, 31 Mar 2024 16:17:35 +0200 (CEST)
Message-Id: <202403311417.42VEHZx9028648@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240327162621.1792414-1-frank@...2641...>
References: <20240327162621.1792414-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_backend: fix type of enc
 parameter
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

Lightly tested on a FreeBSD/MbedTLS 2.28.7, resulting code still works :-)

Your patch has been applied to the master branch.

commit 4d907bf46a470ccbd2940b9ecb64d6502d9d86bf
Author: Frank Lichtenheld
Date:   Wed Mar 27 17:26:21 2024 +0100

     crypto_backend: fix type of enc parameter

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240327162621.1792414-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28498.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


