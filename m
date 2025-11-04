Date: Tue, 4 Nov 2025 10:11:07 +0100 (CET)
Message-Id: <202511040911.5A49B7vN042150@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251104085553.8218-1-gert@...1296...>
References: <20251104085553.8218-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE server: update
 reporting_addr after ifconfig update
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

I have tested this in the scenario I observed when opening #889, and it
now works (push-update-cid <n> "ifconfig ..." and then the new IP/IPv6 
address shows up in "status 3" as well).

Thanks :-)

Your patch has been applied to the master branch.

commit 38e9dd636d115affeb4ec519108978058e4d05a1
Author: Marco Baffo
Date:   Tue Nov 4 09:55:47 2025 +0100

     PUSH_UPDATE server: update reporting_addr after ifconfig update

     Signed-off-by: Marco Baffo <marco@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1340
     Message-Id: <20251104085553.8218-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34186.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


