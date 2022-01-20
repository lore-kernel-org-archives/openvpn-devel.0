Date: Thu, 20 Jan 2022 16:42:44 +0100 (CET)
Message-Id: <202201201542.20KFgiuL002531@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-11-selva.nair@...277...>
References: <20211214165928.30676-11-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Respect algorithm support
 announced by management client
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Glanced a bit at the code and compile-tested on 3.0.1 - looks 
straightforward enough :-) (and yes to the comment about "such
a check would be appropriate always", but I'm leaning more to 
"drop support for OpenSSL < 3.0.1 for external-key features" :-) ).

Your patch has been applied to the master branch.

commit 43de9f547d70cab2eb3e4478bf975e139ad966f7
Author: Selva Nair
Date:   Tue Dec 14 11:59:20 2021 -0500

     Respect algorithm support announced by management client

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-11-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23441.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


