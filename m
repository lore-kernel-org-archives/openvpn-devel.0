From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <3dbe8ad1-b62e-3802-06a9-920c46616451@...515...>
Date: Wed, 7 Sep 2016 12:18:17 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Dropping Windows Vista / XP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

This issue was raised by this email thread on openvpn-users:

<https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg03119.=
html>

Basically our new Authenticode (user-mode) certificate can only do SHA2=20
signatures, which Windows XP and Vista do not support. In practice both=20
operating systems will complain about an "unknown publisher".

Moreover, our EV dongle that is used to sign tap-windows6 can only do=20
SHA2 signatures. So, any tap-windows6 driver signed with the dongle will=20
get rejected by Windows Vista. The approach we took for the previous=20
tap-windows6 release was to have two signatures (SHA1+SHA2), but now=20
that option is gone.

I'm told that rekeying the Authenticode (user-mode) certificate as SHA1=20
is no longer possible, which is in line with Microsoft's recommendations=20
for CAs:

"Enforcement details"

"Code signing certificates"

"CAs should issue new code signing certs with SHA-1 after 1/1/2016 only=20
for developers targeting Vista/2008, otherwise, move all new certs to SHA2"

The above quotes are from

<http://social.technet.microsoft.com/wiki/contents/articles/32288.windows-e=
nforcement-of-authenticode-code-signing-and-timestamping.aspx>

We have already dropped XP support from OpenVPN Git "master". I think=20
now is the time to drop official XP support altogether, but to maintain=20
Vista support util the next tap-windows6 release.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

