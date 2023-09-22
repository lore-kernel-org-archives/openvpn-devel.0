Date: Fri, 22 Sep 2023 14:39:05 +0200 (CEST)
Message-Id: <202309221239.38MCd5V8032368@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230922103830.37151-1-frank@...2641...>
References: <20230922103830.37151-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --no-replay option
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

Given that people are supposed to use AEAD ciphers, and this was
incompatible all along, time to rip it out.  Yes, someone will complain,
but there is no way around that....

Subjected to my torture chamber, for good measure :-)

Your patch has been applied to the master branch.

commit 6d76218dd68dfa930d98f1cc7dcdc59c3bfbf5ce (master)
Author: Frank Lichtenheld
Date:   Fri Sep 22 12:38:30 2023 +0200

     Remove --no-replay option

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Heiko Hund <heiko@...515...>
     Message-Id: <20230922103830.37151-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27059.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


