Message-ID: <4BA395E5.8010607@...1147...>
Date: Fri, 19 Mar 2010 16:19:01 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4BA34355.5020300@...515...>
In-Reply-To: <4BA34355.5020300@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (18th Mar 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Samuli,

(I'd prefer to be referred to as JJK in minutes ;-) )

see comments below

Samuli Sepp=E4nen wrote:
> Hi,
>
> Here's the summary of the previous community meeting.
>
> ---
>
> COMMUNITY MEETING
>
> Place: #openvpn-discussion on irc.freenode.net
> Date: Thursday, 18th March 2010
> Time: 18:00 UTC
>
> Planned meeting topics for this meeting were on this page:
>
> <http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topi=
cs-2010-03-18>
>
> Next meeting next week, same place, same time. Your local meeting time
> is easy to check from services such as
>
> <http://www.timeanddate.com/worldclock>
>
>
> SUMMARY
>
> Discussed an issue that came up earlier in the mailinglists:
>
>  <http://thread.gmane.org/gmane.network.openvpn.user/29304>
>
> Agreed that allowing two clients to connect with the same certificate
> without "duplicate-cn" being set (as in "first one to connect wins")
> would be harmful and hence unimplementable.
>
> Discussed a potential bug with global config file defaults (e.g. nobind)
> not propagating to <connection> blocks. Agreed that this bug is almost
> certainly invalid and was triggered by misconfiguration. However, Jan
> will check if the OpenVPN man-page requires clarifications in this area.
>
> Discussed Linux TUN/TAP performance and Jan's EPOLL modification
> designed to improve it:
>
>  <http://thread.gmane.org/gmane.network.openvpn.devel/3261/>
>
> Agreed that switching from POLL to EPOLL does not improve overall
> performance enough to justify the change. Also agreed that no action
> should be taken for now, as the TUN/TAP performance is good enough.
>=20=20=20
I did some more tests on the gigabit lan:
- openvpn 1.6.0 (yes the old one) performs worse than 2.1.1
- openvpn 2.1.1 in client-server mode also performs worse than in=20
point-to-point mode, again with compression and encryption fully turned=20
off...

Let's just leave it here , if somebody else has suggestions just let me know


> Discussed this SF.net bug report which was found to be fixed in SVN r3128:
>
> <http://sourceforge.net/tracker/?func=3Ddetail&atid=3D454719&aid=3D201567=
2&group_id=3D48978>
>
> Discussed potential problems with disfunctional proxy servers:
>
> <http://sourceforge.net/tracker/?func=3Ddetail&atid=3D454722&aid=3D184004=
1&group_id=3D48978>
>
> RFC2817 clearly states that proxies need to use this syntax:
>
>  CONNECT host:port/
>
>=20=20=20
that is not entirely correct:

5.2 Requesting a Tunnel with CONNECT

   A CONNECT method requests that a proxy establish a tunnel connection
   on its behalf. The Request-URI portion of the Request-Line is always
   an 'authority' as defined by URI Generic Syntax [2], which is to say
   the host name and port number destination of the requested connection
   separated by a colon:

      CONNECT server.example.com:80 HTTP/1.1
      Host: server.example.com:80

   Other HTTP mechanisms can be used normally with the CONNECT method --
   except end-to-end protocol Upgrade requests, of course, since the
   tunnel must be established first.


the "other HTTP mechanisms" seems to be implemented by some (reverse?)=20
proxy servers ; there are numerous hits in google if you look closely.=20
Still don't know how relevant they are, however

> However, according to the bug report some proxy servers require invalid
> syntax:
>
>  CONNECT http://host:port/
>
> Samuli will try to contact the original bug reporter and will do some
> additional research. If no widely used proxy servers require this
> invalid syntax, this bug report will be closed as wontfix.
>
>=20=20=20
the
> Discussed a potential bug where CN gets mixed up with certificate name
> occasionally after disconnecting. This messes up iptables rulesets and
> status files:
>
> http://article.gmane.org/gmane.network.openvpn.user/29181
>
> Agreed that this may indeed be a bug. Decided to do more research:
>
> - check what happens if disconnect happens before connection has reached
>   ACTIVE state
> - check if this occurs when session is renegotiated (each hour)
>
>
>=20=20=20
I tested it but could not reproduce it using openvpn 2.1.1 ; I forgot to=20
mention last night that the user was *also* using a=20
auth-user-pass-verify script . I duplicated his setup but could not=20
reproduce the problem. However, I had already suggested this fix to him:

diff -Nru multi.c multi.c.patched
--- multi.c	2009-10-24 21:17:29.000000000 -0200
+++ multi.c.patched	2010-03-02 14:57:12.000000000 -0300
@@ -447,6 +447,9 @@
 multi_client_disconnect_setenv (struct multi_context *m,
 				struct multi_instance *mi)
 {
+  /* setenv incoming cert common name for script */
+  setenv_str (mi->context.c2.es, "common_name", tls_common_name(mi->contex=
t.c2.tls_multi, true));
+
   /* setenv client real IP address */
   setenv_trusted (mi->context.c2.es, get_link_socket_info (&mi->context));

and he says the problem is now fixed ! Hmmm I never like it when=20
something is fixed when I don't understand *why* it is fixed...


have a good weekend,

JJK


