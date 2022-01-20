Date: Thu, 20 Jan 2022 16:28:10 +0100 (CET)
Message-Id: <202201201528.20KFSAtX000578@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-9-selva.nair@...277...>
References: <20211214165928.30676-9-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a function to encode
 digests with PKCS1 DigestInfo wrapper
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

Looked at the code, did client tests on 3.0.1, added a few spaces
in code like "if(nid == NID_undef)" :-)

As for the actual digest / encoding parts, no idea what that does,
but the code looks safe wrt memcpy(), length of things, etc.

Your patch has been applied to the master branch.

commit cf704eef472515e3d6469bd5377065a1378eb5c2
Author: Selva Nair
Date:   Tue Dec 14 11:59:18 2021 -0500

     Add a function to encode digests with PKCS1 DigestInfo wrapper

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-9-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23433.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


