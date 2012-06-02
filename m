Message-ID: <4FCA2301.2020307@...1227...>
Date: Sat, 02 Jun 2012 16:28:17 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FCA1FD3.9020407@...1227...>
	<CAOazyz0Ymgb32cHjWhpjBVC+JRw20tN4oV0aBUhqY7U+zu35nQ@...278...>
In-Reply-To: <CAOazyz0Ymgb32cHjWhpjBVC+JRw20tN4oV0aBUhqY7U+zu35nQ@...278...>
Subject: Re: [Openvpn-devel] Build broken on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: OpenVPN Devel <openvpn-devel@lists.sourceforge.net>

Am 02.06.12 16:19, schrieb Alon Bar-Lev:
> Hello,
>
> On Sat, Jun 2, 2012 at 5:14 PM, Arne Schwabe <arne@...1227...> wrote:
>> Hello,
>>
>> while preparing my patches for OS X I also noticed that the build is
>> broken on OS X:
>>
>> [...]
>> checking net/if_tun.h usability... no
>> checking net/if_tun.h presence... no
>> checking for net/if_tun.h... no
>> checking net/tun/if_tun.h usability... no
>> checking net/tun/if_tun.h presence... no
>> checking for net/tun/if_tun.h... no
>> checking linux/if_tun.h usability... no
>> checking linux/if_tun.h presence... no
>> checking for linux/if_tun.h... no
>> checking tap-windows.h usability... no
>> checking tap-windows.h presence... no
>> checking for tap-windows.h... no
>> configure: error: no tap header could be found
>>
>>
>> The bad commit is: 7cacdfd4b7f221139e0d2a0334f1f1cd8f2a1b75
>>
>>    build: tap: search for tap header
> Can you please tell me which tap header is expected and send me the
> config.log as well? or just send me the config.log...
I have no idea what header is expected but I think none. config.log is
available here: http://plai.de/.tmp/config.log

>> It aborts build if no tap headers is found. If the check is disabled
>> configure works but the build still does not work.
>>
>> In the INSTALL file  --with-lzo-headers and --with-lzo-lib is mentioned,
>> which do not work:
>>
> <snip>
>
>> LZO_CFLAGS="-I/opt/local/include" LZO_LIBS=-L/opt/local/lib ./configure
> This should have been:
> LZO_CFLAGS="-I/opt/local/include" LZO_LIBS="-L/opt/local/lib -llzo" ./configure
>
> The -llzo is also needs in XXX_LIBS phrase.
>
The INSTALL file then needs to be updated to reflect the change.

Arne

