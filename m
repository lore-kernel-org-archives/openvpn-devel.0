Date: Thu, 24 Nov 2016 12:00:50 +0100 (CET)
Message-Id: <201611241100.uAOB0o0r069804@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479958527-29491-1-git-send-email-selva.nair@...277...>
References: <1479958527-29491-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set IPv6 DNS servers using
	interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Code looks reasonable, and it passes compilation.

I have not been able to actually TEST it due to scheduling conflicts
today, but I'm taking that risk, based on "it looks good, it affects
windows only, and unless the code is activated by *pushing* a DNS6
option, it will not affect existing setups at all".

In case someone wonders whether changing struct dns_cfg_message_t is
safe - it is, because we never had a "v4 DNS message" yet, that struct
was completely unused (and the new one is theoretically multi-protocol
capable, though not "mixed mode").

I did a small code fix, though - the netsh_dns_cmd() always reset
"err = 0" at the end:

+  err = ExecCommand (argv0, cmdline, timeout);
+   
+out: 
+  err = 0;
+  free (cmdline);
+  return err;
+}

.. which did not make sense, so I removed the "err = 0" line.


Your patch has been applied to the master branch.

commit c098016a22e90575e9c3e7c27d7b457ed9d1b5d3
Author: Selva Nair
Date:   Wed Nov 23 22:35:27 2016 -0500

     Set IPv6 DNS servers using interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479958527-29491-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13222.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


