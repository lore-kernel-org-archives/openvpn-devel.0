Date: Sat, 30 Sep 2017 19:22:38 +0200 (CEST)
Message-Id: <201709301722.v8UHMcPr093789@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1505501175-9016-1-git-send-email-selva.nair@...277...>
References: <1505501175-9016-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check whether in pull_mode
 before warning about previous connection blocks
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

Thanks.  Small and to the point :-) (and though I trust Antonio's ACK,
I have quick-tested it and does what it says :) ).

Your patch has been applied to the master and release/2.4 branch.

commit 422ecdac4a2738cd269361e048468d8b58793c4e (master)
commit 90812e9879ba47ff0275f20efd653ae3381308b8 (release/2.4)
Author: Selva Nair
Date:   Fri Sep 15 14:46:15 2017 -0400

     Check whether in pull_mode before warning about previous connection blocks

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <1505501175-9016-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15452.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


