Date: Wed, 5 Aug 2020 13:54:57 +0200 (CEST)
Message-Id: <202008051154.075Bsv9p086558@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200805102333.3109-1-themiron@...2010...>
References: <20200805102333.3109-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log serial number of revoked
 certificate
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have not done much testing, just a test run "make check" on an
OpenSSL and mbedTLS build.

I have not looked into applying it to "release/2.4" - if you think 
it's needed, let me know (or if it needs more work because the code
has diverged too much, send a 2.4 patch) - thanks.

commit 992e9cec40539a155afa9eae10502aa62f617965
Author: Vladislav Grishenko
Date:   Wed Aug 5 15:23:33 2020 +0500

     Log serial number of revoked certificate

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200805102333.3109-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20642.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


