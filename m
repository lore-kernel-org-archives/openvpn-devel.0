Date: Tue, 14 May 2024 18:50:33 +0200 (CEST)
Message-Id: <202405141650.44EGoX4u005860@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240514141550.17544-1-gert@...1296...>
References: <20240514141550.17544-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove OpenSSL 1.0.2 support
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

Looks good, tested on the buildbots (all pass, except those that do not
have anything more recent than 1.0.2 - and those will no longer be 
considered for building and testing "master") and on GHA.

Your patch has been applied to the master branch.

commit 51f80db910eb48e720ce106b5b9b5ec96d8e0e23
Author: Arne Schwabe
Date:   Tue May 14 16:15:50 2024 +0200

     Remove OpenSSL 1.0.2 support

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240514141550.17544-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28665.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


