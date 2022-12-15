Date: Thu, 15 Dec 2022 09:04:18 +0100 (CET)
Message-Id: <202212150804.2BF84I9b045409@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221211191403.805-1-marc.becker@...2704...>
References: <20221211191403.805-1-marc.becker@...2704...>
Subject: [Openvpn-devel] [PATCH applied] Re: use new pkcs11-helper interface
 to add providers
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
To: Marc Becker via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

I have test compiled this on Gentoo with pkcs-helper-1.27.0-r1, and
"it compiled".  I'm aware that this is not actually excercising any
of the new code paths, but "stare at code" sees nothing explosive,
and I trust Selva's review.

Your patch has been applied to the master and release/2.6 branch.

commit 5954f03bb321a969ea6edbdd353e1dd4f61ac8f0 (master)
commit d0141344b0c21747ba18be64470236066da62f33 (release/2.6) 
Author: Marc Becker via Openvpn-devel
Date:   Sun Dec 11 20:14:03 2022 +0100

     use new pkcs11-helper interface to add providers

     Signed-off-by: Marc Becker <marc.becker@...2704...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20221211191403.805-1-marc.becker@...2704...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25643.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


