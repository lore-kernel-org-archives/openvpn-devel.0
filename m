Date: Wed, 18 Sep 2024 23:00:35 +0200 (CEST)
Message-Id: <202409182100.48IL0ZKe009277@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240918204551.2530-1-gert@...1296...>
References: <20240918204551.2530-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Review use of
 standard AC macros
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

I admit that I have no deep understanding of autoconf, but I did check
that "about everything" has more recent autoconf versions than 2.60
("the gold standard" has been 2.69 for many years) and that all our
buildbots and GHA are building fine with these changes.  Half of them
are typo fixes or whitespace cleanups anyway :-)

Your patch has been applied to the master branch.

commit b59620f24f5bc853e2aa92943f14abf74aa81511
Author: Frank Lichtenheld
Date:   Wed Sep 18 22:45:50 2024 +0200

     configure: Review use of standard AC macros

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240918204551.2530-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29321.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


