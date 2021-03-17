Date: Wed, 17 Mar 2021 20:04:55 +0100 (CET)
Message-Id: <202103171904.12HJ4tCN045486@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210312150629.57302-1-juliusz@...2525...>
References: <20210312150629.57302-1-juliusz@...2525...>
Subject: [Openvpn-devel] [PATCH applied] Re: EVP_DigestSignFinal siglen
 parameter correction
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
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Mildly tested on an OpenSSL 1.0.2u box, client side only.  Works :-)

commit 476990d41ad78ac4419a3743cdab55c85c41b041
Author: Juliusz Sosinowicz
Date:   Fri Mar 12 16:06:29 2021 +0100

     EVP_DigestSignFinal siglen parameter correction

     Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210312150629.57302-1-juliusz@...2525...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21663.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


