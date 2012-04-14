MIME-Version: 1.0
In-Reply-To: <105880166.20120410231624@...449...>
References: <105880166.20120410231624@...449...>
Date: Sat, 14 Apr 2012 20:23:30 +0300
Message-ID: <CAOazyz1U=yJQyWFPPgaiJSbd96+d-DFME0FRWpE1TXZxTda9ZA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] FYI: OpenVPN client for Windows that is working
 non-admin - securepoint client
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
Cc: openvpn-devel@lists.sourceforge.net

2012/4/11 Carsten Kr=C3=BCger <C.Krueger@...448...>:
> I don't know if this is well known:
> http://sourceforge.net/projects/securepoint/

No,  I did not know it.
And it is dutch documentation...
From what I understand it uses IPC to run openvpn in privilege account.
And it uses Qt for UI, which is great.

It does not handle privilege separation any better than running
openvpn as privileged service and using the management interface to
access it.

Thanks for the link.
Alon.

