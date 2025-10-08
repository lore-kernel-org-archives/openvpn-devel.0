Date: Wed, 8 Oct 2025 18:12:17 +0200 (CEST)
Message-Id: <202510081612.598GCHKP093421@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250926111726.153603-1-frank@...2641...>
References: <20250926111726.153603-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: proto: Clean up conversion
 warnings related to checksum macros
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

Stared long and hard at the changes... looks reasonable... and I actually
tested this (set different MSS values, see TCP SYN/ACKs go in/out and
verify that the changes are what we want to see *and* the resulting
checksum is correct).

Your patch has been applied to the master branch.

commit a06b9b2fcdea0ee36545019c6984baad2236e51d
Author: Frank Lichtenheld
Date:   Fri Sep 26 13:17:26 2025 +0200

     proto: Clean up conversion warnings related to checksum macros

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1164
     Message-Id: <20250926111726.153603-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33218.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


