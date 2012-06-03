MIME-Version: 1.0
In-Reply-To: <20120603101127.GL400@...1296...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-7-git-send-email-arne@...1227...>
	<4FCA40E3.8000205@...1114...> <4FCA433B.4070502@...1227...>
	<20120603101127.GL400@...1296...>
Date: Sun, 3 Jun 2012 14:34:01 +0300
Message-ID: <CAOazyz0LO7Dbe5Rq5JAJKoXN+STbxsE2mkiLhtjNcjMAvaPCrw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 6/8] Allow routes to be set before
 opening tun, similar to ifconfig before opening tun
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

Gert,
You can see the tun branch[1].
I changed this per platform.
Alon.

[1] https://github.com/alonbl/openvpn/commits/tun
[2] https://github.com/alonbl/openvpn/commit/4d2fc1f21e6c5cba163ec481119370=
235c736672

On Sun, Jun 3, 2012 at 1:11 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sat, Jun 02, 2012 at 06:45:47PM +0200, Arne Schwabe wrote:
>> > returning a macro value, instead of just redefine the
>> > ROUTE_ORDER_DEFAULT macro for those platforms who need ROUTE_AFTER_TUN
>> > and use the ROUTE_ORDER_DEFAULT macro directly where needed?
>> >
>> > And for type-safety, would it be better to use an typedef enum instead?
>> I just followed the IFCONFIG_AFTER_TUN/BEFORE_TUN which already is in
>> place. Just using the defines is fine for me too but it should be
>> consistend for both options.
>
> I've always wondered why IFCONFIG_AFTER_TUN has been done that way, as
> it seemed confusing - it sort of looks like it was done with the option
> to change it at run-time later, but I don't really see where this would
> make sense. =C2=A0Today all unix platforms have one variant, Windows has =
the
> other one, and reversing order for either isn't going to work...
>
> So I would opt for "no function for ROUTE_ORDER_DEFAULT", and put
> cleaning up the IFCONFIG_AFTER_TUN stuff on someones TODO list :-) - but
> we could check that one with James...
>
> (JFTR, OpenBSD used to have IFCONFIG_BEFORE_TUN as the single exception
> besides Windows - but that looked like "the one who did the port not
> understanding how tun(4) works on OpenBSD" - I changed it to
> IFCONFIG_AFTER_TUN and that cleaned up quite a bit of special cases
> in the code, and it works better than ever before :-) )
>
>
> What I'm also not really happy in the current implementation of both
> options is that all order variants get compiled-in, instead of just
> having what the platform in question needs. =C2=A0But that's more intrust=
ive
> surgery...
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

