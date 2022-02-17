Date: Thu, 17 Feb 2022 15:59:39 +0100 (CET)
Message-Id: <202202171459.21HExdLT095121@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220216134227.147-1-lstipakov@...277...>
References: <20220216134227.147-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg: link lzo statically
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

That came out of the "shouldn't we simplify our build scripts to make
lz4 dynamic"... turns out that dynamic libs used by a single binary only
are particulary inefficient here.  Thus, going the other way :)

I have not tested this, just looked at it, and it looks reasonable
(and affects only .cmake stuff)

Your patch has been applied to the master branch.

commit cac1ebd859e9d60642d2375a2c0bdacac35ca12c (master)
commit eded6a32edcb7d4378140fcbf984fae4d8735029 (release/2.5)
Author: Lev Stipakov
Date:   Wed Feb 16 15:42:27 2022 +0200

     vcpkg: link lzo statically

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220216134227.147-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23807.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


