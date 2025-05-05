Date: Mon, 5 May 2025 11:14:25 +0200 (CEST)
Message-Id: <202505050914.5459EPBF005988@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250505085722.28761-1-gert@...1296...>
References: <20250505085722.28761-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: Introduce new uAPIs
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

So, after quite a bit of discussion and a number of new issues opened
against backport and dco-net-next :-) - *this* patch is fine, as in,
client and server functionality work with the new in-kernel Linux DCO 
module now (tested via backport to Ubuntu 20.04).

There are some known issues left - the version number for the new
module is not printed (infrastructure missing on the other side, and
decisions need to be made) - and the kernel side is not playing nice
with t_client/3000 byte yet.  But this is not a userland issue, so
we merge this and now can do more intensive testing with in-kernel DCO.

HEADS UP
  - from now on, master/2.7 will only support "new Linux DCO"
    (module named "ovpn")
  - 2.6.x will only ever support "old DCO" (module named "ovpn-dco-v2")

both kernel modules can coexist (different namespace), so Linux distribution
maintainers can ship one or the other or both, to enable "the OpenVPN
version that they ship" to use "DCO in the kernel that they ship".


Your patch has been applied to the master branch.

commit b736e3fa983ec3c3125f7ba77689132fcec39a00
Author: Gianmarco De Gregori
Date:   Mon May 5 10:57:14 2025 +0200

     dco_linux: Introduce new uAPIs

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250505085722.28761-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31554.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


