Date: Tue, 28 Apr 2026 15:56:26 +0200 (CEST)
Message-Id: <202604281356.63SDuQ6T008021@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260428124810.29709-1-gert@...1296...>
References: <20260428124810.29709-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix pkgcs11 vcpkg port
 installing debug files on release builds
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
To: Luis Cruz <luis.cruz@...3019...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for that contribution.  I have no idea about these build magics,
but Frank has, and has +2'ed the patch - so in it goes.

As this is not directly affecting code, I have not thoroughly stared at
it, and left the test building to buildbot (which seems to be happy).

Your patch has been applied to the master and release/2.7 branch
("bugfix" plus "keep build environments in sync").

commit 01d5562ed76cf889e19c0714d007eea77643bc68 (master)
commit 5a97413a9a8d1d0fabec5f680ce81a1388bf6c62 (release/2.7)
Author: Luis Cruz
Date:   Tue Apr 28 14:48:04 2026 +0200

     Fix pkgcs11 vcpkg port installing debug files on release builds

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1640
     Message-Id: <20260428124810.29709-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36762.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


