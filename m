Date: Fri, 11 Nov 2022 09:23:56 +0100 (CET)
Message-Id: <202211110823.2AB8NuSH081230@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221109110749.1245175-1-arne@...1227...>
References: <20221109110749.1245175-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused addr_inet4or6,
 addr_guess_family and inline addr_copy_sa
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

My first thought was "trivial enough", the second thought was "oh wait"
- the old code copies "src->addr" to "dst->addr", while the new code copies
"src" to "dst".  Now, src/dst are "struct openvpn_sockaddr" here, which
is a struct containing only one member, "->addr" (which is a union) - so
the copying does the same thing, just with shorter source code lines.

Of course I have actually tested this :-) - the windows function has
only been compile tested (github actions, no errors) and the unix
function has been client-side tested with tests including TCP.

Your patch has been applied to the master branch.

commit 470d1d149aac162fac3390e7dcb29c2a9ea7dba4
Author: Arne Schwabe
Date:   Wed Nov 9 12:07:49 2022 +0100

     Remove unused addr_inet4or6, addr_guess_family and inline addr_copy_sa

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221109110749.1245175-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25493.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


