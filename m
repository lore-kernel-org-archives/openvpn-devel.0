Date: Wed, 17 Aug 2022 16:39:43 +0200 (CEST)
Message-Id: <202208171439.27HEdhtt040527@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220817135348.844178-1-arne@...1227...>
References: <20220817135348.844178-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix IV_PLAT_VER and UV_
 variables sent without push-peer-info
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

I have not tested this, but it's obvious enough from the changes in
said commit.

Your patch has been applied to the master branch.

commit e0dbe5c4e290c0c24a26a9e5c19957ebaca09543
Author: Arne Schwabe
Date:   Wed Aug 17 15:53:48 2022 +0200

     Fix IV_PLAT_VER and UV_ variables sent without push-peer-info

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220817135348.844178-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24956.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


