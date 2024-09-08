Date: Sun, 8 Sep 2024 15:05:42 +0200 (CEST)
Message-Id: <202409081305.488D5gwR067482@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240905100724.4105-1-gert@...1296...>
References: <20240905100724.4105-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: proxy.c: Clear sensitive data
 after use
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

Thanks for looking into this - and I agree with the conclusion on
keeping the scope of this patch to "purge this", not refactor the
overall code to get rid of that copy completely.
 
I have not tested this "for real" as I do not currently have a proxy
setup that requires authentication - just stared at the code, and run
the normal client->proxy tests (and nothing broke).

Your patch has been applied to the master and release/2.6 branch
(useful and fairly isolated change, adding a bit of hardening).

commit dbe7e456954bf001420c4552c2b6e184ec6e068c (master)
commit 534609a2a7f0dcd56c8eab764c9c9c99834dcc6f (release/2.6)
Author: Selva Nair
Date:   Thu Sep 5 12:07:24 2024 +0200

     proxy.c: Clear sensitive data after use

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240905100724.4105-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29061.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


