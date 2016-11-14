MIME-Version: 1.0
In-Reply-To: <e95b939e-9486-eaf4-b351-4423c7dbfd33@...2080...>
References: <1479153490-6259-1-git-send-email-steffan@...1856...>
	<1479153967-6788-1-git-send-email-steffan@...1856...>
	<e95b939e-9486-eaf4-b351-4423c7dbfd33@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 14 Nov 2016 22:42:04 +0100
Message-ID: <CAA1AbxJsvrMnGyg61hOvwR7AU=-30nott90=Q91oP8VBmZDb+Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Deprecate key-method 1
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

On 14 November 2016 at 22:35, David Sommerseth
<openvpn@...2080...> wrote:
 On 14/11/16 21:06, Steffan Karger wrote:
>> Key method 2 has been the default since OpenVPN 2.0, and is both
>> more functional and secure.  Also, key method 1 was only ever
>> supported for peer-to-peer connections (i.e. not for
>> client-server).
>>
>> Let's get rid of some legacy and phase out key method 1.
>>
>> v2: add Changes.rst entry, and update man page
>>
>> Signed-off-by: Steffan Karger <steffan@...1856...> --- Changes.rst
>> | 7 +++++++ doc/openvpn.8         | 5 ++++- src/openvpn/options.c |
>> 6 ++++++ 3 files changed, 17 insertions(+), 1 deletion(-)
>
> I wanted to give this an ACK ... but I think we should just remove it
> all together as we seem to be in a broken state already.
>
> /usr/sbin/openvpn --dev tun --local 192.168.122.1 --lport 1194 \
>          --remote 192.168.122.100 --rport 194 \
>          --secret ../../sample/sample-keys/ta.key 0 \
>          --ifconfig 10.8.0.10 10.8.0.20 --verb 3 \
>          --key-method 1
> Options error: Parameter key_method can only be specified in TLS-mode,
> i.e. where --tls-server or --tls-client is also specified.
> Use --help for more information.
>
> That is with /usr/sbin/openvpn --version:
> OpenVPN 2.3.11 x86_64-redhat-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL]
> [PKCS11] [MH] [IPv6] built on May 10 2016
>
> So unless I messed up my simple and stupid static key p2p mode tunnel,
> this doesn't work at all with v2.3.  And git master haven't "fixed"
> this issue.
>
> If nobody noticed this by now, then nobody really uses --key-method.

Well, the options parser is right:  --key-method should be used
together with --tls-server and --tls-client.  Use e.g. the
loopback-server and loopback-client configs from sample/sample-configs
to test this.

-Steffan

