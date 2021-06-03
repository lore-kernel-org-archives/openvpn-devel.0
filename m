Date: Thu, 3 Jun 2021 16:38:33 +0200 (CEST)
Message-Id: <202106031438.153EcXEU057766@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210603123019.422644-1-matthias.andree@...68...>
References: <20210603123019.422644-1-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix SIGSEGV (NULL deref)
 receiving push echo
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
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is obviously correct, and in hindsight a very obvious bug - we
seemed to have focused too much on the documentation aspect of the
commit introducing the bug, and not enough on the code change...

Your patch has been applied to the master and release/2.5 branch.

commit 0033811e0215af76f469d78912c95a2f59813454 (master).
commit d6e21bed964109abaf4bf03a951dc2fc9b1d5c1f (release/2.5)
Author: Matthias Andree
Date:   Thu Jun 3 14:30:19 2021 +0200

     Fix SIGSEGV (NULL deref) receiving push echo

     Signed-off-by: Matthias Andree <matthias.andree@...68...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210603123019.422644-1-matthias.andree@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22486.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


