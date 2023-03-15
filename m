Date: Wed, 15 Mar 2023 17:52:08 +0100 (CET)
Message-Id: <202303151652.32FGq8pl049934@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230314122134.1248576-1-selva.nair@...277...>
References: <20230314122134.1248576-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Bugfix: Convert ECDSA signature
 form pkcs11-helper to DER encoded form
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

I do not understand these crypto intricacies, but I've stared a bit
at the code to understand the code-move-around, and "things look
reasonable".  The test beds agree (mingw, github), and most important,
Arne agrees :-)

Your patch has been applied to the master and release/2.6 branch.

commit b7cf18f750f2a020032e09b6c4184579896876ee (master) 
commit 1e954cefa0941439ca09598b6131203b975950f8 (release/2.6)
Author: Selva Nair
Date:   Tue Mar 14 08:21:34 2023 -0400

     Bugfix: Convert ECDSA signature form pkcs11-helper to DER encoded form

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230314122134.1248576-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26406.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


