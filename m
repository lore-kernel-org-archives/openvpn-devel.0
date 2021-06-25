Date: Fri, 25 Jun 2021 17:37:13 +0200 (CEST)
Message-Id: <202106251537.15PFbD4R002133@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210520151148.2565578-5-arne@...1227...>
References: <20210520151148.2565578-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extracting key_state deferred
 auth status update into function
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at the code - it's "just moving code", though the part about
"where does the KS_AUTH_DEFERRED come from?" needs a bit more digging.

The new code is slightly ugly - it's the old if/else deep nesting 
style, with early returns intermixed (but keeping the old else branch,
so "yes, same code" is easier to see).  A followup patch might want to
refactor this to "consistent early return style".


Tested on the server side test rig (all OK), including deferred auth
by plugin and by script.

I have adjusted the "now >= ks->auth_deferred_expire" clause as 
instructed and agreed on IRC, and killed a blank line.

Your patch has been applied to the master branch.

commit e55bedd4ea435f95d288e60691abc6e53b8bf014
Author: Arne Schwabe
Date:   Thu May 20 17:11:44 2021 +0200

     Extracting key_state deferred auth status update into function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210520151148.2565578-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22420.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


