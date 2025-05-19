Date: Mon, 19 May 2025 16:41:00 +0200 (CEST)
Message-Id: <202505191441.54JEf0aA087529@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250519143550.21761-1-gert@...1296...>
References: <20250519143550.21761-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Doxygen: Fix missing parameter
 warnings
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

Thanks. Documentation improvements are always good :-)

As for the readers that wonder what v5..v6 was about - rebase, context
changed in tls_crypt.h, and "git am" did not know what to do with it,
while "git rebase" and gerrit handled it just fine...  sorry for the
extra noise on the list.

Your patch has been applied to the master branch.

commit d2b59d6db2ee11f3875257b854e0b77265389f2c
Author: Frank Lichtenheld
Date:   Mon May 19 16:35:44 2025 +0200

     Doxygen: Fix missing parameter warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250519143550.21761-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31712.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


