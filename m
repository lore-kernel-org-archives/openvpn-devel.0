Date: Wed, 17 May 2023 19:16:00 +0200 (CEST)
Message-Id: <202305171716.34HHG005076961@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230517113619.82808-1-frank@...2641...>
References: <20230517113619.82808-1-frank@...2641...>
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

Acked-by: Gert Doering <gert@...1296...>

Change looks good (less +/-1, so easier for my old brain), and our nice
and shiny new unit test confirms that things still work.

Your patch has been applied to the master branch.

commit c89a97e449baaf60924a362555d35184f188a646
Author: Frank Lichtenheld
Date:   Wed May 17 13:36:19 2023 +0200

     buffer: use memcpy in buf_catrunc

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230517113619.82808-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26683.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


