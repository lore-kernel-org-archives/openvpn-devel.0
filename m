From: Claas Hilbrecht <claas+maillinglists.openvpn@...232...>
Message-ID: <67CF4F1A72E8B470C95AE917@[192.168.1.22]>
In-Reply-To: <OF16152585.163DBB30-ON41256EC4.0055E643@...246...>
References: <OF16152585.163DBB30-ON41256EC4.0055E643@...246...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] Urgent: Limitation to 100  virtual tunnel
 devices??
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
Date: Thu Jul  8 09:49:07 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Juerg.VonBueren@...245..., openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Am Donnerstag, 1. Juli 2004 17:18 +0100 Juerg.VonBueren@...245... schrieb:

> We are running into trouble with more than 100 virtual tunnel devices .
> The reported problem is as follows:
> Jul  1 06:30:19 1100PRVC001 openvpn[15520]: Note: Cannot ioctl TUNSETIFF

I assume you need the following patch:

diff -urN linux-2.4.26.org/net/core/dev.c linux-2.4.26/net/core/dev.c
--- linux-2.4.26.org/net/core/dev.c	Wed Apr 14 15:05:41 2004
+++ linux-2.4.26/net/core/dev.c	Thu Apr 15 18:54:01 2004
@@ -619,8 +619,12 @@

 	/*
 	 * If you need over 100 please also fix the algorithm...
+	 *
+	 * Maybe it's never needed but just to be sure we allow
+	 * up to 1000 tun/tap devices.
+	 *
 	 */
-	for (i = 0; i < 100; i++) {
+	for (i = 0; i < 1000; i++) {
 		snprintf(buf,sizeof(buf),name,i);
 		if (__dev_get_by_name(buf) == NULL) {
 			strcpy(dev->name, buf);


-- 
 Claas Hilbrecht
 http://www.jucs-kramkiste.de


