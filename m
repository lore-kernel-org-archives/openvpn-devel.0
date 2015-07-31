MIME-Version: 1.0
In-Reply-To: <20150731091257.GC3164@...2050...>
References: <20150730233727.GW3676@...2049...>
	<CAFHpkQGqdJdpz_FTPWzsziNHbMCt3DOwkLHA8BXU9M+-+Cv_mA@...278...>
	<20150731091257.GC3164@...2050...>
Date: Fri, 31 Jul 2015 14:54:02 +0500
Message-ID: <CAFHpkQFk5nB9U655hh3TKn_BsVVBR_q8tibVDc7XhYTgKC1Jkg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
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
To: Samuel Thibault <samuel.thibault@...1817...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

auth-user-pass-verify  is not as powerfull as "so" plugin.
my plugin is synchronous by nature.

however, if your are familiar with c#, it might be easier to implement
things like username manipulation,

for instance, we used to transform usernames like 'domain\user' and
'user@...2051...' to just 'user'
it is too early to talk about central repository, currently I'm the
only user of that plugin

2015-07-31 14:12 GMT+05:00 Samuel Thibault <samuel.thibault@...1817...>:
> =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD, le F=
ri 31 Jul 2015 14:09:51 +0500, a =C3=A9crit :
>> I've rewritten radius thing with .net, my plugin performs queries to
>> multiple radius servers in parallel, I'm using it with Mono in
>> production for few months:
>>
>> https://github.com/skbkontur/openvpn-auth-radius
>>
>> I can help with that plugin if you are interested
>
> Mmm, it'd be great if the openvpn-auth-radius plugin could have a
> central repository, instead of a flurry of patched versions...
>
> Samuel

