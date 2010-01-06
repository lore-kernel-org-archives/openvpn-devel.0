Message-ID: <4B448BF4.8010706@...515...>
Date: Wed, 06 Jan 2010 15:11:16 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] IRC meeting regarding OpenVPN development model
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

I discussed our current development with James and he agreed we need to cha=
nge it. Therefore I'm organizing an open IRC meeting where we'll discuss wh=
at changes to make and how. James will of course be attending:

Place: #openvpn at irc.freenode.net
Time: Tuesday 12th Jan 19:00 UTC (20:00 MET, 21:00 EEST, 11AM PST, 2PM EST)
Duration: 1 hour (or more)

Here's an outline of current plans - thanks to all who've provided ideas an=
d feedback so far. It's been very valuable!

- Clearly separate the goals of the OSS project and our product ("Access se=
rver") to avoid unnecessary conflicts. The goal is to be able to develop Op=
enVPN as openly as possible without hurting our product. The goals of OpenV=
PN project should be discussed openly later on.
- (We) Allocate enough time to the OSS project to keep it moving along.
- In general follow the Linux kernel development model
- Emphasize openness and communication:
  - Delegate responsibility to trusted community members
  - If a patch is suitable for inclusion, it can be commited to the reposit=
ory and the author informed via devel-mailinglist
  - If a patch needs modifications, the author will be told what problems t=
here were so he can fix it
  - If a patch is unsuitable for inclusion under any conditions, the author=
 needs to know why
  - If the patch author has not signed a contributor agreement he needs to =
be pointed to it
- Emphasize code quality:
  - Separate testing trees allow timely and safe merging of patches and new=
 features. Hopefully these will be managed by trusted community members.
  - Let trusted community members preview the patches before they reach Jam=
es
  - Write common guidelines for all developers (e.g. usage of #ifdef's, sec=
urity practices, etc.)
  - Organize testing of changed code (both automated and manual)

I probably forgot something, but I hope you get the general idea. These dev=
elopment issues have been discussed earlier in this mailinglist:

 http://sourceforge.net/mailarchive/message.php?msg_id=3D4B263634.3050000%4=
0openvpn.net

I'll write down a loose agenda for the meeting and send it to the list. I h=
ope this way we can concentrate on finding solutions to the actual problems=
 rather than have a nice, heated discussion of the relative merits of Git, =
Mercurial and Subversion :). I hope many of you can attend!

See you all,


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
twitter com: samuli_openvpn


