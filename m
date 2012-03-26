MIME-Version: 1.0
In-Reply-To: <20120326160546.GV1359@...1296...>
References: <20120326160546.GV1359@...1296...>
Date: Mon, 26 Mar 2012 19:51:01 +0200
Message-ID: <CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 6:05 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> one of the things the new build system brought is us is *this*:
>
> if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include =C2=A0-I../../src/=
compat =C2=A0 =C2=A0 =C2=A0-I/usr/include -I/usr/include =C2=A0 =C2=A0 -g -=
O2 -MT ssl_verify_polarssl.o -MD -MP -MF ".deps/ssl_verify_polarssl.Tpo" -c=
 -o ssl_verify_polarssl.o ssl_verify_polarssl.c; =C2=A0then mv -f ".deps/ss=
l_verify_polarssl.Tpo" ".deps/ssl_verify_polarssl.Po"; else rm -f ".deps/ss=
l_verify_polarssl.Tpo"; exit 1; fi
> if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include =C2=A0-I../../src/=
compat =C2=A0 =C2=A0 =C2=A0-I/usr/include -I/usr/include =C2=A0 =C2=A0 -g -=
O2 -MT status.o -MD -MP -MF ".deps/status.Tpo" -c -o status.o status.c; =C2=
=A0then mv -f ".deps/status.Tpo" ".deps/status.Po"; else rm -f ".deps/statu=
s.Tpo"; exit 1; fi
> if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include =C2=A0-I../../src/=
compat =C2=A0 =C2=A0 =C2=A0-I/usr/include -I/usr/include =C2=A0 =C2=A0 -g -=
O2 -MT tun.o -MD -MP -MF ".deps/tun.Tpo" -c -o tun.o tun.c; =C2=A0then mv -=
f ".deps/tun.Tpo" ".deps/tun.Po"; else rm -f ".deps/tun.Tpo"; exit 1; fi
>
> ... instead of straightforward "gcc" invocations.
>
> ... and I wonder what the benefit is? =C2=A0I find it much harder to see =
what
> "make" is doing here (my eyes hurt when I look at this!), and unless there
> is a clear benefit, I don't like adding convolutions...

The benefit is to divide the code into libraries and core which is
easier to maintain and reuse.

Anyway, new automake does support silent rules, try the following[1]
patch and see if it makes you happier.

Again, this demonstrate how current merge procedure is inappropriate,
as instead of single build system rewrite merge we have aftershocks.
Branch should be tested and  reviewed, and tested and reviewed until
no known issues found, and all happy of its quality.

Alon.

[1] https://github.com/alonbl/openvpn/commit/c35c118767d4867303e43c4472720d=
d94187aae5

