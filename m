Date: Wed, 2 Apr 2025 20:31:31 +0200 (CEST)
Message-Id: <202504021831.532IVVoO069210@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250402132148.18810-1-gert@...1296...>
References: <20250402132148.18810-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix FreeBSD-DCO and Multisocket
 interaction
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for fixing this.  Stared at the code, discussed a bit, and actually
went out and tested (on FreeBSD 14 server test set).  Without the patch
an instance with both UDP and TCP starts with DCO and dies miserably
when a TCP connection comes in - with the patch, it will disable DCO,
and do UDP+TCP in userland (kernel doesn't do TCP, so there is nothing
we can do).  With multiple UDP sockets, DCO works.

Your patch has been applied to the master branch.

commit a061b3a94c5489a2f207189343f1c235e8181b87
Author: Gianmarco De Gregori
Date:   Wed Apr 2 15:21:42 2025 +0200

     Fix FreeBSD-DCO and Multisocket interaction

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250402132148.18810-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31324.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


