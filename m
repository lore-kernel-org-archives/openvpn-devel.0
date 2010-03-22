Message-ID: <4BA730D2.5040508@...193...>
Date: Mon, 22 Mar 2010 09:56:50 +0100
From: Farkas Levente <lfarkas@...193...>
MIME-Version: 1.0
Subject: [Openvpn-devel] server log not very useful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVPN Devel <openvpn-devel@lists.sourceforge.net>

hi,
if i set in my server's config:
tls-server
and on the client's conf:
remote-cert-tls server
ns-cert-type server
then if i generate a new cert for the server and forget to set it to 
server, then it's very hard to find out the problem. ie. neither from 
the server nor the client's log file contains any info about the 
problem's reason. it's be useful if there be some kind of info about the 
real reason other then:
TLS Error: Unroutable control packet received
[ECONNREFUSED]: Connection refused
thanks.
regards.

-- 
   Levente                               "Si vis pacem para bellum!"

