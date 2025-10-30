Date: Thu, 30 Oct 2025 21:58:24 +0100 (CET)
Message-Id: <202510302058.59UKwO1R025429@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030193940.1295-1-gert@...1296...>
References: <20251030193940.1295-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix
 key_state_gen_auth_control_files probably checking file creation
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

Yeah, trivial oversight, in the build-up to the rewritten async things 
handling for 2.6...  the consequences are not huge, as usually "all the
files fail" or "none", but still, this is the correct check.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 2f8cbf5bc95b80832c84b0396cb7851bf5a2c579 (master)
commit da394db7477300c79953c8b0da710f62698756b0 (release/2.6)
Author: Arne Schwabe
Date:   Thu Oct 30 20:39:34 2025 +0100

     fix key_state_gen_auth_control_files probably checking file creation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1327
     Message-Id: <20251030193940.1295-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34067.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


