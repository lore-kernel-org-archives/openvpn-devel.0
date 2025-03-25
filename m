Date: Tue, 25 Mar 2025 22:22:59 +0100 (CET)
Message-Id: <202503252122.52PLMxoQ048355@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250325195750.7899-1-gert@...1296...>
References: <20250325195750.7899-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Mention address if not
 unspecific on DNS failure
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

Stared at it, and tested, and it's indeed quite useful (v3 had a stray
"%s" which is fixed in v4).

Without the patch, trying with "--local <v6 address>" + "--remote <v4only>"

    RESOLVE: Cannot resolve host address: v4only.v6.de:51194 (No address associated with hostname)

with the patch:

    RESOLVE: Cannot resolve host address: v4only.v6.de:51194[AF_INET6] (No address associated with hostname)

so when trying to diagnose user reports, this immediately points to
"mmmh, something is forcing v6 here, why?".

With no --local and no --proto udp4, nothing is forced, and thus:

    RESOLVE: Cannot resolve host address: nix.v6.de:51194 (Name or service not known)


Your patch has been applied to the master branch.

commit d16781531898b4c5a76cfe6cba02fccce9afb8ad
Author: Arne Schwabe
Date:   Tue Mar 25 20:57:43 2025 +0100

     Mention address if not unspecific on DNS failure

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250325195750.7899-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31237.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


