Date: Sat, 25 Feb 2023 16:59:10 +0100 (CET)
Message-Id: <202302251559.31PFxA6A076591@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230215162654.52137-1-frank@...2641...>
References: <20230215162654.52137-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: enable DCO by
 default on FreeBSD/Linux
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

This patch is identical to v3, except that it modifies the github 
actions to avoid GHA explosions on the linux workers.  So recording
Selva's and Antonio's ACKs of v3 here on v6.

Pushed to GHA and buildbots, all of them are happy now.

(We need to remember to add this to Changes.rst, as it might come as
a surprise to people upgrading 2.6.0 -> 2.6.1 and building from source)

Your patch has been applied to the master and release/2.6 branch.

commit 2a1a21e3da3ec66d901864edd7b3b0e2498b3b0a (master)
commit f63c9b1edbda41491ba2e05ff706bf0233903cb6 (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Feb 15 17:26:54 2023 +0100

     configure: enable DCO by default on FreeBSD/Linux

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230215162654.52137-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26272.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


