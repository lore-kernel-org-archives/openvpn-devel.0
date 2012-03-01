MIME-Version: 1.0
In-Reply-To: <12822827.2NuMshZZBO@...1526...>
References: <4F4CE4FE.3010009@...515...>
	<20120229154604.GA7024@...1296...>
	<1056463883.20120229194318@...449...> <12822827.2NuMshZZBO@...1526...>
Date: Thu, 1 Mar 2012 11:22:38 +0200
Message-ID: <CAOazyz06Ba-FLzm2i15we1tt4tkvV=gzQBadh0TuhzfPWLQW9A@...278...>
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, openvpn-devel@lists.sourceforge.net

2012/3/1 Heiko Hund <heiko.hund@...1489...>
>
> On Wednesday 29 February 2012 18:43:18 Carsten Kr=C3=BCger wrote:
> > What operation could be in script that is usefull when it's executed
> > in user context.
>
> On Windows you could mount a CIFS share from the corporate LAN to the
> drive
> letter a user expects her data at, for example.

Right.
But this is similar to "logon script" just "connect script" which can
be run by the UI when it receives connect event.
Also, (technically) impersonation token cannot be used for network access.
So the solution of impersonating to user will not allow a script to
mount remote filesystem.

Alon.

