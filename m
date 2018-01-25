Date: Thu, 25 Jan 2018 14:56:39 +0100 (CET)
Message-Id: <201801251356.w0PDuddT094182@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1515959073-10376-2-git-send-email-selva.nair@...277...>
References: <1515959073-10376-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor ssl_openssl.c in prep
 for external EC key support
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

Your patch has been applied to the master branch.

For the time being, I've decided to follow the rule "refactoring and
new features go to master", and since this "refactoring in preparation
for a new feature" (EC external key), it falls under this rule.

If there's good arguments we should have it in 2.4, I won't stand in 
the way, though.

commit d59a1c2f488cc3f4725df1e053592d53c30cf0eb
Author: Selva Nair
Date:   Sun Jan 14 14:44:31 2018 -0500

     Refactor ssl_openssl.c in prep for external EC key support

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1515959073-10376-2-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16227.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


