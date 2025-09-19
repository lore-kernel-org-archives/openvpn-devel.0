Date: Fri, 19 Sep 2025 09:40:34 +0200 (CEST)
Message-Id: <202509190740.58J7eYGJ015615@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250918173447.32466-1-gert@...1296...>
References: <20250918173447.32466-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Validate DNS domain name before
 powershell invocation
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

So, we received a report that our use of 'wmic.exe' is insafe and could
be exploited by a malicious server pushing a "suitable" DOMAIN - which
could not be reproduced by us or by the reporter.  So this was rejected
as "invalid report" and we did not assign a CVE number.

This said, at about the same time, we integrated a patch that replaces
use of 'wmic.exe' with a powershell command line (because MS is no longer
installing wmic.exe by default, and intents to activey remove it in 25H2)
- and it turns out that the powershell invocation was insecure against
malicious data sent by the server in a PUSH_REPLY.  This problematic code
is NOT in any released OpenVPN version (2.6.14 and 2.7_beta1 have wmic.exe),
so it doesn't get a CVE ID either (CNA rules).

This patch fixes this (before 2.6.15 release ;-) ) by introducing proper
positive-list validation of domain names used in powershell calls.  We
accept UTF8 encoded domain names (= all characters >= 0x80 are allowed),
because it's needed for some environments, and nothing in there translates
into a (power-)shell metacharacter.


Tested on a Win10 system I had around, with binaries built on Ubuntu 22.04
with MinGW.  Running OpenVPN from an elevated cmd prompt does

  "Failed to set DNS domain 'mooh.com'evil' beause it contains invalid
   characters"

Running via the iservice, I get an error in OpenVPN log

  "TUN: adding dns domain failed using service: Die Daten sind
   unzulässig..." (yeah, translations)

and one in Event Log

  "openvpnserv error:
   Failed to set DNS domain 'mooh.com'evil' because it contains invalid
   characters"

which is also how it should be.  With a valid domain, it still works :-)


Your patch has been applied to the release/2.6 branch.

(In master, the domain related code is sufficiently different to require
a separate patch)

commit 6c3afe508b15764eea4e5bdcbaed37c02c281d9a (release/2.6)
Author: Lev Stipakov
Date:   Thu Sep 18 19:34:40 2025 +0200

     Validate DNS domain name before powershell invocation

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1198
     Message-Id: <20250918173447.32466-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33071.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


