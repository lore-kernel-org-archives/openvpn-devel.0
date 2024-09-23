Date: Mon, 23 Sep 2024 08:13:11 +0200 (CEST)
Message-Id: <202409230613.48N6DBDX007455@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240922203749.9802-1-gert@...1296...>
References: <20240922203749.9802-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move to common backend_driver
 type in struct tuntap
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

Stared-at-code, and fed to GHA to be sure I haven't overlooked anything
in the windows builds.  All the other platforms should be covered by gerrit
and the t_client tests (especially MacOS and utun).

Your patch has been applied to the master branch.

commit d8490738e64a5bbf00d6f08af03fef58f7488140 (master)
Author: Arne Schwabe
Date:   Sun Sep 22 22:37:49 2024 +0200

     Move to common backend_driver type in struct tuntap

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240922203749.9802-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29352.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


