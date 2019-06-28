References: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
 <20190626063502.GS1097@...1296...>
 <9f92ae0a-cae6-39bd-932b-fa977686f27a@...1227...>
 <CAFHpkQFn0Yn8dWya9H=EgC4MLugvrpHLkA=-eqyscQWZy_eDCw@...278...>
 <2d1c2e8a-7f60-6a40-164e-f8657d6f2103@...1227...>
 <20190627073924.GB1097@...1296...>
 <CAFHpkQEuGSh+7Mn1F17Ri7sqnhprnygAMpK3sXL19M-fHMHBbA@...278...>
 <20190628074952.GS1097@...1296...>
 <CAFHpkQGK6Z1FxPiL_V-=FNddREm4MTuRR5LOnDwkcC6+vxFs_w@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4393beee-7ce5-195f-5ec8-a738c161e789@...1227...>
Date: Fri, 28 Jun 2019 11:19:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGK6Z1FxPiL_V-=FNddREm4MTuRR5LOnDwkcC6+vxFs_w@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] how to migrate users to "no compression" config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 28.06.19 um 10:26 schrieb Илья Шипицин:
> 
> 
> пт, 28 июн. 2019 г. в 12:49, Gert Doering <gert@...1296...
> <mailto:gert@...1296...>>:
> 
>     Hi,
> 
>     On Fri, Jun 28, 2019 at 12:14:40PM +0500, ???????? ?????????????? wrote:
>     > by "high level" compression doc I mean something like that
>     >
>     > a) road warrior scenario (remote access for enterprise users) -
>     should we
>     > enable compression ? or traffic usually is compressed ? RDP is
>     compressed ?
>     > any way to estimate compression (like $gzip_ratio in nginx)
>     > b) lz4, lzo, ... which one to choose ?
>     > c) how to push compression settings, best practices on that
>     >
>     > @mattock, what do you think, should some such documentation present on
>     > https://openvpn.net ?
> 
>     The high level document should propably specify "do not use compression
>     at all, unless you have a specific need".
> 
> 
> I agree with that. It might not be very obvious.

The async compression patch will introduce warnings and docs to tell you
not to use compression and will default to async compression effectively
disabling it when used on both ends.

Arne

