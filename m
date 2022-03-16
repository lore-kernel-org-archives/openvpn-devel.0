Date: Wed, 16 Mar 2022 09:39:41 +0100 (CET)
Message-Id: <202203160839.22G8dfkY031659@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220316080912.118-1-lstipakov@...277...>
References: <20220316080912.118-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports: add openssl 1.1.1n
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

As discussed on IRC, we need to build with the new security-fixed 1.1.1n
release, and vcpkg port is not there yet.  Somewhat annoying, we should 
find a better way to decouple "build" and "openvpn main repo" commits...

Your patch has been applied to the release/2.5 branch.

commit a560bfddc561dd3f27fe7b4ce07075942dea811e (release/2.5)
Author: Lev Stipakov
Date:   Wed Mar 16 10:09:12 2022 +0200

     vcpkg-ports: add openssl 1.1.1n

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220316080912.118-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23972.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


