Date: Mon, 9 Sep 2024 09:20:38 +0200 (CEST)
Message-Id: <202409090720.4897KcQa049213@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240708210912.566-2-chipitsine@...277...>
References: <20240708210912.566-2-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: src/openvpn/init.c: handle
 strdup failures
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
To: Ilia Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Taken the "patchset looks great" from Antonio as ACK, fixed the 
"msg( M_FATAL," space on the go (trivial whitespace fixes are
acceptable).

Not tested beyond minimal compile test and stare-at-code.

Your patch has been applied to the master branch.

commit b7c6920eab5d56067a69805f64239b8dd5a0ae27
Author: Ilia Shipitsin
Date:   Mon Jul 8 23:08:18 2024 +0200

     src/openvpn/init.c: handle strdup failures

     Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240708210912.566-2-chipitsine@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28884.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


