Date: Wed, 27 Jul 2022 20:22:38 +0200 (CEST)
Message-Id: <202207271822.26RIMcSq046164@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220726083313.14067-1-frank@...2641...>
References: <20220726083313.14067-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: systemd: remove generated
 service files on clean
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

Can't pass the chance to apply something that says "remove systemd" while
David is not looking...

Joke aside, this seems to be a straightforward "make sure generated stuff
is cleaned on 'make clean'" thing :-) - I have not tested it in earnest,
though, as none of my primary Linuxes have systemd.

Your patch has been applied to the master branch.

commit 3fb5665ec5b70b665c0a8094de20042be0e392de
Author: Frank Lichtenheld
Date:   Tue Jul 26 10:33:13 2022 +0200

     systemd: remove generated service files on clean

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220726083313.14067-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24740.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


