MIME-Version: 1.0
In-Reply-To: <20120326102307.GP1359@...1296...>
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
	<CAOazyz2YYdfVYekhQEZu_sFXwXa7nRx5s3M=M2NhdHegZqt8Bw@...278...>
	<20120326102307.GP1359@...1296...>
Date: Mon, 26 Mar 2012 12:31:58 +0200
Message-ID: <CAOazyz1yULF1jkPRGOQriuetsdiUo5PbNVJybSURWPAKgQZMNA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
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
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Mon, Mar 26, 2012 at 12:23 PM, Gert Doering <gert@...1296...> wrote:
>> Can you please send me the config.log?
>> I will fix that.
>
> I'll send the config.log off-list.

Thanks!
I should not have tested the dependency of libdl and plugins.
I guess you can work around this by adding DL_LIBS=" " to configure.

Alon.

