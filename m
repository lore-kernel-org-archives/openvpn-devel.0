Date: Wed, 13 May 2020 17:24:33 +0200 (CEST)
Message-Id: <202005131524.04DFOXFu091917@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200513141147.17171-1-gert@...1296...>
References: <20200513141147.17171-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change client side of
 t_lpback.sh configs to use inline material.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch.

And I agree with Antinio here - we need a bit more test coverage in this
section, which is actually fairly easy with the t_lpback approach (because
"without IP config", openvpn can happily talk to itself on all platforms,
not needing namespaces, dummynet, whatever). 

Maybe an extra set of config files with tls-crypt-v2, or running genkey 
first, and then using this...  any takers?

commit 6001784afd89c4e9d9d15cc9f2e84cec6bbe0e39
Author: Gert Doering
Date:   Wed May 13 16:11:47 2020 +0200

     Change client side of t_lpback.sh configs to use inline material.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200513141147.17171-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19883.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


