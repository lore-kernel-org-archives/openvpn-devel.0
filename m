Date: Wed, 19 Nov 2025 14:31:03 +0100 (CET)
Message-Id: <202511191331.5AJDV3dv099951@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251119110231.13999-1-gert@...1296...>
References: <20251119110231.13999-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper: bump
 version to 1.31
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks, and sorry for missing that before 2.7_rc2 release.  Will be in rc3
(and 2.6.17).

Applied with "--whitespace=warn", as I remembered in time that the usual
"fix" would break diffs-to-patches where the existing context is from
upstream and has "non-conforming whitespace".

I have not tested this myself, just pushed to GHA and let it build things
for me (cmake builds on msbuild and mingw).

Your patch has been applied to the master and release/2.6 branch.

commit 3d0d4b1cf6c77f107af323e0ec81b0273c211867 (master)
commit 031fdbc7956f7912bedf161e79392811e44d3a44 (release/2.6)
Author: Selva Nair
Date:   Wed Nov 19 12:02:25 2025 +0100

     vcpkg-ports/pkcs11-helper: bump version to 1.31

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1368
     Message-Id: <20251119110231.13999-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34527.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


