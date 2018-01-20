Date: Sat, 20 Jan 2018 12:12:20 +0100 (CET)
Message-Id: <201801201112.w0KBCK3J017947@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180119212721.25177-1-steffan@...1856...>
References: <20180119212721.25177-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have added a pointer to the Debian bug report for completeness.

commit 0e8a30c0b05c1e2b59a1dea0a6eab5daa1d9d9a1
Author: Steffan Karger
Date:   Fri Jan 19 22:27:21 2018 +0100

     Fix --tls-version-min and --tls-version-max for OpenSSL 1.1+

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20180119212721.25177-1-steffan@...1856...>
     URL: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=873302
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16284.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


