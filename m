From: Antonio Quartulli <a@...2181...>
References: <20201023113431.26691-1-arne@...1227...>
 <20201023113431.26691-2-arne@...1227...>
 <20201024194301.GB976@...1296...>
 <c0f890fb-bd6c-1e76-7316-590c95bfb34e@...1227...>
 <46c513d0-8b2f-d4db-427f-c8d39e8a659f@...2181...>
 <fdbab89d-80ba-07da-eb91-b23e116232d3@...2181...>
Message-ID: <2f797214-318b-fb3d-944c-3bf3101aa504@...2181...>
Date: Tue, 30 Mar 2021 17:34:51 +0200
MIME-Version: 1.0
In-Reply-To: <fdbab89d-80ba-07da-eb91-b23e116232d3@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/5] xmit_hold is only required for
 port_share
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 25/03/2021 22:55, Antonio Quartulli wrote:
> Hi,
> 
> On 25/03/2021 22:37, Antonio Quartulli wrote:
>> Anybody can see why we need that for port-share?
>> I'd rather try to understand the above and ditch this member entirely,
>> if the answer is "we don't need it".
> 
> After more tests I indeed recovered the reason why this is needed with
> port-share.
> 
> If we don't "hold back", upon connection the server will send its own
> SERVER_HARD_RESET, regardless of the client having sent a
> CLIENT_HARD_RESET or not.
> 
> This behaviour indeed breaks port-share because the non-OpenVPN
> application on the other side will receive an unexpected packet and will
> most likely kill the connection.
> 
> For this reason we need to hold any control channel packet until we have
> confirmed that the first packet is indeed a CLIENT_HARD_RESET.
> 
> 
> Regarding TCP, the only thing I can think about is that this flag helps
> mimicking UDP: instead of sending the HARD_RESET right after a TCP
> Connection is opened, the server will wait for the client packet first.
> 
> In UDP I presume this is standard behaviour as we have no connection
> opening event.
> 
> My guess is that this behaviour may be useful to avoid race conditions
> on the client where the SERVER_HARD_RESET is received when still unexpected?
> 

As discussed on IRC we don't really need this "hold" behaviour in our
protocol.

I may ask "why changing the current state though?", but I believe
removing state variables from our code base (or some of its branches) is
a good step towards simplification.


My last nitpick would be to change the commit message, since now we have
clarified how this works:

----
The xmit_hold flag is used to tell OpenVPN to not send any packet out
before a RESET is received from the other peer upon new connection.

The only real use case for setting this flag to true is when configuring
OpenVPN with port-share (TCP).

The reason being that OpenVPN server should not send any packet until it
is confirmed that the connection was established by an actual OpenVPN
client. If the connection was established by a non-OpenVPN client,
sending a RESET will mess up with the protocol sharing the port.
----

* Basic TCP connection tests passed.
* Compiled in my gitlab CI *WITH* issues:

MINGW32 both 32bit and 64bit failed:

i686-w64-mingw32-gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include
-I../../include -I../../src/compat -DWIN32_LEAN_AND_MEAN
-DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA
-I/builds/ordex986/openvpn/tap-windows-9.21.2/include
-I/root/opt/include -I/root/opt/include  -I/root/opt/include
-DPLUGIN_LIBDIR=\"/usr/local/lib/openvpn/plugins\" -municode -UUNICODE
-Wall -Wno-unused-parameter -Wno-unused-function
-Wno-stringop-truncation -g -O2 -std=c99 -MT lzo.o -MD -MP -MF
.deps/lzo.Tpo -c -o lzo.o lzo.c
In file included from buffer.h:28,
                 from mtu.h:27,
                 from win32.h:30,
                 from init.c:36:
init.c: In function 'do_open_tun':
init.c:1809:62: warning: cast from pointer to integer of different size
[-Wpointer-to-int-cast]
     msg(D_ROUTE, "interactive service msg_channel=%" PRIu64, (unsigned
long long) c->options.msg_channel);
                                                              ^
error.h:151:67: note: in definition of macro 'msg'
 #define msg(flags, ...) do { if (msg_test(flags)) {x_msg((flags),
__VA_ARGS__);} EXIT_FATAL(flags); } while (false)

^~~~~~~~~~~
init.c: In function 'do_init_crypto_tls':
init.c:2889:19: error: 'const struct options' has no member named
'port_share_host'
         && options->port_share_host)
                   ^~
make[3]: *** [Makefile:743: init.o] Error 1


The first part is a warning that we can ignore for the sake of this patch.

The bottom part is the actual error.


Cheers,

-- 
Antonio Quartulli

