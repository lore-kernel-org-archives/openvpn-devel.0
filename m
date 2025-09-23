Date: Tue, 23 Sep 2025 11:15:16 +0200 (CEST)
Message-Id: <202509230915.58N9FGTB007819@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250922204158.23319-1-gert@...1296...>
References: <20250922204158.23319-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Fix -Wconversion warnings
 in pem_password_callback
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

Straightforward & does not break anything :-) (tested in a local build
with a profile with an encrypted private key)

Your patch has been applied to the master branch.

commit e256d668d6356cdb379bf7ceca1617ed7925d28e
Author: Frank Lichtenheld
Date:   Mon Sep 22 22:41:52 2025 +0200

     ssl: Fix -Wconversion warnings in pem_password_callback

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1137
     Message-Id: <20250922204158.23319-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33154.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


