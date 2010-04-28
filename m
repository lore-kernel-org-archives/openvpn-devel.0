MIME-Version: 1.0
In-Reply-To: <1272463949884053500@...1315...>
References: <4BD83FC0.5090607@...515...> <1272463949884053500@...1315...>
Date: Wed, 28 Apr 2010 17:24:31 +0300
Message-ID: <n2n9e0cf0bf1004280724s6c4280c6xb58950c706123e4c@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
	proxying code to use "new" InternetQueryOption API?
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
To: openvpn@...1315...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

The IE API is user specific.
As OpenVPN runs as a service using own user or system account, IE API
is not suitable.
Using WinHTTP indeed looks better.

2010/4/28  <openvpn@...1315...>:
> Hi Samuli,
>
>
>
> Very interesting timing! Just last night I was poking about about this a
> bit, and I'm not so sure that the proxy approach noted so far is the best=
 /
> right way to do this. Rather, to be able to handle dynamic (not just stat=
ic)
> proxy configurations the WinHTTP API looks to me to be the way to do this
> (see http://msdn.microsoft.com/en-us/library/aa384097(v=3DVS.85).aspx=C2=
=A0for an
> example).
>
>
>
> I hope this helps!
>
>
>
> ... Russell
>
>
>
>
>
> On Wed, Apr 28, 2010 09:01 AM, Samuli=C2=A0Sepp=C3=A4nen=C2=A0<samuli@...493...=
515...> wrote:
>
> Hi all,
>
> A while back a user noticed that OpenVPN still uses old IE4 API to
> detect proxy settings (e.g. in proxy.c and ieproxy.c). This apparently
> causes problems with IE's proxy detection on some Windows installations.
> A "new" InternetQueryOption API was introduced in IE5, so this part of
> OpenVPN would benefit from an upgrade anyways. Would somebody be
> interested in taking up this task? We seem to have a shortage of Windows
> devs, so any help would be most welcome!
>
> For more information about this issue can be found from here:
>
> * http://thread.gmane.org/gmane.network.openvpn.devel/3446
> * http://support.microsoft.com/kb/226473
>
> If I've misunderstood the problem, please send clarifications - proxy
> usage in OpenVPN is still pretty vague to me :)
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
> -------------------------------------------------------------------------=
-----
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

