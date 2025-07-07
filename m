Date: Mon, 7 Jul 2025 16:19:23 +0200 (CEST)
Message-Id: <202507071419.567EJNXE037445@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250707133447.12404-1-gert@...1296...>
References: <20250707133447.12404-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Added PQE to WolfSSL
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
To: "rein.vanbaaren" <rein.vanbaaren@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

For anything non-wolfssl this is a no-op, so I did not test anything
(just verified that the buildbots agreed with the "it will not break
anything" assessment).  Arne tested :-)

git declared that it fixed 5 whitespace errors on commit -> "git show"
looks clean now.

Your patch has been applied to the master branch.

commit 1b133cce839f46902c9df32943646c3289c34889
Author: rein.vanbaaren
Date:   Mon Jul 7 15:34:39 2025 +0200

     Added PQE to WolfSSL

     Signed-off-by: comododragon <rein.vanbaaren@...1435...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250707133447.12404-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32043.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


