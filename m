From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 Yo-Yo effect...
References: <40C1BE37.9030606@...199...>
In-Reply-To: <40C1BE37.9030606@...199...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CpgwAWgCIc90ih7"
Message-Id: <200406052100.34514.vda@...216...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Jun  5 11:02:00 2004
To: Mike Auty <m.auty@...199...>, openvpn-devel@lists.sourceforge.net

--Boundary-00=_CpgwAWgCIc90ih7
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 05 June 2004 15:36, Mike Auty wrote:
> Hi,
> 	Since I've upgraded to OpenVPN 2, I've started seeing an interesting
> effect.  Originally (way back at _test23) it didn't happen very much,
> and seemingly a restart of either the server or client would fix it, but
> recently it's been happening a lot.
> 	For historical reasons (I used to be on windows) I set my ping and
> ping-reset times to very low values (10 and 60) so that I'd see the
> adaptor go down within a minute of when my connection went down.  Under
> the old 1.5 vpns this was fine, but since the upgrade some of the
> windows installation's I've used have reported that the openvpn adaptor
> goes up and down every couple of minutes and in the recent _beta2 it
> seems to happen quite often (although it's still random in that
> sometimes it won't).

Try this patch
--
vda

--Boundary-00=_CpgwAWgCIc90ih7
Content-Type: text/x-diff;
  charset="koi8-r";
  name="ping_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ping_fix.patch"

--- ping-inline.h.orig	Wed Apr 21 08:03:22 2004
+++ ping-inline.h	Sun May 30 18:07:54 2004
@@ -50,9 +50,10 @@
 {
   void check_ping_send_dowork (struct context *c);
   if (c->options.ping_send_timeout
-      && !c->c2.to_link.len
       && event_timeout_trigger (&c->c2.ping_send_interval,
-				&c->c2.timeval))
+				&c->c2.timeval)
+      && !c->c2.to_link.len
+    )
     check_ping_send_dowork (c);
 }
 

--Boundary-00=_CpgwAWgCIc90ih7--


