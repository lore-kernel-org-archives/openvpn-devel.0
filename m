Date: Fri, 5 Nov 2021 17:03:21 +0100 (CET)
Message-Id: <202111051603.1A5G3LIe086560@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211029112407.2004234-1-arne@...1227...>
References: <20211029112407.2004234-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add insecure tls-cert-profile
 options
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

(Client-side) tested with 1.1.1 and 3.0.0.

Without options, my sha1 certificates still fail for the 3.0.0 build,
and *with* "tls-cert-profile insecure" it works.

Your patch has been applied to the master branch.

commit 23efeb7a0bd9e0a6d997ae6e77e0e04170da3e67
Author: Arne Schwabe
Date:   Fri Oct 29 13:24:07 2021 +0200

     Add insecure tls-cert-profile options

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211029112407.2004234-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23076.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


