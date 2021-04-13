Date: Tue, 13 Apr 2021 11:34:58 +0200 (CEST)
Message-Id: <202104130934.13D9YwiO052935@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210406162518.4075-5-arne@...1227...>
References: <20210406162518.4075-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove OpenSSL configure checks
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

Your patch has been applied to the master branch.

As instructed, I've uncrustified openssl_compat.h (which added the
"what is this about?" comment to the #endif in question).

Lightly tested on FreeBSD with 1.0.2u and Linux with 1.1.1j

commit bc36d9d569eb3b22abe66c19325f6f04b3c9e225
Author: Arne Schwabe
Date:   Tue Apr 6 18:25:18 2021 +0200

     Remove OpenSSL configure checks

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210406162518.4075-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22051.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


