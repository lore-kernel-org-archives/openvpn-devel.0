References: <C0618847-3DAF-4E68-8143-A0BECC5DFD40@...277...>
	<66ae9cc3-cabf-f70d-b4f1-ecfbbf78b6d5@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
Date: Mon, 8 May 2017 23:07:42 +0200
MIME-Version: 1.0
In-Reply-To: <66ae9cc3-cabf-f70d-b4f1-ecfbbf78b6d5@...1227...>
Subject: Re: [Openvpn-devel] Fix for OpenVPN MTU Tunnel computation bug for
 TLS reconnects
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


On 08-05-17 14:54, Arne Schwabe wrote:
> Am 05.05.17 um 13:38 schrieb Dirkjan Bussink:
>>
>> When testing upgrading OpenVPN from 2.3 to 2.4, we ran into an issue where
>> every time the same client reconnects the MTU for the tunnel used shrinks,
>> eventually leading to packets being dropped by OpenVPN.
>>
>> Reproduced the problem with a 2 node setup, one as the server and the other
>> one as a client. Each time the client is restarted the packet sizes shrink
>> until it breaks. 
>>
> 
> I can reproduce this problem. Actually I have experienced that problem
> longer but never looked into enough. On first glance it looks okay and
> the patch actually also works for me but I don't know the reuse code
> path good enough to figure what is really going on.

I'm following up on this on trac:
https://community.openvpn.net/openvpn/ticket/879

It seems to me that we need a different fix - see the patch on trac.
I'll turn is onto a proper patch and send it to the list.

> I am actually suprised that this is "TLS resuse" as in my case the
> client is completely restarted.

This is because "nobind" is not used in these client configs, which
results in the client using port 1194 for it's outgoing connection.  The
server then sees a connection from a ip:port it already has an instance
state for, and re-uses the instance instead of creating a new one.  That
is not very common (most people use "nobind" in their client configs),
but should of course still work.

-Steffan

