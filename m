From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:13:55 +0200
Message-Id: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] WTMP support for OpenVPN 2.1
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
To: openvpn-devel@lists.sourceforge.net


Hi!

This is an initial attempt to let OpenVPN 2.1 write a wtmp log of all
connections including the username, it's VPN IP and the real remote IP
the user connected from.

This provides an OpenVPN admin with a simple database of all connections
of his VPN servers and the possibility to easily see if anyone is using
the VPN server currently.

It is possible to let multiple instances of OpenVPN on the same host use the
same wtmp file by specifying different "server ids" which are a two digit 
integer which will be used in the wtmp line string to distinguish between 
vpn sessions.

This implementation does work, but has some things which have to be done
better:

  * There has to be used a unique session id per VPN session which does not
    change between reconnecteds (currently the ssl session_id is used as
    identifier)

  * At the moment the uid/gid for the username/groupname config options
    are looked up by hand in wtmp_init() as the context->c0 struct is not
    yet available.
    Maybe wtmp_init() could be called a bit later at a usefull place to
    avoid this doulbe lookup.

These are the "known bugs" my implementation has, but which are still on my
todo list (the second one is kind of WORKS_FOR_ME) :)

So if anyone has comments or ideas how to do things better, don't hasitate
and let me know.

I would very much like to get thos included in OpenVPN as it will help people
to have an overview about the usage of the VPNs and was requested earlier.

Ciao
Max


