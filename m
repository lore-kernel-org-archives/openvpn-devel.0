Date: Mon, 20 Mar 2023 14:01:08 +0100 (CET)
Message-Id: <202303201301.32KD18AU062879@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230319075441.13021-1-info@...2666...>
References: <20230319075441.13021-1-info@...2666...>
Subject: [Openvpn-devel] [PATCH applied] Re: using OpenSSL3 API for EVP PKEY
 type name reporting
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
To: Michael Baentsch <info@...2666...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this extensively, just subjected to GH to compile and
run basic checks with OpenSSL 1.1.x and 3.0.x, and ran a few local tests
(Linux + OpenSSL 1.1.1).  This all passed.  Have not investigated how
to actually trigger these code lines.

Your patch has been applied to the master and release/2.6 branch.

commit 6c111be9b109a6dbcd39cac7821ea3dd78ff6adf (master)
commit a05ec70edd5178aac7b7432c57878c32aa838013 (release/2.6)
Author: Michael Baentsch
Date:   Sun Mar 19 08:54:41 2023 +0100

     using OpenSSL3 API for EVP PKEY type name reporting

     Signed-off-by: Michael Baentsch <info@...2666...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230319075441.13021-1-info@...2666...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26439.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


