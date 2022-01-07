MIME-Version: 1.0
References: <CAFHpkQFwUh6tHLQjjTs02H9qTZc2iwLKG2xcq==JDYdD_+aQwg@...278...>
 <20220107101708.100-1-lstipakov@...277...>
In-Reply-To: <20220107101708.100-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 7 Jan 2022 17:00:07 +0200
Message-ID: <CAGyAFMWmGM1SbuwnwOKNZnwZLm12tzu=2e0wg3uU0ay+XKLW+w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] msvc: mark x64 release binaries as
 compatible with CET shadow stack
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

Please disregard this patch,

I've sent two separate ones for 2.5 and master which fix multiple
issues found by binskim, including HW-enforced stack protection.

  https://patchwork.openvpn.net/patch/2209/
  https://patchwork.openvpn.net/patch/2210/

Note that before applying 2.5 patch, one needs to cherry-pick this commit

  https://github.com/openvpn/openvpn/commit/e5e9a07e8baee4065b7dfd65736bfa77b8329cfc

from the master.

-- 
-Lev

