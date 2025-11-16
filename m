Date: Sun, 16 Nov 2025 23:06:42 +0100 (CET)
Message-Id: <202511162206.5AGM6gMR058313@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251104091940.10826-1-gert@...1296...>
References: <20251104091940.10826-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Clean up type handling in
 write_string()
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

The +2 is already a few days old, but it needed the prerequisites to
apply (due to the #pragma moving around).

Change still looks good, passes all BB tests, smoke test on Linux passed
as well.

Your patch has been applied to the master branch.

commit 2a4b12f5a732202be99c6f5412c23128126da3cc
Author: Frank Lichtenheld
Date:   Tue Nov 4 10:19:35 2025 +0100

     ssl: Clean up type handling in write_string()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1300
     Message-Id: <20251104091940.10826-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34191.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


