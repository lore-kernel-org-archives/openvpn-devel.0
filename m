Date: Tue, 11 Oct 2022 08:46:39 +0200 (CEST)
Message-Id: <202210110646.29B6kdg7077632@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221010155515.1687151-1-arne@...1227...>
References: <20221010155515.1687151-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure only CBC, CFB,
 OFB and AEAD ciphers are considered valid data ciphers
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

Just basic compile + t_client tested (which will excercise --ncp-ciphers
a bit, but not add any "unsupported optionals" today).

Your patch has been applied to the master branch.

commit 6bbd89c5c82e7a2366ecac969b35f88797a73763
Author: Arne Schwabe
Date:   Mon Oct 10 17:55:15 2022 +0200

     Ensure only CBC, CFB, OFB and AEAD ciphers are considered valid data ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20221010155515.1687151-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25379.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


