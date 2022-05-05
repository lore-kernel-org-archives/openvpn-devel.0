Date: Thu, 5 May 2022 15:36:45 +0200 (CEST)
Message-Id: <202205051336.245DajQv040071@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220505124205.435-1-lstipakov@...277...>
References: <20220505124205.435-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg: switch to manifest
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

Not sure what this all does, but github likes it and builds nice things.

I should point out that vcpkg.json will not be contained in the 
"make dist" tarball (not mentioned in "Makefile.am"), so this is only 
benefiting people that build from git today.

Your patch has been applied to the release/2.5 branch.

commit 55cfc0b9541ff25fac31059ffcf7eea06fd6c0ec
Author: Lev Stipakov
Date:   Thu May 5 15:42:05 2022 +0300

     vcpkg: switch to manifest

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220505124205.435-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24286.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


