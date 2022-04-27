Date: Wed, 27 Apr 2022 18:01:21 +0200 (CEST)
Message-Id: <202204271601.23RG1LQ2024620@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422142953.3805364-7-arne@...1227...>
References: <20220422142953.3805364-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move CRL reload to
 key_state_init from S_START transition
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

Thanks, Antonio, for the detailed testing.  I already checked that 
"it's only code being moved" but since this is all magic event
driven functions, I found "verifying functionality" important here.

missing S-O-B added according to our developer docs.

Your patch has been applied to the master branch.

commit fb6e6c2ae3e6ecdc6ac0b69a79741d52189c0c70
Author: Arne Schwabe
Date:   Fri Apr 22 16:29:41 2022 +0200

     Move CRL reload to key_state_init from S_START transition

     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20220422142953.3805364-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24156.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


