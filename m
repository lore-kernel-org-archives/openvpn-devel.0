Date: Tue, 25 Nov 2025 10:02:01 +0100 (CET)
Message-Id: <202511250902.5AP92115072930@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251124183911.24851-1-gert@...1296...>
References: <20251124183911.24851-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Restrict access to the service
 pipe to SYSTEM and owner
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

Again, thanks for the 2.6 backport.  This one looks like a direct
cherrypick of commit 0a429cb1355 - which I didn't do since I did not
have the prior commit in my 2.6 tree.  Shouldn't have committed so
fast ;-)

Stared-at-code, compile tested by the BBs and with mingw/ubuntu24.04.

Your patch has been applied to the release/2.6 branch.

commit f41058420555e19fffcff9fa1fdb810e5a2f1585
Author: Selva Nair
Date:   Mon Nov 24 19:39:06 2025 +0100

     Restrict access to the service pipe to SYSTEM and owner

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1402
     Message-Id: <20251124183911.24851-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34656.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


