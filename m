Date: Sat, 6 Dec 2025 23:38:09 +0100 (CET)
Message-Id: <202512062238.5B6Mc9ad033764@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251206205829.27254-1-gert@...1296...>
References: <20251206205829.27254-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: gracefully exit if
 certificate file is NULL
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested if I can reproduce the situation (like with an empty
inline <cert></cert> cert, or somehow via management interface) or if
this is caught further upstream - but this check looks quite reasonable,
and the BBs are fine with it.

Your patch has been applied to the master branch.

commit d7c7caa370ad1fff1cd222e2499a77ea792c8a0e
Author: Steffan Karger
Date:   Sat Dec 6 21:58:16 2025 +0100

     mbedtls: gracefully exit if certificate file is NULL

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1419
     Message-Id: <20251206205829.27254-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34864.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


