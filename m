Date: Tue, 22 Jan 2019 17:20:12 +0100 (CET)
Message-Id: <201901221620.x0MGKC9x045512@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1548164463-13366-1-git-send-email-lstipakov@...277...>
References: <1548164463-13366-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_openssl.c: fix
 heap-buffer-overflow found by AddressSanitizer
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

commit eb1fed3f3bb817332183672dd1ca665ece83d6a8
Author: Lev Stipakov
Date:   Tue Jan 22 15:41:03 2019 +0200

     crypto_openssl.c: fix heap-buffer-overflow found by AddressSanitizer

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1548164463-13366-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18141.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


