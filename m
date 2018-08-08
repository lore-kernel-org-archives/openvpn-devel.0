Date: Wed, 8 Aug 2018 09:27:41 +0200 (CEST)
Message-Id: <201808080727.w787Rfh5019999@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1533696271-21799-1-git-send-email-selva.nair@...277...>
References: <1533696271-21799-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Bump version of openvpn plugin
 argument structs to 5
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

Acked-by: Gert Doering <gert@...1296...>

"Because it makes sense" :-) - and of course I've tested that it
works - built a new plugin, ran with the previously-used openvpn
binary, and it nicely fails

AUTH-PAM: This plugin is incompatible with the running version of OpenVPN
Wed Aug  8 09:25:43 2018 us=345993 PLUGIN_INIT: plugin initialization function failed: /usr/local/lib/openvpn/plugins/openvpn-plugin-auth-pam.so
Wed Aug  8 09:25:43 2018 us=346142 Exiting due to fatal error


Your patch has been applied to the master and release/2.4 branch
(the plugin in 2.4 could do with v3structver = 4, but if we ever
backport the challenge patch it will bite us, so just declare "we 
want 5!" here).

commit da0a42ca98623487726162b8710690cd3d003a63 (master)
commit d8496285948b814d78ee4be6ded08ce02046f8ee (release/2.4)
Author: Selva Nair
Date:   Tue Aug 7 22:44:30 2018 -0400

     Bump version of openvpn plugin argument structs to 5

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1533696271-21799-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=1533696271-21799-1-git-send-email-selva.nair@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


