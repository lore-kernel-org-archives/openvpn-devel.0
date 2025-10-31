Date: Fri, 31 Oct 2025 10:49:34 +0100 (CET)
Message-Id: <202510310949.59V9nYod051935@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251031092427.19824-1-gert@...1296...>
References: <20251031092427.19824-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add -lpathcch for mingw32
 builds using autotools
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

Thanks for the quick fix.

I have tested this on Ubuntu 22.04 / x86_64-w64-mingw32, and it still
does not work (because there is no libpathcch.a).  Then I have tested on
Ubuntu 24.04.03, with the provided mingw-w64 (--host=x86_64-w64-mingw32)
and it compiles nicely again.

I have not actually tested the resulting binary, but usually this is not
where the different build systems run into problems.

I do assume that CMake building on 22.04 will now also fail - this is
something we do need to document in our release notes for rc1 and 2.7.0,
that "mingw builds now need 24.04".  But I think this is a reasonable
requirement - we did drop 20.04 at some point, for similar reasons, if
I recall correctly.

Your patch has been applied to the master branch.

(The whole "canonify patches" thing is not yet in 2.6, so when we backport
the one, we could just squash these two)

commit d5e6b72460af88c4d2820195d1a5df62358c41e1
Author: Selva Nair
Date:   Fri Oct 31 10:23:52 2025 +0100

     Add -lpathcch for mingw32 builds using autotools

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1334
     Message-Id: <20251031092427.19824-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34095.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


