Date: Fri, 13 May 2022 09:23:22 +0200 (CEST)
Message-Id: <202205130723.24D7NM3p093596@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220512121429.2096164-3-arne@...1227...>
References: <20220512121429.2096164-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow loading of non default
 providers
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

This makes client tests using old certs (SHA1) or ciphers (BF-CBC) succeed
again, provided "--providers legacy default" and "tls-cert-profile insecure"
is added - where appropriate.

"make check" still fails (with 3.0.x), as "openvpn --show-ciphers" still shows
everything, no matter if loaded or not.  This is addressed in 6/7.

Moved the "Changes.rst" addition to "changes in 2.5.7" :-)

Your patch has been applied to the release/2.5 branch.

commit aef0e595132bd75b0a089e0536c7f910667f1c07
Author: Arne Schwabe
Date:   Thu May 12 14:14:24 2022 +0200

     Allow loading of non default providers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220512121429.2096164-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24327.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


