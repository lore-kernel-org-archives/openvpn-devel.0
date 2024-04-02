Date: Tue, 2 Apr 2024 16:56:35 +0200 (CEST)
Message-Id: <202404021456.432EuZFs030160@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240402134909.6340-1-gert@...1296...>
References: <20240402134909.6340-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove/combine redundant call
 of EVP_CipherInit before EVP_CipherInit_Ex
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

Looking at the OpenSSL implementation for the EVP_CipherInit*() functions
makes it really clear that this is, basically, dead code.  Of course the
"kt" init needs to go to the second call now, because otherwise it will
bomb with OpenSSL 3.x ("no default cipher").

Tested with various OpenSSL (and LibreSSL) versions across the buildbot
and GHA test bed.

Your patch has been applied to the master branch.

(Not applied to release/2.6 since it's not actually fixing something,
just cleaning up old code - typical "master" material)

commit e81e3eb1a4322148b06f353eaa22b0a803fd74f4
Author: Arne Schwabe
Date:   Tue Apr 2 15:49:09 2024 +0200

     Remove/combine redundant call of EVP_CipherInit before EVP_CipherInit_Ex

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240402134909.6340-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28523.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


