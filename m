MIME-Version: 1.0
In-Reply-To: <1848924920.20120228183103@...449...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
Date: Tue, 28 Feb 2012 20:07:29 +0200
Message-ID: <CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
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
To: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/2/28 Carsten Kr=C3=BCger <C.Krueger@...448...>:
>> =C2=A0* New OpenVPN-GUI
>
> Are there any chances to get full non-admin support for windows in versio=
n 2.3 final?
>
> I mean strict seperation between OpenVPN service running with local system
> privileges (can modify routes, etc.) and usermode part (command line, may=
be GUI) that
> interacts with user (start/stop tunnel, ask for passphrase, pin for smart=
card, etc.).
>
> In companies that have security in mind it's impossible to allow
> roadwarriors to connect via openvpn because they would need admin
> privileges.
> Give them only the privilege to start/stop the openvpn service didn't hel=
p because they can't supply credentials.
>
> I'm complaining about this show stoppper for ~4 years :-(
>
> I personally like openvpn very much and would like to deploy it for
> our users but I've to buy Cisco because the windows client is better.

This is *THE* missing functionality in Windows environment.
It seems that nobody interested in developing proper UI using
management interface for Windows.
Same goes to proper smartcard support.

In Linux I am using OpenVPN using unprivileged user (completely!) the
daemon runs under my own user, see[1].

Alon.

[1] http://en.gentoo-wiki.com/wiki/OpenVPN_Non_Root

