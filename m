Date: Thu, 15 Dec 2022 09:21:48 +0100 (CET)
Message-Id: <202212150821.2BF8Lmo0048290@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221211200108.1402-1-marc.becker@...2704...>
References: <20221211200108.1402-1-marc.becker@...2704...>
Subject: [Openvpn-devel] [PATCH applied] Re: special handling for PKCS11
 providers on win32
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
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this at all, as I do not have the necessary infrastructure.

It does not affect non-WIN32 builds, so what I'll do is to feed this +
the vcpkg patch to my github instance, so it can be tested for windows,
and only then push to the "real" repos.

Your patch has been applied to the master and release/2.6 branch.

commit e299b8d0d62a4763b20bf9a3bd6aadf414aa89fe (master)
commit 38993a110001b6134a803797a6b4b472ef3546db (release/2.6)
Author: Marc Becker
Date:   Sun Dec 11 21:01:08 2022 +0100

     special handling for PKCS11 providers on win32

     Signed-off-by: Marc Becker <marc.becker@...2704...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20221211200108.1402-1-marc.becker@...2704...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25646.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


