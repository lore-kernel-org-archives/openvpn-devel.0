Date: Thu, 21 Oct 2021 15:59:20 +0200 (CEST)
Message-Id: <202110211359.19LDxKDx052264@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-6-arne@...1227...>
References: <20211019183127.614175-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use EVP_PKEY based API for
 loading DH keys
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

Have no OpenSSL 3.0 based test environment yet - so, trusting MaxF's
tests here.  Just did compile + client test on 1.1.1

Your patch has been applied to the master branch.

commit 658c72e6e651437943f46a975751109759abd858
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:11 2021 +0200

     Use EVP_PKEY based API for loading DH keys

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23015.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


