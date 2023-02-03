Message-ID: <5fbbea42-096a-f9e9-f230-ccc526e973e2@...1227...>
Date: Fri, 3 Feb 2023 11:25:32 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-5-selva.nair@...277...>
 <Y9pTdgI+T90r6PBz@...2685...>
 <CAKuzo_jCb_tcMY6b1MeHJXLQ37cHDcpOSUttKqT9fFuzNL0w5Q@...278...>
 <CAKuzo_jPnumze9KSWA6ywKh-rH3=vrtDZPtWVK-FGrwjgcv=mA@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_jPnumze9KSWA6ywKh-rH3=vrtDZPtWVK-FGrwjgcv=mA@...278...>
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
To: Selva Nair <selva.nair@...277...>, Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net


> Well, replying to myself:
> 
> I tried building the unit tests using cmocka for Windows  
> (cross-compiling using mingw-w64 with locally built cmocka). 
> Unfortunately, none of the tests could be built out of the box because 
> of missing dependencies, so I guess no one is running these tests on 
> Windows.
> 
> Good news is that I could get provider_testdriver to build and run on 
> Windows with minor tweaks and a test for this patch could be easily 
> written too.
> 
> I can follow up with a test patch, but wonder whether it's worth 
> spending time on if no one else is building these tests for Windows.

I have a cmake build file for OpenVPN that actually builds part of the 
unit tests ("test_packet_id" "test_crypto" "test_ncp" "test_auth_token" 
"test_misc" "test_buffer" "test_provider" "test_pkt") and run them in 
the Github actions pipeline. But the cmake stuff is more "work in 
progress" and the general consensus was to stick with the autoconf 
approach.

I looked into building the test binaries as part of the normal MSVC 
build but gave up on trying to figure out how to deal with MSVC and 
their solutions, especially since you can nowadays just point it at a 
CmakeLists.txt and it will pick that up just fine.

If you want to take a look:

Cmake build file: 
https://github.com/schwabe/openvpn/blob/bloom/CMakeLists.txt

Running tests as part of GHA: 
https://github.com/schwabe/openvpn/blob/bloom/.github/workflows/build.yaml#L561

Arne

