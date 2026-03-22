Date: Sun, 22 Mar 2026 13:03:07 +0100 (CET)
Message-Id: <202603221203.62MC37DV052139@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260322111131.8251-1-gert@...1296...>
References: <20260322111131.8251-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use openssl_err_t typedef to
 deal with difference between TLS libraries
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

Looks reasonable, has ACK from Frank, and is so localized that it makes
sense to include this in 2.7 - "long term compatibility" things.

Lightly tested the 2.7 change on an linux/openssl build.

Your patch has been applied to the master and release/2.7 branch.

commit ee2af6655d1dae8b87d8128e2afeec4f5506d79b (master)
commit ca6c9a8886918ae85fe3295a920eace480aa3971 (release/2.7)
Author: Arne Schwabe
Date:   Sun Mar 22 12:11:15 2026 +0100

     Use openssl_err_t typedef to deal with difference between TLS libraries

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1578
     Message-Id: <20260322111131.8251-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36242.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


