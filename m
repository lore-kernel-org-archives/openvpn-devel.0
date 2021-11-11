MIME-Version: 1.0
References: <20211108135314.148-1-lstipakov@...277...>
 <CAKuzo_jCzuJ3xvwAdM_YHz6Zu-kHr19kZV-vmvP3k1_2UAE+hw@...278...>
In-Reply-To: <CAKuzo_jCzuJ3xvwAdM_YHz6Zu-kHr19kZV-vmvP3k1_2UAE+hw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 11 Nov 2021 10:38:40 +0200
Message-ID: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun: improve DHCP server address
 calculation for small subnets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

> Why not just use 0 offset always? Perpetuating this dance of 0 offset in =
some cases, -1 otherwise is not a way forward. Also see my patch from 2015 =
that never got any traction. I have lost touch with the context, so, I'm no=
t sure whether this addresses the same (apart from code changes) or somethi=
ng related.
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/1449454660=
-20050-1-git-send-email-selva.nair%40gmail.com/#msg34674818
>
> Also: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g13413.html and other messages in that thread.

Thanks for pointing me out to this, obviously I missed your original
patch and that discussion.

I don't know why there is an offset in the first place for both
openvpn2 and openvpn3, there is probably some reason for it? I wanted
to be on the safe side and use a network address for some cases only
(small subnet). If you think it is safe to always use 0, let's do that
- I can send V2.

I tried to apply your patch but it doesn't apply anymore - tun.c has
changed a lot since 2015.

What comes to discussion about getting rid of the offset option -
since the syntax is like this:

  --ip-win32 dynamic [offset] [lease-time]

we cannot just remove [offset] since we might break configurations
which set [lease-time].

--=20
-Lev

