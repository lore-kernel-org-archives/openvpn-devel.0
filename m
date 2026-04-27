Date: Mon, 27 Apr 2026 17:11:59 +0200 (CEST)
Message-Id: <202604271511.63RFBxFs078611@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260421055357.21708-1-gert@...1296...>
References: <20260421055357.21708-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Mbed TLS: Error out if we have
 no valid tls-groups
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
To: Max Fillinger <maximilian.fillinger@...2918...>
Cc: openvpn-devel@lists.sourceforge.net

Haven't tested this, but the change is quite obvious, and it's only
error handling in a particular niche case, so "reasonably safe".

Your patch has been applied to the master branch.

I'm not sure we need or want this in release/2.7 - you or Arne tell me ;-)

commit b2e3e0f0cf21a712b96efb8c053b740ca1947f54 (master)
Author: Max Fillinger
Date:   Tue Apr 21 07:53:50 2026 +0200

     Mbed TLS: Error out if we have no valid tls-groups

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1633
     Message-Id: <20260421055357.21708-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36699.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


