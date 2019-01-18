Date: Fri, 18 Jan 2019 20:44:16 +0100 (CET)
Message-Id: <201901181944.x0IJiGuV003728@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219202611.2144-2-simon@...2293...>
References: <20181219202611.2144-2-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extend FindSystemInfo custom
 action to detect OpenVPNService state
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is code I can even understand (to some extent) ;-) - overall it looks
good, but a few style warts sneaked in...

+finish_QueryServiceStatusEx:;
+        
+    // Service is not started. Is it set to auto-start?
+    // MSDN describes the maximum buffer size for QueryServiceConfig() to be 8kB.
+    // This is small enough to fit on stack.

.. there shouldn't be a ";" after a label, and no C++ comments... but
I assume the uncrustify patch coming next will fix that...

Something else might not be obvious to the reader:

+    if (pQsc->dwStartType <= SERVICE_AUTO_START)
+    {

so what does "lesser than AUTO_START" mean?  manual start?  no start at
all?  Comparing for "lesser or equal" with something enum-like might
warrant a comment /* BOOT_START = 0, SYSTEM_START = 1, AUTO_START = 2 */
or so...  (yes, I can google this, but still).


Compile tested on Ubuntu 16.04 / mingw.


Your patch has been applied to the master branch.

commit 8148ee9d01de75d0302f224ef499eddfabc6fee2
Author: Simon Rozman
Date:   Wed Dec 19 21:26:09 2018 +0100

     Extend FindSystemInfo custom action to detect OpenVPNService state

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181219202611.2144-2-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18039.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


