MIME-Version: 1.0
In-Reply-To: <20101215085647.GY12709@...1296...>
References: <AANLkTimYvqT7KLT0bwJQzMmNC2vcnbBaZY7NEN36JvAD@...278...>
	<20101215085647.GY12709@...1296...>
Date: Wed, 15 Dec 2010 10:34:30 -0800
Message-ID: <AANLkTikeUw8dGeQePEiMwjYZGBQLkerkXHRfpTOu6ntZ@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Subject: Re: [Openvpn-devel] Getting src-IP/port from 'struct context'...
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

That works. Thanks a lot.

Vineet

On Wed, Dec 15, 2010 at 12:56 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Dec 14, 2010 at 03:16:53PM -0800, Vineet Kumar wrote:
>> =A0 Is there a straightforward way to print source IP address and port
>> given a 'struct context' pointer?
>
> If I read code and structures right, it's in
>
> =A0context_pointer->c2->to_link_addr->dest
>
> and there's a number of calls in forward.c that do:
>
> =A0print_link_socket_actual (c->c2.to_link_addr, &gc),
>
> (which doesn't actually *print*, but return a string that can be used
> in msg() - see the code examples in forward.c)
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 gert@...1296...
> fax: +49-89-35655025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gert@=
...1297...
>

