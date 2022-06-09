Message-ID: <f203baba-6be0-71b6-8a22-86190ebcdaf9@...2181...>
Date: Thu, 9 Jun 2022 19:05:06 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <f1dde3516874c6b9bec11fcbd121fad9@...2675...>
 <6db98ba0-9f0b-54dc-6c8c-cf06b5b79016@...376...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <6db98ba0-9f0b-54dc-6c8c-cf06b5b79016@...376...>
Subject: Re: [Openvpn-devel] Fwd: Bug#1012567: openvpn --mktun --dev-type
 tap --dev tap2 fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Bernhard Schmidt <berni@...376...>, openvpn-devel@lists.sourceforge.net

Hi Bernhard,

Thanks a lot for forwarding the bug - it's a nice catch.

Will work on a fix.

Regards,

On 09/06/2022 17:24, Bernhard Schmidt wrote:
> Hi,
> 
> I've received the following bug report for the dco-enabled OpenVPN 2.6 
> build currently sitting in Debian unstable. It looks like DCO is 
> interfering with the CLI option to create a tap interface.
> 
> Bernhard
> 
> 
> 
> ---
> Package: openvpn
> Version: 2.6.0~git20220518+dco-2
> Severity: important
> 
> Since 2.6.0~git20220518+dco-2 the following command fails:
> 
> openvpn --mktun --dev-type tap --dev tap2
> 
> with
> 
> Assertion failed at dco_linux.c:442 (tt-type == DEV_TYPE_TUN)
> Exit due to fatal error
> 
> 
> I don't have dco support in the linux kernel.
> 
> 
> openvpn --disable-dco --mktun --dev-type tap --dev tap2
> 
> 
> works as a workaround, but I think --mktun --dev-type tap should 
> continue to work without it.
> 
> Regards,

-- 
Antonio Quartulli

