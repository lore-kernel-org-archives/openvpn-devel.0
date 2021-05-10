Date: Mon, 10 May 2021 17:57:37 +0200 (CEST)
Message-Id: <202105101557.14AFvbud098718@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210507145644.195-1-lstipakov@...277...>
References: <20210507145644.195-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: add ARM64 configuration
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

I have no idea what these things do, but the new blocks look reasonably
similar to the existing XML, just with "ARM64".  No code changes.

And since Lev is the one who understands MSVC this is good enough for me :-)

Your patch has been applied to the master branch.

commit 8de7e643baefcb6a3000a3a89ae42ce1328a9a7d
Author: Lev Stipakov
Date:   Fri May 7 17:56:44 2021 +0300

     msvc: add ARM64 configuration

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210507145644.195-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22325.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


