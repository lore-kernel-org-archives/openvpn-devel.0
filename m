Date: Fri, 12 Dec 2025 12:57:15 +0100 (CET)
Message-Id: <202512121157.5BCBvFgT008448@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251212100920.7671-1-gert@...1296...>
References: <20251212100920.7671-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Change limits for
 array_mult_safe
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

As discussed on IRC, this is a reasonable change - on 32bit platforms,
having a maximum allocation size of 4G-1 is no good, as that will always
fail (so why bother having that check at all).  1G seems well out of
range of what OpenVPN would ever need, but it *would* catch some program
parts asking for "2Gbyte" and then being surprised that malloc() fails...
(and provide a better FATAL message).

Not tested beyond "BB says it's all green".

Your patch has been applied to the master branch.

commit 2b8149a4fe0d73ea0bedf2e282188d55c8511c45
Author: Frank Lichtenheld
Date:   Fri Dec 12 11:09:14 2025 +0100

     buffer: Change limits for array_mult_safe

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1436
     Message-Id: <20251212100920.7671-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35044.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


