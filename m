Date: Mon, 28 Sep 2020 12:25:08 +0200 (CEST)
Message-Id: <202009281025.08SAP8eg087998@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1601085886-10351-1-git-send-email-selva.nair@...277...>
References: <1601085886-10351-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set DNS Domain using iservice
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

Your patch has been applied to the master and release/2.5 branch.

I have not tested it, but at least test compiled on MinGW/Ubuntu 18.04,
and slightly stared at the code.  Whitespace fixed as instructed :-)

commit 70882f3e40df1c70c553b8c22c747b468d5a0dc7 (master)
commit 7d7bb0c9ba0594809a889798485c299e8973a24f (release/2.5)
Author: Selva Nair
Date:   Fri Sep 25 22:04:46 2020 -0400

     Set DNS Domain using iservice

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1601085886-10351-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21097.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


