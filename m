Date: Fri, 13 May 2022 09:23:20 +0200 (CEST)
Message-Id: <202205130723.24D7NKvj093581@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220512121429.2096164-2-arne@...1227...>
References: <20220512121429.2096164-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor early initialisation
 and uninitialisation into methods
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

Trivial.  Usually we wouldn't do refactoring in 2.5, but we decided we
want (must have, *sigh*) better OpenSSL support because Linux distributions
have started shipping "openvpn 2.5.x with openssl 3.0.x", and that is
not a good experience without this patchset.

"make check" tested on FreeBSD with 3.0.x - fails in the expected
places (engine test, no BF-CBC, no support for MD5/SHA1 certs)

Testing cipher BF-CBC... FAILED
Testing cipher DES-OFB... FAILED

Your patch has been applied to the release/2.5 branch.

commit 3f25bf7f7c1f32c2d3ef5b52443c97553a6c8977
Author: Arne Schwabe
Date:   Thu May 12 14:14:23 2022 +0200

     Refactor early initialisation and uninitialisation into methods

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220512121429.2096164-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24328.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


