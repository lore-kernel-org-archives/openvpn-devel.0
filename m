Date: Wed, 29 Feb 2012 20:37:37 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1656594721.20120229203737@...449...>
In-Reply-To: <4F4E7BEE.50700@...1114...>
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1957833067.20120229194040@...449...>
	<4F4E7BEE.50700@...1114...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

> How will you handle that some users use OpenVPN from Windows, Linux and
> maybe even a mobile phone (like N900)? ... where paths are different,
> depending on OS and/or distribution.  And some paths on Linux (probably
> *BSD too?) are different if it is a 32bit architecture or 64bit.

Do have an example for an script? I've no idea what's the exact purpose is,
I've never used scripts in openvpn.

> I doubt it will be highly appreciated that sys-admins need to maintain
> separate script profiles on the server side, for each OS/platform connecting.

Who writes the script? The sysadmin.

> And you would also need to go even further, to also make --plugin only
> pushable too.  Which makes the /usr/lib vs /usr/lib64 scenario a real
> pain for sure.

Why do u want to secure openvpn if there is an option for a user to
inject plugins?
The plugin code do anything.

Are plugins used only on server side or on clientside, too?

greetings
Carsten


