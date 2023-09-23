Date: Sat, 23 Sep 2023 11:56:45 +0200 (CEST)
Message-Id: <202309230956.38N9ujqq054950@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230922160441.167168-1-frank@...2641...>
References: <20230922160441.167168-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: use memcpy in
 buf_catrunc
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Straightforward cherrypick, smoke tested on linux.

Your patch has been applied to the release/2.6 branch.

commit 946219115d00c6ae658afcf538249e721e6bd600 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Sep 22 18:04:41 2023 +0200

     buffer: use memcpy in buf_catrunc

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Acked-by: Heiko Hund <heiko@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230922160441.167168-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27085.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


