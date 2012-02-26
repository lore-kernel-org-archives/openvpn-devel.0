MIME-Version: 1.0
In-Reply-To: <4F4A70B6.6070309@...1667...>
References: <4F4A70B6.6070309@...1667...>
Date: Sun, 26 Feb 2012 20:09:01 +0200
Message-ID: <CAOazyz1-gWWy2ns00RsXxZVCfTfa9LzpKGFTCXdbYqYDsnCTdw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Allow management socket over inherited
 file descriptor
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
To: mark <mnunberg@...1667...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Feb 26, 2012 at 7:49 PM, mark <mnunberg@...1667...> wrote:
> =C2=A0From e15b874fdd05e9952e94e36292b57071e96127ed Mon Sep 17 00:00:00 2=
001
> From: Mark Nunberg <mnunberg@...1667...>
> Date: Sun, 26 Feb 2012 09:37:33 -0800
> Subject: [PATCH] Allow management socket over inherited file descriptor
>
> Allows a direct management channel over a forked-and-execed openvpn
> process (or possibly other means) instead of having to use a bound TCP
> or UNIX socket. Helpful for wrapper applications and advanced scripts,
> so that they leave less clutter in the local connection table and/or
> filesystem
> ---

Most implementations separate between the privileges required to ran
the daemon and he privileges requires to run the management logic.

Why is this actually needed? And why do you think the unix sockets are
insufficient?

Alon.

