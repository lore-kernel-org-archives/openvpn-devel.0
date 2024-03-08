Date: Fri, 8 Mar 2024 12:24:30 +0100 (CET)
Message-Id: <202403081124.428BOUd2015466@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240307124616.16358-1-gert@...1296...>
References: <20240307124616.16358-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Minor fix to process_ip_header
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Verified ("git show -w") that this is indeed just removing one level of 
indentation + ICMP spelling fixes (good catch).

Given the sequence of checks, this ordering is indeed a bit more costly
for the "no PIP bits are set" (as is_ipv4() has to do more checking than
"are we interested in this at all?") - but since we basically always
default to having MSSFIX active, this is a bit moot.

For good measure, subjected to GHA and server side test run.

Your patch has been applied to the master branch.

commit 6456d861f3f1006ccee0a7f94a159f4afe1d3178
Author: Gianmarco De Gregori
Date:   Thu Mar 7 13:46:16 2024 +0100

     Minor fix to process_ip_header

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240307124616.16358-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28345.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


