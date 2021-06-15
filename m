Date: Tue, 15 Jun 2021 13:55:31 +0200 (CEST)
Message-Id: <202106151155.15FBtVem027824@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210602034253.19984-2-selva.nair@...277...>
References: <20210602034253.19984-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve documentation of
 AUTH_PENDING related directives
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

I have fixed the yoda speak as requested.  On the "proxy_url" question,
the bikeshed painting committee had long and intense deliberations last
week, and decided that nobody really feels like deciding whether to
paint this blue or green... so I left the spelling "as it is", with "_".

(Pulling this patch into 2.5 created an impressive conflict, as it
pulls in the documentation part of 3f8fb2b2c1d6, which never made it
to 2.5 - fixing this, we now have identical doc/management-notes.txt
in release/2.5 and master.  If this is not correct due to missing code 
capabilities, we might need to revisit 2.5 here)

commit e0f860f4b38e60c2e1ce7b069f7c6c923c52e5ca (master)
commit d6ec7547198584e6053a177fbc017ffb11c16071 (release/2.5)
Author: Selva Nair
Date:   Tue Jun 1 23:42:52 2021 -0400

     Improve documentation of AUTH_PENDING related directives

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210602034253.19984-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22475.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


