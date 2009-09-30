MIME-Version: 1.0
In-Reply-To: <200909301941.01923.mailinglists@...1145...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...> 
	<200909301941.01923.mailinglists@...1145...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Wed, 30 Sep 2009 20:20:40 +0200
Message-ID: <7bb795fd0909301120veaf5f48gb65b081cd2cb09a3@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
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
To: =?ISO-8859-1?Q?Marcel_Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Marcel,

On Wed, Sep 30, 2009 at 7:41 PM, Marcel Pennewi=DF
<mailinglists@...1145...> wrote:
> On Friday 25 September 2009 23:36:19 JuanJo Ciarlante wrote:
>> Hi,
>>
>> I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
>> please refer to README.ipv6[1] and TODO.ipv6[2] for more details.
>
> OpenVPN 2.1-rc19 crashs on Gentoo (Xen DomU, AMD64( using tcp6-server with
>
> Sep 30 19:42:00 larissa openvpn[25441]: Assertion failed at socket.c:1620
> Sep 30 19:42:00 larissa openvpn[25441]: Exiting
>
> and segfaulted using "tcp-server"
>
> Sep 30 19:39:09 larissa openvpn[25238]: segfault at 0000000000000002 rip
> 00002b3486469fd0 rsp 00007fff254e9c98 error 4
>
> {...snip...}

Could you please copy me the the exact cmdline and context (inetd?)
you are using in both cases?, also if there's any extra patch applied, etc.

Thanks a lot,

>
> Any ideas?
>
> Marcel
>
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

