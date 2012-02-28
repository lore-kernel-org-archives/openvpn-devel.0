Date: Tue, 28 Feb 2012 23:09:13 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1945967716.20120228230913@...449...>
In-Reply-To: <4F4D2212.2020008@...1114...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<4F4D18C0.1020008@...1114...>
	<1958561304.20120228192904@...449...>
	<4F4D2212.2020008@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: 

Hello David,

DS> Heiko can probably give a much better answer, but if I remember right,
DS> the argument was this:  Think of a multi-user setup (like a Terminal
DS> Server), the management interface will be accessible for all users on
DS> that server.

a) Who an earth allows users on a terminal server to create VPN-sessions?
What happens if one of the sessions use redirect gateway?
All users are redirected?

b) you can set a password for management interface

I don't think that this is a valid point.

Privilege seperation in openvnp deamon is nice, but is a complete
different thing than management interface access.

I try to compare it with apache.
Apache on linux need root rights to bind to port below 1024 but it
didn't need to have root privilege to serve a page.
So it's a good idea to use root rights to bind to port 80 and than
serve all pages without root rights.

OpenVPN need root rights on linux/administrator rights on windows
(to be more precise network operator rights) to modify routing tables.

In openvpn case it should be something like this:
openvpnserv.exe running as a service, has no privileges and opens
management interface
openvpnhelpserv.exe running as a service has network operator rights
(no need for local system ...)

openvpnserv and openvpnhelpserv could communicate via pipe.

openvpn-management client (could be a perl script) connects to
management interface of openvpnserv.exe to start/stop a tunnel and
supply secrets.

DS> And how this is implemented, the OpenVPN Service will be started
DS> automatically.  The GUI contacts the Service and the service starts the
DS> OpenVPN process with the privileges of the GUI user (IIRC, it was some
DS> neat Windows functions which allows to create processes with privileges
DS> based upon the user credentials of the other side of the named pipe).

The sounds very bad.
The service shouldn't create processes in the name of the user.

DS> This service should be able to (for now only in theory; it has not been
DS> tested yet) handle more users simultaneously.

Pretty useless, see above

DS> However, the management interface will be used in addition too, at least
DS> in the very beginning, where the logging is transferred back to the GUI
DS> and so on.  I don't recall now all the GUI would do via this interface.

Sounds very weird.

greetings
Carsten




