Date: Wed, 9 Apr 2025 11:33:22 +0200 (CEST)
Message-Id: <202504090933.5399XMbW090388@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250402134546.3504-1-gert@...1296...>
References: <20250402134546.3504-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use USER_PASS_LEN instead of
 TLS_USERNAME_LEN for override-username
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

"Because it makes sense" :-) - haven't explicitly tested all the various
corner cases, but the important bits are quite obvious from stare-at-code.

ssl_verify_username_length() looks "new" but is just refactored from
existing in-function code for reuse.

Your patch has been applied to the master branch.

commit bb8f2e373cf5d6c4d4320694ddd14bb61d5756b3
Author: Arne Schwabe
Date:   Wed Apr 2 15:45:39 2025 +0200

     Use USER_PASS_LEN instead of TLS_USERNAME_LEN for override-username

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250402134546.3504-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31323.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


