Message-ID: <439F20F1.3060005@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] BUG --daemon & --auth-retry interact: openvpn
 won't daemonize after interaction
References: <200512130015.39902.opensource@...519...>
In-Reply-To: <200512130015.39902.opensource@...519...>
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
Date: Tue Dec 13 11:30:04 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Till Maas <opensource@...519...>
Cc: openvpn-devel@lists.sourceforge.net

Till Maas wrote:

>Hiyas,
>
>when I start openvpn 2.0.5 (debian unstable) with --daemon --auth-retry 
>interact it won't daemonize when I provide the correct password after the 
>second password prompt. If I enter the right password the first time it does.
>
>I would really appreciate it when you fix this and thank you for developing 
>openvpn.
>  
>
You didn't show your config file, and you don't say whether or not you 
are using the management interface for providing the username/password.

What I found is that this client config:

daemon auth-test
cd [config file dir]
management [local IP] 4000
management-query-passwords
nobind
dev tun
remote [server IP]
client
ca sample-keys/ca.crt
verb 3
ns-cert-type server
auth-user-pass
auth-retry interact
writepid pid

has two problems when run with 2.0.5.

(1) OpenVPN blocks on the management-query-passwords directive before 
daemonization, which is wrong.  It should daemonize before any non-stdin 
blocking.

(2) There is a race condition that occurs on Linux and maybe other OSes 
(but not Windows) when the first user/pass query fails, so OpenVPN does 
a SIGUSR1 and requeries.  The problem is that on Linux (and possibly 
other unices), when the UDP socket is closed and reopened (with 
"nobind"), the dynamic source port number doesn't change, so the server 
doesn't immediately recognize that a new session object needs to be 
created.  Because of this, in some cases, the client's attempt to 
reauthenticate may be associated on the server with the soon-to-be 
deleted AUTH_FAILED instance since the new connection is using the exact 
same source IP/port as the old, failed connection.  Windows doesn't show 
this problem because it always uses a different dynamic source port 
number when a UDP socket is closed and reopened (when "nobind" is used).

I've put together a patch which I believe fixes both of these issues, 
and is available now in rev 852 in the SVN repository:

svn co http://svn.openvpn.net/projects/openvpn/trunk/openvpn

(the INSTALL file has directions for building from an svn checkout)

James


