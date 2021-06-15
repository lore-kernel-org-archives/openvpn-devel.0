Date: Tue, 15 Jun 2021 15:27:28 +0200 (CEST)
Message-Id: <202106151327.15FDRSdV029284@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210615125616.344-1-lstipakov@...277...>
References: <20210615125616.344-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: GitHub actions: add MSVC build
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

Looks reasonable.  Getting more test coverage on MSVC is good.

Will this put build artefacts somewhere where people can download
and test MSVC builds?  Or is it "just openvpn.exe", but not a complete
installer?  The file looks like "*.exe and *.dll" (but at least this).

Where does it report compile errors to?

Your patch has been applied to the master and release/2.5 branch.

commit e007cc260edb0f24ad8f8468fbe7daf9efde85dc (master)
commit 1ca147bd716b4f756072c44fe7713f05f147bfc6 (release/2.5)
Author: Lev Stipakov
Date:   Tue Jun 15 15:56:16 2021 +0300

     GitHub actions: add MSVC build

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210615125616.344-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22556.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


