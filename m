Date: Mon, 6 May 2024 17:37:03 +0200 (CEST)
Message-Id: <202405061537.446Fb331073055@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240506142303.13198-1-gert@...1296...>
References: <20240506142303.13198-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Repeat the unknown command in
 errors from management interface
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

Not tested, but trivial enough, and the actual format of the ERROR:
message is not guaranteed so GUIs shouldn't be surprised if it
changes.

Your patch has been applied to the master branch.

commit b90a6e56250ccb18b4913bb115e5dcf4905dbfb1
Author: Arne Schwabe
Date:   Mon May 6 16:23:03 2024 +0200

     Repeat the unknown command in errors from management interface

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240506142303.13198-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28621.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


