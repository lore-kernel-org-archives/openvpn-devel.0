Date: Thu, 4 Dec 2025 16:01:35 +0100 (CET)
Message-Id: <202512041501.5B4F1ZYL028938@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251204134521.20025-1-gert@...1296...>
References: <20251204134521.20025-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix dco with null cipher being
 enabled without auth none
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

We know everything about corners inside corner cases!

But we also do them right!

I have not tested this for real - it's fairly trivial anyway, and it has
no memory leaks anymore :-) - the use case is "testing" or "I just need
a tunnel with a more dynamic endpoint than statically-configured GRE,
no crypto needed, and minimum overhead required".  Whether or not this is
a good idea is not addressed by the patch, and OpenVPN itself *will* print
a big fat warning when trying to do "cipher none".

Your patch has been applied to the master branch.

commit 4ff746ad87ca5aa7b2058c9332622fc86551c0c8
Author: Arne Schwabe
Date:   Thu Dec 4 14:45:16 2025 +0100

     Fix dco with null cipher being enabled without auth none

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1369
     Message-Id: <20251204134521.20025-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34847.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


