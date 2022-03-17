Date: Thu, 17 Mar 2022 09:24:43 +0100 (CET)
Message-Id: <202203170824.22H8OhLb053250@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220316135411.217-1-lstipakov@...277...>
References: <20220316135411.217-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports\pkcs11-helper:
 shorten patch filename
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

Tested on "master" and "release/2.5", make dist now proceeds without
error, and the file is contained in the tarball.

"tar" changed to "tar -o", makes sense.

Your patch has been applied to the master and release/2.5 branch.

commit 2047522286f179cac09bd7615bf845d67a5dc1c8 (master)
commit 6aba9e8854155a8b8e9628a1184f3c13a8031688 (release/2.5)
Author: Lev Stipakov
Date:   Wed Mar 16 15:54:11 2022 +0200

     vcpkg-ports\pkcs11-helper: shorten patch filename

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220316135411.217-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23977.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


