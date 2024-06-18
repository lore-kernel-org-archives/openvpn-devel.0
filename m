Date: Tue, 18 Jun 2024 18:30:05 +0200 (CEST)
Message-Id: <202406181630.45IGU5vu098122@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240618120219.5053-1-gert@...1296...>
References: <20240618120219.5053-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: Remove support for old
 TLS versions
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Mildly tested via GHA builds.

Not sure we want this in release/2.6 - I tend to "not", because it might
break someone's (non-recommended) setup...

Your patch has been applied to the master branch.

commit 013c119af96bc57c41e04e4a8f64b5d80e2e9ba6
Author: Max Fillinger
Date:   Tue Jun 18 14:02:19 2024 +0200

     mbedtls: Remove support for old TLS versions

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240618120219.5053-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28773.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


