Message-ID: <3E1F1562.7030909@...61...>
From: julien Touche <julien.touche@...61...>
MIME-Version: 1.0
Subject: [Openvpn-devel] some questions
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Jan 10 10:49:08 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

first greetings for openvpn which is a best of for easy VPN :)

i have a small list of questions i can't answer myself:

- at which stage is the win32 port ? always looking for tun driver ?
i give a glimpse to cipe driver which seems "simple unix2win" NDIS
driver but 1-cannot compile (need ndis.h part of windows DDK which is
not free download) 2-lot bigger compare to unix tun code (from vtun
site) even if it does more 3- there is no /dev in win so what's best ?
pipe i believe ?


- is there any way to connect someone which is not-root ? for example,
i'm at work with a desktop computer without root access (maybe even not
sure to have tun/tap driver) but i have only two or three apps i need to
connect to my home vpn (ssh, ftp, ...). i can modify them in order to
send data not on a socket but a pipe (or anything else) which send data
to a modified openvpn and send it on my home vpn.
is it possible or i'm completely dreaming ?

another solution is: having a list of port tunneled local (8080, 2222,
...) to local (9991, 9992, ...) (by stunnel for example) and the latter
list of port i send to vpn by openvpn/nonroot
(of course, we need to define for each local port the distant port AND
host, but if we can change on fly, it will be ok; or maybe someone know
a way for common user to forward all data address to a port to another
host ?)

the tun/tap driver is only required if want a complete real network
interface, right ? (which is necessary if we want to work with
unmodified apps)


Regards


PS: please cc.


