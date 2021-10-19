Date: Tue, 19 Oct 2021 15:54:21 +0200 (CEST)
Message-Id: <202110191354.19JDsLFd089266@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211015203847.465-1-lstipakov@...277...>
References: <20211015203847.465-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: GitHub Actions: use latest
 working lukka/run-vcpkg
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

This is 2.5 only - tested via GH in my repo, before pushing to the
official repo.  I have no idea what it does, but it does not affect
code... and it fixes the GH build errors we had before (so I can
proceed with merging and test building Selva's win/EC patches).

Your patch has been applied to the release/2.5 branch.

commit db1a72cc8bc7e0a4d6c70e103febb97fe69949b2
Author: Lev Stipakov
Date:   Fri Oct 15 23:38:47 2021 +0300

     GitHub Actions: use latest working lukka/run-vcpkg

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211015203847.465-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22959.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


