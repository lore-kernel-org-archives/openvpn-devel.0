Message-ID: <a6589cd60411060723236852f@...278...>
From: Hans Fugal <fugalh@...277...>
Reply-To: Hans Fugal <fugalh@...277...>
Subject: Re: [Openvpn-devel] CreateFile failed on TAP device
In-Reply-To: <Pine.LNX.4.61.0411060032480.1651@...210...>
Mime-Version: 1.0
References: <a6589cd6041105091611d082c6@...278...>
	 <Pine.LNX.4.61.0411060032480.1651@...210...>
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
Date: Sat Nov  6 07:28:08 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 6 Nov 2004 00:36:12 +0100 (CET), Mathias Sundman
<mathias@...209...> wrote:
> It's a windows system, right? Reinstall and reboot is always a solution on
> such a beast ;-)

Yes, and that's what we ended up doing.
 
> Is she using --dev-node to specify the tun/tap interface?
# Her config file:
dev tun
client
remote 204.96.22.195

ca wencor-cacert.pem
cert user.pem
key  user.pem

keepalive 10 60
comp-lzo
mute 5
verb 4

In addition, I'm pushing a route and a few dhcp-options.

> Does she have multiple tun/tap interfaces installed?

She shouldn't, if she followed my instructions properly.
 
> If she run ipconfig can she see the device with the GUID listed above?

She had a hard time finding All Programs in the Start Menu. :-)

> Does it fail evert time she tries to connect now?

Yes, it was failing every time.

> Did she make any changes when it stopped working? Any new patches applied?

She claimed she didn't make any changes, and she certainly wouldn't
have been applying patches or reinstalling components. She may have
run the original installer again, that's a possibility. I believe she
was trying to start another openvpn gui instance, FWIW.

Hans
-- 
De gustibus non disputandum est.

