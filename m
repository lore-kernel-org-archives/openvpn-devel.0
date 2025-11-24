Date: Mon, 24 Nov 2025 18:56:13 +0100 (CET)
Message-Id: <202511241756.5AOHuDKo042614@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251124165353.14923-1-gert@...1296...>
References: <20251124165353.14923-1-gert@...1296...>
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

This sort of windows stuff is somewhat beyond my understanding, but
"it looks good and useful" - and Lev has actually understood & tested
it, and +2'ed in gerrit (which gerrit then lost on pushing the v2 which
only changed a comment...).  Fixed here in the commit, recording Lev's ACK.

Test compiled on mingw/ubuntu24.04

Your patch has been applied to the master branch.

commit 0a429cb13557356ac14cc458de3b42e3e09f6c62
Author: Selva Nair
Date:   Mon Nov 24 17:53:47 2025 +0100

     Restrict access to the service pipe to SYSTEM and owner

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1397
     Message-Id: <20251124165353.14923-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34640.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


