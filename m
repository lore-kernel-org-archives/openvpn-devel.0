Date: Sat, 23 Jul 2022 14:17:28 +0200 (CEST)
Message-Id: <202207231217.26NCHSTG051037@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220722204007.7537-1-selva.nair@...277...>
References: <20220722204007.7537-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: In x_check_status() read errno
 early
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for investigating and locating the issue so quickly - I think
it would have taken me much longer to understand what really happens
(if I read it right, the code would *query* for the extended status 
just fine, gobble errno in the process, and then ignore the 
"extended_msg" later, due to ignore_sys_error() being triggered)

But anyway - we're back to "it works!"

2022-07-23 14:08:24 us=700677 UDPv6 link remote: [AF_INET6]2001:608:2:a::253:1196
W2022-07-23 14:08:24 us=727325 read UDPv6 [ECONNREFUSED]: Connection refused (fd=3,code=111)

2022-07-23 14:09:30 us=94516 UDPv4 link remote: [AF_INET]193.149.36.253:1196
W2022-07-23 14:09:30 us=117381 read UDPv4 [ECONNREFUSED]: Connection refused (fd=3,code=111)


and indeed, --mtu-disc yes also works again...

2022-07-23 14:15:15 write UDPv4 [EMSGSIZE Path-MTU=1300]: Message too long (fd=3,code=90)

2022-07-23 14:12:15 write UDPv6 [EMSGSIZE Path-MTU=1280]: Message too long (fd=3,code=90)

(this is triggered by adding a reduced-mtu route on a linux router in
between - "ip route add 199.102.77.82 dev ppp0 mtu 1300" - so easy to
test manually, not sure yet how to do that programmatically in a 
reasonably sane way)


Your patch has been applied to the master branch.

commit 95afd63ac74197980ecff2b3ecb2116d62035f7f
Author: Selva Nair
Date:   Fri Jul 22 16:40:07 2022 -0400

     In x_check_status() read errno early

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220722204007.7537-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24728.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


