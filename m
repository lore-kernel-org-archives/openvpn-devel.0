Date: Thu, 29 Apr 2010 09:07:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100429070756.GX12312@...1296...>
References: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...>
Mime-Version: 1.0
In-Reply-To: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...>
Subject: Re: [Openvpn-devel] [PATCH] TAP interface support for
	Solaris/OpenSolaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Kazuyoshi Aizawa <admin2@...628...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi again,

On Thu, Apr 29, 2010 at 01:02:37PM +0900, Kazuyoshi Aizawa wrote:
> I've attached a patch for tun.c which includes support for tap
> interface for solaris/opensolaris.

I've glanced through the patch, and there's also changes in the Win32
part of the tun.c, for example this chunk:


----------------------- quote ----------------------
@@ -3333,19 +3409,19 @@
   bool ret = false;
   const IP_ADAPTER_INDEX_MAP *inter = get_interface_info (adapter_index, &gc);
 
-  if (inter)
-    {
-      DWORD status = IpRenewAddress ((IP_ADAPTER_INDEX_MAP *)inter);
-      if (status == NO_ERROR)
+      if (inter)
 	{
-	  msg (D_TUNTAP_INFO, "TAP: DHCP address renewal succeeded");
-	  ret = true;
+	  DWORD status = IpRenewAddress ((IP_ADAPTER_INDEX_MAP *)inter);
+	  if (status == NO_ERROR)
+	    {
+	      msg (D_TUNTAP_INFO, "TAP: DHCP address renewal succeeded");
+	      ret = true;
+	    }
+	  else
+	    msg (M_WARN, "WARNING: Failed to renew DHCP IP address lease on TAP-Win32 adapter: %s (code=%u)",
+		 strerror_win32 (status, &gc),
+		 (unsigned int)status);
 	}
-      else
-	msg (M_WARN, "WARNING: Failed to renew DHCP IP address lease on TAP-Win32 adapter: %s (code=%u)",
-	     strerror_win32 (status, &gc),
-	     (unsigned int)status);
-    }
   gc_free (&gc);
   return ret;
 }
----------------------- quote ----------------------


From a first glance, this looks like "whitespace changes only".

For easier review: would you be so kind and re-send your patch with
"diff -uw" (-w = ignore white space changes)?

thanks,

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

