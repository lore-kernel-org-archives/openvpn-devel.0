Date: Wed, 5 Jun 2024 13:10:39 +0200 (CEST)
Message-Id: <202406051110.455BAdLn000757@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240604211708.32315-1-gert@...1296...>
References: <20240604211708.32315-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: LZO: do not use lzoutils.h
 macros
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Lightly tested via local builds and GHA.  This is basically a no-op,
as lzoutils.h contains

  #define lzo_malloc(a)       (malloc(a))
  #define lzo_free(a)         (free(a))

.. and nothing more complicated.  Having lzoutil.h out of the way paves
the way for "make lzo2.pc pkg-config checks work" :-)

Your patch has been applied to the master and release/2.6 branch
(I see this as "long-term compat" for building).

commit d601237976323b5d8f6ac65c27ccc510563ad75f (master)
commit 1ae753e4240434abda0a33aed07b289fa9c6ee79 (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Jun 4 23:17:08 2024 +0200

     LZO: do not use lzoutils.h macros

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240604211708.32315-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28705.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


