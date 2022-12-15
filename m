Date: Thu, 15 Dec 2022 08:55:19 +0100 (CET)
Message-Id: <202212150755.2BF7tJge044122@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221211190913.190-1-marc.becker@...2704...>
References: <20221211190913.190-1-marc.becker@...2704...>
Subject: [Openvpn-devel] [PATCH applied] Re: unify code path for adding
 PKCS#11 providers
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

I do claim that I have no idea about pkcs11-helper, but this patch 
isn't *that* complex, just using the existing wrapper... but still
thanks to Frank for reviewing.  I have test compiled on Gentoo with 
"pkcs11-helper-1.27.0-r1", and "it compiled".

I *do* find this part a bit nonintuitive...

   pkcs11_addProvider( ..., cert_private ? TRUE : FALSE)

.. we have a bool, pass it to a bool, and evaluate it in tri-state, to
pass true, if the bool is true, and false, if it is not...  wat?


One day, someone should reformat the rest of pkcs11.c, though... this
stuff is outright ugly

    msg(
        M_INFO,
        "PKCS#11: Adding PKCS#11 provider '%s'",
        provider
        );

(but I'm aware that OpenVPN had this phase when every function call
needed to be distributed to the maximum number of lines possible...)


Your patch has been applied to the master and release/2.6 branch.

commit b08f8cbb2b92f3ee0eced39d11665befea3aec87 (master)
commit f1995ccca4c105e71728101bb719d235f5605b33 (release/2.6)
Author: Marc Becker via Openvpn-devel
Date:   Sun Dec 11 20:09:13 2022 +0100

     unify code path for adding PKCS#11 providers

     Signed-off-by: Marc Becker <marc.becker@...2704...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20221211190913.190-1-marc.becker@...2704...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25642.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


