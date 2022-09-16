Message-ID: <9b1dc0d0-2c39-54bd-bbd3-28f337f22baf@...1227...>
Date: Fri, 16 Sep 2022 11:37:27 +0200
MIME-Version: 1.0
References: <20220422142953.3805364-17-arne@...1227...>
 <20220511110810.1944975-1-arne@...1227...> <2553370.Lt9SDvczpP@...2664...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <2553370.Lt9SDvczpP@...2664...>
Subject: Re: [Openvpn-devel] [PATCH v3 26/28] Allow setting control channel
 packet size with tls-mtu
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net


Am 16.09.2022 um 02:47 schrieb Heiko Hund:
> This patch need to be rebased again, does not apply to master anymore:
> checking file src/openvpn/ssl.c
> Hunk #1 succeeded at 297 (offset 1 line).
> Hunk #2 FAILED at 321.
> Hunk #3 succeeded at 1256 (offset -42 lines).
>
> On Mittwoch, 11. Mai 2022 13:08:10 CEST Arne Schwabe wrote:
>> @@ -141,6 +147,8 @@ User-visible Changes
>> +- control channel packet maximum size is no longer influenced by ``--link-
> mtu``/``--tun-mtu``
>> +  and must be set by ``--tls-mtu`` now.
> Must it or is there still some cc-mtu derivation in place in case it is not
> given? If not, wouldn't it make sense to at least catch obvious breakage.
> Usually link/tun-mtu is lowered for that reason. Further down in the patch
> there are min/max_int() calls in tls_init_control_channel_frame_parameters(),
> do they do what I suggested here already?

The current code is really broken and also if you lower it too much it 
just stops completely working as it for example will try to send a push 
message that is too large to fit the size. So I decided to use a clean 
sheet approach here. And the current tls-mtu default is 1200 or 
something similar anyway. So it is unlikely to break on any normal 
connection.


>> diff --git a/doc/man-sections/link-options.rst
>> +--tls-mtu size
> Is --tls-mtu the best name for the option we can come up with? From my outside
> perspective (can hardly spell mtu right) the "tls" part is somewhat misnamed,
> as this is an SSL VPN after all. When you know that the framing for the data
> channel is not TLS you can make sense of it, but who does.
It fits the naming of the other options we have. But if you can come up 
with a better naming, I am all ears.
>
>> +  The maximum packet size includes encapsulation overhead like UDP
>> and IP.
>> \ No newline at end of file
> ^ this
>
>> +    int tls_mtu;         /* Maximum MTU for the
>> control channel messages */
> The "M" already stands for "Maximum".
>
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

