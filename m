Message-ID: <40260954.5040003@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] --redirect-gateway
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
Date: Sun Feb  8 02:03:18 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

one answer from misc@...168...
or read file /etc/mygate (but not really portable)

Regards

		Julien

-------- Original Message --------
Subject: Re: get gateway address in c
Date: Sat, 7 Feb 2004 22:03:35 +0100
From: Henning Brauer <lists-openbsd@...169...>
To: Julien TOUCHE <julien.touche@...61...>
References: <40255088.6020005@...61...>

you could fetch the default route. this is not exactly trivial, but not
too hard either - in usr.sbin/bgpd/kroute.c, fetchtable() has the code
to do that. might be an inspiration.
no, it's not trivial ;-)
-- 
http://2suck.net/hhwl.html - http://www.bsws.de/
Unix is very simple, but it takes a genius to understand the simplicity.
(Dennis Ritchie)

<<< from kroute.c >>>
int
fetchtable(void)
{
         size_t                   len;
         int                      mib[6];
         char                    *buf, *next, *lim;
         struct rt_msghdr        *rtm;
         struct sockaddr         *sa, *rti_info[RTAX_MAX];
         struct sockaddr_in      *sa_in;
         struct kroute_node      *kr;

         mib[0] = CTL_NET;
         mib[1] = AF_ROUTE;
         mib[2] = 0;
         mib[3] = AF_INET;
         mib[4] = NET_RT_DUMP;
         mib[5] = 0;

         if (sysctl(mib, 6, NULL, &len, NULL, 0) == -1) {
                 log_warn("sysctl");
                 return (-1);
         }
         if ((buf = malloc(len)) == NULL) {
                 log_warn("fetchtable");
                 return (-1);
         }
         if (sysctl(mib, 6, buf, &len, NULL, 0) == -1) {
                 log_warn("sysctl");
                 return (-1);
         }

         lim = buf + len;
         for (next = buf; next < lim; next += rtm->rtm_msglen) {
                 rtm = (struct rt_msghdr *)next;
                 sa = (struct sockaddr *)(rtm + 1);
                 get_rtaddrs(rtm->rtm_addrs, sa, rti_info);

                 if ((sa = rti_info[RTAX_DST]) == NULL)
                         continue;

                 if (rtm->rtm_flags & RTF_LLINFO)        /* arp cache */
                         continue;

                 if ((kr = calloc(1, sizeof(struct kroute_node))) == NULL) {
                         log_warn("fetchtable");
                         return (-1);
                 }

                 kr->r.flags = F_KERNEL;

                 switch (sa->sa_family) {
                 case AF_INET:
                         kr->r.prefix.s_addr =
                             ((struct sockaddr_in *)sa)->sin_addr.s_addr;
                         sa_in = (struct sockaddr_in
*)rti_info[RTAX_NETMASK];
                         if (kr->r.prefix.s_addr == 0)   /* default route */
                                 kr->r.prefixlen = 0;
                         else if (sa_in != NULL)
                                 kr->r.prefixlen =
                                     mask2prefixlen(sa_in->sin_addr.s_addr);
                         else if (rtm->rtm_flags & RTF_HOST)
                                 kr->r.prefixlen = 32;
                         else
                                 kr->r.prefixlen =

prefixlen_classful(kr->r.prefix.s_addr);
                         break;
                 default:
                         continue;
                         /* not reached */
                 }

                 if ((sa = rti_info[RTAX_GATEWAY]) != NULL)
                         switch (sa->sa_family) {
                         case AF_INET:
                                 kr->r.nexthop.s_addr =
                                     ((struct sockaddr_in
*)sa)->sin_addr.s_addr;
                                 break;
                         case AF_LINK:
                                 kr->r.flags |= F_CONNECTED;
                                 kr->r.ifindex = rtm->rtm_index;
                                 break;
                         }

                 kroute_insert(kr);

         }
         free(buf);
         return (0);
}





