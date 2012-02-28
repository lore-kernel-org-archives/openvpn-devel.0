MIME-Version: 1.0
In-Reply-To: <4F4D1D5F.2090208@...1114...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<1111951883.20120228191750@...449...>
	<4F4D1D5F.2090208@...1114...>
Date: Tue, 28 Feb 2012 20:42:51 +0200
Message-ID: <CAOazyz2KBtP8onxNjRxeqsYyeyTyDOqwOpVvKWw8nn6My4n=1A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/2/28 David Sommerseth <openvpn.list@...1114...>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 28/02/12 19:17, Carsten Kr=C3=BCger wrote:
>> Hello Alon,
>>
>> ABL> This is *THE* missing functionality in Windows environment. ABL>
>> It seems that nobody interested in developing proper UI using ABL>
>> management interface for Windows. ABL> Same goes to proper smartcard
>> support.
>>
>> Developing the UI (command line) would be trivial but to my knowledge
>> (I'm reading the mailinglist for last 7 years) there is no management
>> interface in openvpn that would allow this.
>>
>
> Have you seen this document? =C2=A0(management/management-notes.txt)
> <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-te=
sting.git;a=3Dblob_plain;f=3Dmanagement/management-notes.txt;hb=3Dmaster>
>
> Especially look for all the 'pkcs11' prefixed calls, like
> pkcs11-id-count, pkcs11-id-get. =C2=A0Further James implemented a new fea=
ture
> for the management interface where you can pass the certificate this way
> too. =C2=A0Unfortunately, as Alon pointed out, this has not yet been
> documented well - except in the commit log.

These features are mine. I wrote these.... and the whole PKCS#11 layer,
and many other... like the ability to wrap the iproute2.
They are good, but not great.
Why? Because the openvpn daemon it-self loads the PKCS#11 provider.
This is a security violation.
The PKCS#11 provider should be loaded by the UI, so the daemon cannot
interact with it at will.
It also makes the security openvpn weaker, as foreign library is loaded into
the openvpn process.
And at Windows 7+ there is a problem, a service cannot access the
smartcard readers of the users.
And... even if it can (XP), you cannot use smartcard in remote desktop
session.

Alon.

