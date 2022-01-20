Date: Thu, 20 Jan 2022 18:16:37 +0100 (CET)
Message-Id: <202201201716.20KHGbmF007817@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-16-selva.nair@...277...>
References: <20211214165928.30676-16-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable signing using CNG
 through xkey provider
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Compile-tested on Linux with OpenSSL 3.0.1, and on Ubuntu/MinGW
(though with older OpenSSL) to ensure it doesn't break windows builds.

Your patch has been applied to the master branch.

commit 7ae282ca23e5a17cd9f2eb4801deed64ca64c704
Author: Selva Nair
Date:   Tue Dec 14 11:59:25 2021 -0500

     Enable signing using CNG through xkey provider

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-16-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23444.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


