Date: Wed, 15 May 2024 13:40:25 +0200 (CEST)
Message-Id: <202405151140.44FBePPq041182@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240515100115.11056-1-gert@...1296...>
References: <20240515100115.11056-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove custom TLS 1.0 PRF
 implementation only used by LibreSSL/wolfSSL
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

Tested on the buildbots and on GHA, so does not break mbedtls/openssl
builds & self-tests anywhere.

Will break compat of LibreSSL/WolFSSL builds with pre-2.6 peers that
can not do TLS EKM.  Yes.

Your patch has been applied to the master branch.

commit 763b35f652b1913ddd01e6c548b3e6a57076ba42
Author: Arne Schwabe
Date:   Wed May 15 12:01:15 2024 +0200

     Remove custom TLS 1.0 PRF implementation only used by LibreSSL/wolfSSL

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240515100115.11056-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28672.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


