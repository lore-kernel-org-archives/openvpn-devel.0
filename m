Date: Tue, 23 Sep 2025 11:27:18 +0200 (CEST)
Message-Id: <202509230927.58N9RIhn008351@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250922204329.23460-1-gert@...1296...>
References: <20250922204329.23460-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify: Change
 backend_x509_* functions to size_t for lengths
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

Stared at code, very straightforward - matches callers and callees.

Not tested myself, relying on BB coverage.

Your patch has been applied to the master branch.

commit 38f2cedc60258d0dcb340873faa12e1de594e3c8
Author: Frank Lichtenheld
Date:   Mon Sep 22 22:43:23 2025 +0200

     ssl_verify: Change backend_x509_* functions to size_t for lengths

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1138
     Message-Id: <20250922204329.23460-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33152.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


