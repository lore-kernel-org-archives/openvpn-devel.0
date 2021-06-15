Date: Tue, 15 Jun 2021 11:21:04 +0200 (CEST)
Message-Id: <202106150921.15F9L47L025472@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210607104213.216-1-lstipakov@...277...>
References: <20210607104213.216-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: contrib/vcpkg-ports: add
 pkcs11-helper port
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

The ACK is based on the discussion on the list for v1/v2 of the patch,
and the agreement to go this way - do a local port including this 
patch to pkcs11-helper, and as soon as upstream does a new release
with the patch, we get rid of it again.

This patch does not touch OpenVPN code, just build environment, and
looks reasonable enough (though I have not tested it and have no idea
if this is "best practice" or not).

Your patch has been applied to the master and release/2.5 branch.

commit 36b9aa0c1e40f3e4bd021b2fbd2a479ef148bc90 (master)
commit 73fbeed493c6320e0e93fc7569c5c22e3fe9413e (release/2.5)
Author: Lev Stipakov
Date:   Mon Jun 7 13:42:13 2021 +0300

     contrib/vcpkg-ports: add pkcs11-helper port

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210607104213.216-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22503.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


