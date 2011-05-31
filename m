MIME-Version: 1.0
In-Reply-To: <4DE4EFA2.9090401@...515...>
References: <20110530162036.GA11197@...1462...>
	<BANLkTimGaCouQO+XE9O=hJ2mkSs0oQh-hpJEW+=+_qAkD_92Pw@...278...>
	<4DE4EFA2.9090401@...515...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Tue, 31 May 2011 18:53:01 +0200
Message-ID: <BANLkTinspz-TXPTqbgxEVrgF=FSjQs0q4+y44fLUxVi=7G5mUA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] USE_PF_INET6 by default for v2.3
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
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: David Sommerseth <dazo@...384...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, May 31, 2011 at 3:39 PM, Samuli Sepp=E4nen <samuli@...515...> wrote:
> JuanJo Ciarlante ha scritto:
>> On Mon, May 30, 2011 at 6:20 PM, JuanJo <jjo+ml@...410...> wrote:
>>
>>> - put all #ifdef'd code in place, kill the cpp symbol,
>>> - thus in v2.3 it's not actually possible to --disable-ipv6 :)
>>>
>>> RATIONALE:
>>> =A0#1 some wacky compilers choke on #ifdef'd constructions for
>>> =A0 =A0concatenated strings, and given that:
>>> =A0#2 v2.3 has already transport ipv6 by default
>>> =3D> doesn't justify putting effort on #1 to keep USE_PF_INET6
>>> =A0 ifdef wraps.
>>>
>>> Signed-off-by: JuanJo Ciarlante <jjo+ml@...410...>
>>> <...snip...>
>>>
>>
>> FWIW you can also peek at the diff at:
>> =A0 https://github.com/jjo/openvpn-ipv6/commit/77fed9c07c1461cd926ab4e86=
c587cac8414b957
>> =A0 http://codereview.appspot.com/4564045/
>>
>> Cheers,
>>
> Hi JuanJo,
>
> This patch did not apply on top of the earlier "Visual Studio 2008 build
> fix" patches applied on top of "master". There was one whitespace error
> and it choked on syshead.h due to a new #include. Besides that it worked
> great!

Thanks Samuli for stuffing those bits :) !

>
> A fixed patch is attached.

Shameless ACK 8)

Cheers,

>
> --
>
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

