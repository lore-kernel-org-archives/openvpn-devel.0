Date: Tue, 26 Apr 2022 16:59:29 +0200 (CEST)
Message-Id: <202204261459.23QExTfd099794@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422142953.3805364-5-arne@...1227...>
References: <20220422142953.3805364-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move tls_process_state into its
 own function
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

ACK from Frankf, but I've done another stare-at-code and submitted
to server + client tests (all good).

Uncrustify complained about 2-3 minor things -> adjusted (so possibly
there might be conflicts later on).

Your patch has been applied to the master branch.

commit f1b002fb19cc99f1a527cf95b343b5f082b78045
Author: Arne Schwabe
Date:   Fri Apr 22 16:29:39 2022 +0200

     Move tls_process_state into its own function

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220422142953.3805364-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24157.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


