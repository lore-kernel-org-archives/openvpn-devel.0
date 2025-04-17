Date: Thu, 17 Apr 2025 16:04:30 +0200 (CEST)
Message-Id: <202504171404.53HE4UNk051879@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250417134636.21279-1-gert@...1296...>
References: <20250417134636.21279-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_openssl.c: Prevent
 potential double-free
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

Not tested, as the offending code flow is quite obvious "in hindsight", and
making the pointer NULL after free() is a sufficient safeguard against
double free().  A slightly more readable construction could have used
to different "info" variables for the two different scopes, each with
its own individual free(), exactly one per variable... but that's a
larger change.

Your patch has been applied to the master branch.

Application to 2.6 and earlier is not needed, the offending code is new
(e9ad1b3 or 3512e8d).

commit f7aedca70e24e9a35f0cbd33d1aa708b4daf0055
Author: Lev Stipakov
Date:   Thu Apr 17 15:46:30 2025 +0200

     ssl_openssl.c: Prevent potential double-free

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Message-Id: <20250417134636.21279-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31478.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


