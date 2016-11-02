MIME-Version: 1.0
In-Reply-To: <20161102084852.vpeprssx3btfvini@...30...>
References: <2987ae32-9a53-1888-11af-bf7d9741eecd@...2080...>
	<981f9961-a72f-727a-37de-a2741c8d73c9@...1227...>
	<4c5d5326-1ebe-95d0-9e0e-d3d6f1ef06d6@...515...>
	<20161102084852.vpeprssx3btfvini@...30...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 2 Nov 2016 10:32:22 +0100
Message-ID: <CAA1Abx+vU=GOCXaJ2mk33e+B=YtDCGEjaxfEmD6uHHppJ7qDNA@...278...>
Subject: Re: [Openvpn-devel] OpenVPN v2.4 release progress
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 2 November 2016 at 09:48, Alberto Gonzalez Iniesta <agi@...64...> wrote:
> I don't know if 2.4 addresses building with openssl 1.1 [1], but that
> would be a plus.

Not yet. The 1.1 API in considerably different from 1.0.x.  Switching
is not very hard, but supporting both 1.0.x and 1.1 needs some work.
I would like to get this done before 2.4.0, but cannot make any
promises...  I'll put it on the release status page.

-Steffan

