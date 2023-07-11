Date: Tue, 11 Jul 2023 21:40:02 +0200 (CEST)
Message-Id: <202307111940.36BJe2rb060337@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230710112122.576-1-lstipakov@...277...>
References: <20230710112122.576-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: enclose DNS domain in
 single quotes in WMIC call
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this beyond "does it still compile?" (it does) - the
whole concept of "how do quotation marks work in windows, and when and
why do we need them?" is a bit fuzzy to me - but I fully trust Selva
and Lev on this.

On Selva's comment "do we need to sanitize this?" - I tried to figure
out how tt->options.domain is populated, and gave up - for "dhcp-option",
we start with o->domain, for "--dns" we start with something else, and
I couldn't find where this moves over to tt->options.domain, and whether
there is a check at this place.

In the "dhcp-option DOMAIN" block, we just do

        if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX"))
            && p[2] && !p[3])
        {
            o->domain = p[2];

.. so indeed, depending on how windows exec_command() "does things",
this might or might not be a problem.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 4057814a8a783d4fb1475f49f073f6b3a7797677 (master)
commit aceecaef79cd2dae5265e328874ee8263ac79492 (release/2.6)
Author: Lev Stipakov
Date:   Mon Jul 10 14:21:22 2023 +0300

     tun.c: enclose DNS domain in single quotes in WMIC call

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230710112122.576-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26841.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


