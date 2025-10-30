Date: Thu, 30 Oct 2025 22:05:55 +0100 (CET)
Message-Id: <202510302105.59UL5tRw026267@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030193003.348-1-gert@...1296...>
References: <20251030193003.348-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure that get_sigtype always
 return non-NULL
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

As the commit says, this is very unlikely to happen - but then, with custom
OpenSSL providers, or some of the semi-compatible OpenSSL variants, who
knows.  So having a sanity check here is good, and not very costly.

Your patch has been applied to the master branch.

commit 9fa32e66c9ec66ca05704f8e8b2fd9db7c711c50
Author: Arne Schwabe
Date:   Thu Oct 30 20:29:57 2025 +0100

     Ensure that get_sigtype always return non-NULL

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1325
     Message-Id: <20251030193003.348-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34060.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


