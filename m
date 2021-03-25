Date: Thu, 25 Mar 2021 12:43:05 +0100 (CET)
Message-Id: <202103251143.12PBh5Jk008789@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210324222330.455-4-arne@...1227...>
References: <20210324222330.455-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use correct types for OpenSSL
 and Windows APIs
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

Acked-by: Gert Doering <gert@...1296...>

"Because it makes sense".  The DWORD changes for the loop variables
confused me a bit, because these are not "passed to a windows API" - but 
they are *compared* to "i < rt->dwNumEntries", and since *that* is a
DWORD, I can see why it might warn.

Again, compile tested on MinGW, lightly client side tested on Linux
and FreeBSD.

Your patch has been applied to the master branch.

commit 467b16dc65df711c0f1b3a8640b1fadc09c56803
Author: Arne Schwabe
Date:   Wed Mar 24 23:23:30 2021 +0100

     Use correct types for OpenSSL and Windows APIs

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210324222330.455-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21803.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


