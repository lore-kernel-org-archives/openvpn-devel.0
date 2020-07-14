Date: Tue, 14 Jul 2020 14:55:19 +0200 (CEST)
Message-Id: <202007141255.06ECtJw8046870@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <c404dd17-e0db-ce61-0d79-864a5736f2d0@...1147...>
References: <c404dd17-e0db-ce61-0d79-864a5736f2d0@...1147...>
Subject: [Openvpn-devel] [PATCH applied] Re: Added support for DHCP option
 119 (dns search suffix list) for Windows. As of Windows 10 1809 Windows
 finally supports this so it makes sense to add support to OpenVPN as well.
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
To: Jan Just Keijser <jan.just.keijser@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Yay :-)

(I have reviewed it once again, and tested on my Win10 VM, and it still works!)

Your patch has been applied to the master branch.

I have reformatted and extended the commit message to give more details
on what you did and what it can and can not do.

commit 78359a0478da64e18d49b13ea2e09def2b89f4a6
Author: Jan Just Keijser
Date:   Tue Jul 14 11:39:10 2020 +0200

     Added support for DHCP option 119 (dns search suffix list) for Windows. 

     As of Windows 10 1809 Windows finally supports this so it makes sense 
     to add support to OpenVPN as well.

     Signed-off-by: Jan Just Keijser <jan.just.keijser@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <c404dd17-e0db-ce61-0d79-864a5736f2d0@...1147...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20349.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


