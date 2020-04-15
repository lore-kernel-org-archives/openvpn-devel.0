Date: Wed, 15 Apr 2020 12:15:39 +0200 (CEST)
Message-Id: <202004151015.03FAFd2Z006340@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200328040858.16505-1-arne@...1227...>
References: <20200328040858.16505-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix OpenSSL 1.1.1 not using
 auto ecliptic curve selection
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

Your patch has been applied to the master and release/2.4 branch (bugfix).

I've changed the title from "ecliptic" to "elliptic" curves, though :)

Haven't tested, but have stared at the actual change and the surrounding
code a bit, and hope that we can remove 1.0.x support soon... :-)

commit d8ac887c6b1b57a1953ab62058b4aed5d8c11f65 (master)
commit 5ee76a8fab0411c7529c8da9f40ad386433d9a0c (release/2.4)
Author: Arne Schwabe
Date:   Sat Mar 28 05:08:58 2020 +0100

     Fix OpenSSL 1.1.1 not using auto ecliptic curve selection

     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200328040858.16505-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19630.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


