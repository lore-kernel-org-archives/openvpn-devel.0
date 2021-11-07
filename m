Date: Sun, 7 Nov 2021 20:25:59 +0100 (CET)
Message-Id: <202111071925.1A7JPx43050745@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211107090138.3150187-1-arne@...1227...>
References: <20211107090138.3150187-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Completely remove DES checks
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

Patch looks good, explanation makes sense, logical continuation of 
the process started with the "removal for 3.0.0".  All DES keys are
weak :-)

Lightly tested with OpenSSL 1.1.1 and mbedTLS builds (no actual *use*
of DES, though, besides "make check").

Your patch has been applied to the master branch.

commit 1325cf1198f78ccd8ab74394bb2e9b13f410ef20
Author: Arne Schwabe
Date:   Sun Nov 7 10:01:38 2021 +0100

     Completely remove DES checks

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211107090138.3150187-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23115.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


