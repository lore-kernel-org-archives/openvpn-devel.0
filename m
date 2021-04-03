Message-ID: <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
In-Reply-To: <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
 <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
 <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
Date: Sat, 3 Apr 2021 10:32:05 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

>
>>
>> To me it seems like you can of course build a scenario where compression
>> _could_ be a problem some how, but there are certainly many use cases
>> where it can be considered almost impossible to have your security
>> weakaned by compression. I mean, there is also the SSH VPN mode with c<n
>> be used with compression and I've never heard someone saying it's less
>> secure with compression.
>
> That will be also affected by VORACLE style attacks. But SSH VPN and SSH
> is also by no mean safe against these kind of attacks. They might be
> harder to pull off but the underlying attacks still apply.
>
>> In our case where we connect several subnets via OpenVPN and there goes
>> a
>> lot of different traffic from dozens of hosts in every location, I still
>> fail to understand how our security would be impacted by compression?
>
> The attacks are not that easy to understand. So not to patronise you but
> if you if you don't understand it, then it might be better to err on the
> safe side?
>
>> In the end my only question is is it worth to remove compression from
>> OpenVPN in the long run, or is this not planned?
>>
>
> Attacks are becoming better and better if there is a vector to attack.
> But Beast/Crime/VORACLE have shown that these attacks are possible, so
> enabling compression by default is no longer safe.

I'm not asking to enable it by default or even compile it by default. I'm
only asking to keep the code in so those who know what they are doing can
enable it as a compile time option or expert mode option or something like
that.

Simon


