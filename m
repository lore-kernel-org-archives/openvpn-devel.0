MIME-Version: 1.0
In-Reply-To: <4D07AEC7.3010408@...1114...>
References: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>
	<1292286924.6222.3.camel@...1259...>
	<AANLkTikhRr-YhNP4OaZM8kCJ++-OcKh=eQ9jAeedxjNj@...278...>
	<4D07AEC7.3010408@...1114...>
Date: Tue, 14 Dec 2010 10:25:42 -0800
Message-ID: <AANLkTik0razPaAEqNSNEYgsoH_sczjUSj7fbgVsVraYy@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Subject: Re: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

From code inspection it seems like I need to have one PF-file/client.
So for 1000 clients connected this means 1000 files! That is the
bottleneck I am talking about. Also, in my use-case the plugin (which
spawns a separate thread) is the one who asynchronously wants to close
a socket. The important thing to note here is that this socket may not
be actively being served by openvpn process at the time of closing (by
plugin) and so packet filtering will never kick in.

So I am not sure if PF will help here. It will help of course if the
use-case is for closing a socket *the next time it is used*.
Hope I didn't confused folks with my use-case.

This is why I started with the telnet-client idea whereby my plugin
thread sends "kill IP:port" command via telnet to openvpn's management
listener. But the problem I will run into is the fact that telnet
somehow is written to only allow one telnet session at a time. So if
my plugin decides to use this session then at that instant in time no
one else can use this cool management feature.
Are there ways around that : making telnet accept multiple sessions?

Thanks,

Vineet
On Tue, Dec 14, 2010 at 9:52 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 14/12/10 18:47, Vineet Kumar wrote:
>> Thanks for your response. This seems to involve file I/O and iptables
>> right? File I/O seems like a performance bottleneck, no?
>
> Maybe, if you're still using tapes and need to rewind the tape ;-)
>
> Seriously, not really. =A0All decent OSes today have pretty good caching,
> so most likely will things not manage to get written properly to disk
> before the file is read, parsed and removed again by OpenVPN.
>
> But to improve things a bit, you can always mount a directory for such
> files in a tmpfs (or a RAM disk) and let OpenVPN use that.
>
>
> kind regards,
>
> David Sommerseth
>
>
>
>> Vineet
>> On Mon, Dec 13, 2010 at 4:35 PM, chantra <chantra@...1258...
>> <mailto:chantra@...1258...>> wrote:
>>
>> =A0 =A0 Vineet,
>>
>> =A0 =A0 I think you could use Packet filtering plugin hook and use the
>> =A0 =A0 [KILL] tag at the end of the pf file .
>>
>> =A0 =A0 See
>> =A0 =A0 http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/op=
envpn-testing.git;a=3Dblob;f=3Dopenvpn-plugin.h;h=3D56b0a701574e6913b3a714e=
941cdc4899dbea8e1;hb=3DHEAD#l316
>>
>> =A0 =A0 I have never used it myself, but I think that should sort you ou=
t.
>>
>> =A0 =A0 The doc says that this file may be dynamically updated during a
>> =A0 =A0 client session. I assume the main process will pick up the change
>> =A0 =A0 quick fast.
>>
>> =A0 =A0 Chantra
>>
>>
>> =A0 =A0 On Mon, 2010-12-13 at 15:16 -0800, Vineet Kumar wrote:
>>> =A0 =A0 Hi,
>>> =A0 =A0 =A0 If my openvpn plugin spawns its own thread and from that th=
read
>>> =A0 =A0 wants to kill a tunnel specified by IP:port how can that be don=
e?
>>> =A0 =A0 (something like what the 'telnet' management provides: "kill IP=
:port")
>>> =A0 =A0 This plugin is meant to do other stuff and in certain scenarios=
 wants
>>> =A0 =A0 to close specific tunnels.
>>> =A0 =A0 First I thought of using the plugin to write code to establish a
>>> =A0 =A0 telnet-client sessions and send over "kill IP:port" command. Bu=
t I
>>> =A0 =A0 notice an issue with the management listener: if I run more tha=
n 1
>>> =A0 =A0 telnet session only the first one can pass through data whereas=
 all
>>> =A0 =A0 others' telnet sessions just hang.
>>>
>>> =A0 =A0 Is this even possible?
>>>
>>> =A0 =A0 Vineet
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk0HrsYACgkQDC186MBRfrqm1ACfeP0/aDdh9Ss2Xuas583v+R5A
> dtkAnRBv1+3Ky9BOQwDana06n3xxKOMa
> =3D8ouQ
> -----END PGP SIGNATURE-----
>

