Date: Sat, 24 Oct 2020 21:47:21 +0200 (CEST)
Message-Id: <202010241947.09OJlL3Q087137@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023113431.26691-3-arne@...1227...>
References: <20201023113431.26691-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Align reliable_free with other
 free methods to accept NULL
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

Acked-by: Gert Doering <gert@...1296...>

Change brings this more in line with other code parts, so easier
to understand.

Your patch has been applied to the master branch.

commit 2c8a9877617727438cdd874ecd38c04adebf53ad
Author: Arne Schwabe
Date:   Fri Oct 23 13:34:29 2020 +0200

     Align reliable_free with other free methods to accept NULL

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023113431.26691-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21215.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


