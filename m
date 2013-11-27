Date: Wed, 27 Nov 2013 20:25:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131127192522.GA11101@...1296...>
References: <1385382680-5912-4-git-send-email-arne@...1227...>
	<20131127192346.GA11083@...1296...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20131127192346.GA11083@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: change the type of remote
	to addrinfo.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Nov 27, 2013 at 08:23:46PM +0100, Gert Doering wrote:
> I have taken the liberty of carefully massaging some of the whitespace,
> pull up one fix to init.c from 6/9, and change one mishap in socket.h -
> a diff between "previous master + 4/9" and "6c5db192c30ff" is attached.

Well.  If people claim "... is attched", in the first mail, it never
is...

Here it is now.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diff.txt"

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7a376ab..e7f733b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1356,7 +1356,7 @@ do_init_tun (struct context *c)
 			   c->options.ifconfig_ipv6_netbits,
 			   c->options.ifconfig_ipv6_remote,
 			   addr_host (&c->c1.link_socket_addr.local),
-			   addr_host (&c->c1.link_socket_addr.remote_list),
+			   c->c1.link_socket_addr.remote_list,
 			   !c->options.ifconfig_nowarn,
 			   c->c2.es);
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index ec9146d..65def10 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -624,9 +624,10 @@ static inline bool
 addrlist_match (const struct openvpn_sockaddr *a1, const struct addrinfo *addrlist)
 {
   const struct addrinfo *curele;
-  for (curele = addrlist; curele; curele=curele->ai_next) {
-
-    switch(a1->addr.sa.sa_family) {
+  for (curele = addrlist; curele; curele=curele->ai_next)
+    {
+      switch(a1->addr.sa.sa_family)
+        {
 	  case AF_INET:
 	    if (a1->addr.in4.sin_addr.s_addr == ((struct sockaddr_in*)curele->ai_addr)->sin_addr.s_addr)
 	      return true;
@@ -660,8 +661,10 @@ static inline bool
 addrlist_port_match (const struct openvpn_sockaddr *a1, const struct addrinfo *a2)
 {
   const struct addrinfo *curele;
-    for(curele=a2;curele;curele = curele->ai_next) {
-        switch(a1->addr.sa.sa_family) {
+  for(curele=a2;curele;curele = curele->ai_next)
+    {
+      switch(a1->addr.sa.sa_family)
+        {
           case AF_INET:
             if (curele->ai_family == AF_INET
                 && a1->addr.in4.sin_addr.s_addr == ((struct sockaddr_in*)curele->ai_addr)->sin_addr.s_addr
@@ -879,8 +882,8 @@ link_socket_set_outgoing_addr (const struct buffer *buf,
 	   || !addr_match_proto (&act->dest, &lsa->actual.dest, info->proto))
 	  /* address undef or address == remote or --float */
 	  && (info->remote_float
-	      || !lsa->remote_list)
-	      || addrlist_match_proto (&act->dest, lsa->remote_list, info->proto)
+	      || !lsa->remote_list
+	      || addrlist_match_proto (&act->dest, lsa->remote_list, info->proto))
 	  )
 	{
 	  link_socket_connection_initiated (buf, info, act, common_name, es);

--SLDf9lqlvOQaIe6s--

