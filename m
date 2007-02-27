Message-ID: <203d54d50702270825h525b0426ga2ec563c458084fd@...278...>
Date: Tue, 27 Feb 2007 08:25:13 -0800
From: "Jeff Myers" <jeffage@...277...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7691_2069083.1172593513406"
Subject: [Openvpn-devel] Bug in current v2.0 and v2.1 Windows clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_7691_2069083.1172593513406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good day,

I have recently posted an issue on the users mailing list about a loss of
connectivity when adding new pushed routes to an existing configuration with
live clients.  As I already posted a lot of data on that list I didn't want
to flood this list as well (unless someone wants more data).

In my test scenario, I have a CentOS 4 Linux based OpenVPN server running
v2.0.7.  I have two clients running Windows XP SP2 and v2.0.9 (I also tested
with v2.1-RC1).  I am using TCP and am using a TUN interface.

The problem occurs when I modify the openvpn.conf file on the server and
perform a "service openvpn reload" (the same occurs if I completely restart
the openvpn service as well).  The clients will lose their connection and
attempt to reconnect.  During the reconnect process, they will delete the
existing push routes and attempt to add the new set of routes.  In my first
test one client succeeded while the other failed (OpenVPN 2.0.9).  In my
second test (OpenVPN 2.1-RC1) both clients failed on configuring the new
routes.  Lastly, both clients appear to be connected to OpenVPN, but since
they have no usable routes, they cannot communicate with the server.
Completely stopping and restarting the client resolves the issue.

The problem appears to be caused by the reconnect process missing one key
step.  For the client that succeeded, I noticed this entry in the log right
before it added the new routes:

Mon Feb 26 19:35:13 2007 Route: Waiting for TUN/TAP interface to come up...

The times that it failed I did not see this line.  So it appears that there
is a bug in the client software that allows the process to continue before
waiting for the TUN/TAP interface to come back up.

Can anyone else verify that this is a bug?  Any thoughts on how to resolve
this?

I have a situation where I can have 50+ active clients at any given time.  I
need to add two routes to my configuration and it is not feasible to ask
everyone to close and reconnect their VPN client every time a change is
made.

Thanks!

Jeff

------=_Part_7691_2069083.1172593513406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Good day,</div>
<div>&nbsp;</div>
<div>I have recently posted an issue on the users mailing list about a loss of connectivity when adding new pushed routes to an existing configuration with live clients.&nbsp; As I already posted a lot of data on that list I didn&#39;t want to flood this list as well (unless someone wants more data).
</div>
<div>&nbsp;</div>
<div>In my test scenario, I have a CentOS 4 Linux based OpenVPN server running v2.0.7.&nbsp; I have two clients running Windows XP SP2 and v2.0.9 (I also tested with v2.1-RC1).&nbsp; I am using TCP and am using a TUN interface.</div>

<div>&nbsp;</div>
<div>The problem occurs when I modify the openvpn.conf file on the server and perform a &quot;service openvpn reload&quot; (the same occurs if I completely restart the openvpn service as well).&nbsp; The clients will lose their connection and attempt to reconnect.&nbsp; During the reconnect process, they will delete the existing push routes and attempt to add the new set of routes.&nbsp; In my first test one client succeeded while the other failed (OpenVPN 
2.0.9).&nbsp; In my second test (OpenVPN 2.1-RC1) both clients failed on configuring the new routes.&nbsp; Lastly, both clients appear to be connected to OpenVPN, but since they have no usable routes, they cannot communicate with the server.&nbsp; Completely stopping and restarting the client resolves the issue.
</div>
<div>&nbsp;</div>
<div>The problem appears to be caused by the reconnect process missing one key step.&nbsp; For the client that succeeded, I noticed this entry in the log right before it added the new routes:</div>
<div>&nbsp;</div>
<div>Mon Feb 26 19:35:13 2007 Route: Waiting for TUN/TAP interface to come up...</div>
<div>&nbsp;</div>
<div>The times that it failed I did not see this line.&nbsp; So it appears that there is a bug in the client software that allows the process to continue before waiting for the TUN/TAP interface to come back up.</div>
<div>&nbsp;</div>
<div>Can anyone else verify that this is a bug?&nbsp; Any thoughts on how to resolve this?</div>
<div>&nbsp;</div>
<div>I have a situation where I can have 50+ active clients at any given time.&nbsp; I need to add two routes to my configuration and it is not feasible to ask everyone to close and reconnect their VPN client every time a change is made.
</div>
<div>&nbsp;</div>
<div>Thanks!</div>
<div>&nbsp;</div>
<div>Jeff</div>

------=_Part_7691_2069083.1172593513406--

