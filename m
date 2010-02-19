References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<4B7EA05C.5000802@...1114...>
	<20100219145623.GU9556@...1296...>
In-Reply-To: <20100219145623.GU9556@...1296...>
Mime-Version: 1.0 (Apple Message framework v1077)
Message-Id: <3F1E1001-37B9-4E9E-A7C0-AE521399CC86@...1286...>
From: Eric F Crist <ecrist@...1286...>
Date: Fri, 19 Feb 2010 09:01:50 -0600
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
	openvpn-testing tree available)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

On Feb 19, 2010, at 08:56:23, Gert Doering wrote:

> Hi,
>=20
> On Fri, Feb 19, 2010 at 03:29:48PM +0100, David Sommerseth wrote:
>> I'm fine with whichever path you choose.  But just bear in mind, some
>> systems might not have IPv6 support - which breaks portability ...=20
>=20
> On the unixish side, there is no system which has tun/tap today but
> does not have IPv6.
>=20
> On Windows, this might indeed be a killer argument to do some #idef'ing
> - what's the oldest version of Windows officially supported by OpenVPN?
>=20
> (XP and up has IPv6, everything before that does not)

It would be reasonable to state that OpenVPN 2.1.2 (or some-such) requires =
XP SP3 or newer.  The other, older, versions have not had official support =
from Microsoft for quite some time now.

---
Eric Crist





