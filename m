Message-ID: <1e9a8fb5-22e3-847a-6bcd-98ce8e3f893c@...1227...>
Date: Sat, 4 Feb 2023 14:22:30 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-5-selva.nair@...277...>
 <Y9pTdgI+T90r6PBz@...2685...>
 <CAKuzo_jCb_tcMY6b1MeHJXLQ37cHDcpOSUttKqT9fFuzNL0w5Q@...278...>
 <CAKuzo_jPnumze9KSWA6ywKh-rH3=vrtDZPtWVK-FGrwjgcv=mA@...278...>
 <5fbbea42-096a-f9e9-f230-ccc526e973e2@...1227...>
 <CAKuzo_jTyEnq9-MwT8XePMby7yNXzN-auwx8osYSx16nC-z8zA@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_jTyEnq9-MwT8XePMby7yNXzN-auwx8osYSx16nC-z8zA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] cryptoapi.c: simplify parsing of
 thumbprint hex string
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net


> Thanks a lot for that.
> 
> By adding win32-util.c and -lws2_32 where required, I can now build 
> almost all tests using the autotools framework --- cmocka had to be 
> cross-compiled using cmake which is a pain.
> I do not particularly like cmake though it's convenient for Windows MSVC 
> build, so sticking to autoconf/automake for now. Unless the "consensus" 
> is to move to cmake --- hope not :)

No. Other OpenVPN contributers have spoken out against CMake, so I never 
bothered to clean it up, so that the current cmake file is a mixture of 
clean stuff and hacks. It is pretty useful for me for doing remote 
build/debugging with Clion under macOS/Linux and also when I use Visual 
Studio or Clion under Windows. Even though I think that adding Cmake as 
unsupported build method is a good idea. This would allow others to have 
the same option/advantages like me that prefer cmake to 
autoconf/automake, this also does not seem to have a consensus, so I 
just maintain it for myself in my branch.

Arne



