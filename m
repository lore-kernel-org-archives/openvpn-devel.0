Date: Wed, 21 Jul 2021 15:24:12 +0200 (CEST)
Message-Id: <202107211324.16LDOCiP072641@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210623183728.2565286-1-arne@...1227...>
References: <20210623183728.2565286-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix tls-cert-profile broken on
 OpenSSL 1.1+
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

The root cause is very obvious ("git grep HAVE_SSL_CTX_SET_SECURITY_LEVEL"),
and the fix seems logical.  OpenSSL documentation confirms that this
was "added in OpenSSL 1.1.0", so checking for 0x10100000L sounds like
the right way to do (one could argue about >=, but 1.1.0a would already
match)

I have tested against 1.0.2 (builds, refuses the option) and 1.1.1k
(builds and now accepts the option again, and being really strict
with "preferred" or "suiteb", refuses my SHA1 test certs)

Your patch has been applied to the master branch.

commit b66701e5e2ef194f33e2a8865a4abf4567466d83
Author: Arne Schwabe
Date:   Wed Jun 23 20:37:28 2021 +0200

     Fix tls-cert-profile broken on OpenSSL 1.1+

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210623183728.2565286-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22584.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


