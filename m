Date: Wed, 30 Nov 2022 12:59:00 +0100 (CET)
Message-Id: <202211301159.2AUBx007007056@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221130105609.662402-1-selva.nair@...277...>
References: <20221130105609.662402-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not add leading space to
 pushed options
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

Acked-by: Gert Doering <gert@...1296...>

"Trivial enough, when you have found the place" :-) - tested, confirmed.

Without:

2022-11-30 12:55:38 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'

With:

2022-11-30 12:57:42 PUSH: Received control message: 'PUSH_REPLY,auth-tokenSESS_ID'


Your patch has been applied to the master and release/2.5 branch
(not a "critical bug", but "fixing unintended behaviour", so: bugfix).

commit d0672e7a06437c730e27df645b9b9a5407b44ccf (master)
commit d682c77d5646466693991f0db797432fe5e09c95 (release/2.5)
Author: Selva Nair
Date:   Wed Nov 30 05:56:09 2022 -0500

     Do not add leading space to pushed options

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221130105609.662402-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25583.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


