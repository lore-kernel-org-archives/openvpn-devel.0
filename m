Date: Sun, 1 Aug 2021 19:41:25 +0200 (CEST)
Message-Id: <202108011741.171HfPFk045977@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210628080832.510-1-lstipakov@...277...>
References: <20210628080832.510-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: contrib/vcpkg-ports: remove
 openssl port
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

Since we never wanted to maintain our own patch, this is welcome.

I have left out the hunk to .github/workflows/build.yaml, as that has
been superseded by commit de8871f86db.

(I have not tested this in any way, just looked at the patch to see
which files it modifies and whether those look halfway reasonable)

Your patch has been applied to the master branch.

commit 7e33127d566da6dc4e412c11a445be74a542729e
Author: Lev Stipakov
Date:   Mon Jun 28 11:08:32 2021 +0300

     contrib/vcpkg-ports: remove openssl port

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210628080832.510-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22616.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


