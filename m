Date: Thu, 13 Feb 2020 20:54:18 +0100 (CET)
Message-Id: <202002131954.01DJsIrb090643@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1581519967-16950-1-git-send-email-selva.nair@...277...>
References: <1581519967-16950-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Skip expired certificates in
 Windows certificate store
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

Your patch has been applied to the master branch.

Haven't done any real testing, just test build on MinGW (to have "the
other build environment").  Passes :-)

commit 7b63984d51a2582ba2d406e46a7debb11df7f478
Author: Selva Nair
Date:   Wed Feb 12 10:06:06 2020 -0500

     Skip expired certificates in Windows certificate store

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1581519967-16950-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19404.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


