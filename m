References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
 <4f9a99ba-031d-43c7-c17f-8f842a519ddd@...1147...>
 <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
 <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
 <20210408155251.GX976@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <d4420114-64e7-e0ea-127f-af7752b3a799@...1147...>
Date: Fri, 9 Apr 2021 11:24:01 +0200
MIME-Version: 1.0
In-Reply-To: <20210408155251.GX976@...1296...>
Content-Type: multipart/alternative;
 boundary="------------E0E9AC39644F2DB8952DE810"
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------E0E9AC39644F2DB8952DE810
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/04/21 17:52, Gert Doering wrote:
> Hi,
>
> On Thu, Apr 08, 2021 at 05:30:52PM +0200, Jan Just Keijser wrote:
>> I don't have any evidence with 2.5 right now but this is just a matter
>> of use/principle to me: I can very well see that I would like to have a
>> setup *without* NCP as I simply do not need it (e.g. my cipher is
>> hardwired to aes-256-gcm)=A0 and in that case I don't *want* NCP to ensu=
re
>> my setup is 100% predictable.
> By setting "--data-ciphers AES-256-GCM" on the client side, you achieve
> a 100% predictable outcome.  No other cipher will be offered or accepted.
Ah a new 2.5 option - I assume the same thing is true for adding this on=20
the server side?

And I see that --data-ciphers works only in combination with NCP, that=20
is, if you do
 =A0 --data-ciphers aes-256-gcm --ncp-disable
then --data-ciphers is effectively ignored.=A0 Nice=A0 ;)

>> Disabling this option means you give me less control over the setup and
>> I don't like that, thus Feature-NAK.
> Removing that option means "less confusing code variants that can lead
> to 'it works with NCP but not with NCP disabled'".
>
> Since I test all these variants, and find the confusing corner cases, it
> would be good to have less code paths throughout OpenVPN, especially
> in the server option negotiation and key setup phases.
>
>
>> I'd say that removing the ability to disable NCP=A0 can happen *only* wh=
en
>> all negative side-effects of enabling it have been mitigated fully.=A0 On
>> a slow link the NCP overhead can be quite disastrous and not just during
>> connection setup, but during the *whole* session. To me, yet another
>> reason for Feature-NAK
> The overhead of NCP is roughly "some 100 bytes sent extra from client to
> server in the TLS handshake phase" (to announce the acceptable ciphers)
> and "cipher xxx" in the PUSH_REPLY.
>
> There is no overhead in the data phase.
>
> Please explain how this can be "quite disastrous"?
>
>
> (Of course, if NCP negotiates a cipher with more overhead than you'd
> like to use, that would be "more overhead" - but this is fully under
> the client's control with --data-ciphers.  It even works with "none",
> provided both client and server permit this)
I was thinking about this email discussion we had in October 2018:

> On 29/10/18 18:08, Gert Doering wrote:
>> On Mon, Oct 29, 2018 at 05:40:04PM +0100, Jan Just Keijser wrote:
>>> So, the '32' is easily explained. However, the rest of the MTU
>>> calculation baffles me.
>> Part of this is "peer-id" (+3 bytes) and "the theoretical maximum
>> crypto + hmac overhead" which 2.3 calculates "for the cipher chosen"
>> and 2.4 needs to calculale for the worst-case cipher+auth, since it does
>> not know what the server will push.
>>
>> In other words, you do not want to know - and the whole "match
>> configured client/server tun-mtu/link-mtu OCC thingie" is a real=20
>> nuisance.
>
> so I now understand the client MTU:
> =A0 openvpn 2.3.18 -> mtu =3D 1431
> =A0 openvpn 2.4.6 -> mtu =3D 1428 which accounts for peer-id (+3)
>
> but the *server* mtu?!?!?!=A0 I would have expected that with=20
> --ncp-disable added I would end up with more or less the same MTU as=20
> with the 2.3 code. Instead I see
> =A0 openvpn 2.3.18 -> mtu =3D 1431
> =A0 openvpn 2.4.6 -> mtu =3D 1379
> which is 62 bytes LESS , so even with peer-id subtracted (does it=20
> apply to the server MTU?)=A0 I end up with 59 bytes unaccounted for *in=20
> tun mode*.
>
and I was hoping that this would be resolved before removing something=20
like --ncp-disable. Having said that, I now see that with openvpn 2.5,=20
the server mtu is still 1379 in my setup, regardless of whether I use=20
--ncp-disable or not=A0 - seems to me that is still too low.

On the client side I now see even more confusing fun:

Server has --ncp-disable set:
- with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
- with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1376=A0 <--- huh?

Server does not have --ncp-disable set:
- with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
- with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1448
(ok I understand the latter).

What I'd really like to see is a way to get the server-side MTU to also=20
be 1428/1448 using the right magic options - any idea if that's possible?
The lower the MTU on either side, the lower the maximum bandwidth -=20
which will hurt especially over low-bandwidth links.

Also, when this option is dropped, does that mean that a 2.4/2.5 client=20
with the option set can no longer connect to a 2.6 server?

Conclusion: a further overhaul of the ncp/cipher/data-ciphers logic=20
might be in order...
Which is one of my gut reasons for saying : don't remove --ncp-disable=20
until this mess is thoroughly sorted out.


JM2CW,

JJK


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Client config:

client
proto udp
remote $SERVER
port 1194
dev tun
nobind
remote-cert-tls server
ca=A0=A0=A0=A0=A0=A0 ca.crt
cert=A0=A0=A0=A0 client1.crt
key=A0=A0=A0=A0=A0 client1.key
cipher aes-256-cbc
auth=A0=A0 sha256
link-mtu 1500
fragment 0
mssfix 0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Server config:

proto udp
port 1194
dev tun
server 10.200.0.0 255.255.255.0
dh=A0=A0=A0=A0=A0=A0 dh2048.pem
ca=A0=A0=A0=A0=A0=A0 ca.crt
cert=A0=A0=A0=A0 server.crt
key=A0=A0=A0=A0=A0 server.key
persist-key
persist-tun
keepalive 10 60
topology subnet
cipher aes-256-cbc
auth=A0=A0 sha256
link-mtu 1500
fragment 0
mssfix 0




--------------E0E9AC39644F2DB8952DE810
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html;
      charset=3Dwindows-1252">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 08/04/21 17:52, Gert Doering wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20210408155251.GX976@...1296...">
      <pre wrap=3D"">Hi,

On Thu, Apr 08, 2021 at 05:30:52PM +0200, Jan Just Keijser wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">I don't have any evidence with 2.5 right now but thi=
s is just a matter=20
of use/principle to me: I can very well see that I would like to have a=20
setup *without* NCP as I simply do not need it (e.g. my cipher is=20
hardwired to aes-256-gcm)=A0 and in that case I don't *want* NCP to ensure =

my setup is 100% predictable.
</pre>
      </blockquote>
      <pre wrap=3D"">
By setting "--data-ciphers AES-256-GCM" on the client side, you achieve
a 100% predictable outcome.  No other cipher will be offered or accepted.
</pre>
    </blockquote>
    Ah a new 2.5 option - I assume the same thing is true for adding
    this on the server side?<br>
    <br>
    And I see that --data-ciphers works only in combination with NCP,
    that is, if you do<br>
    =A0 --data-ciphers aes-256-gcm --ncp-disable<br>
    then --data-ciphers is effectively ignored.=A0 Nice=A0 ;)<br>
    <br>
    <blockquote type=3D"cite"
      cite=3D"mid:20210408155251.GX976@...1296...">
      <blockquote type=3D"cite">
        <pre wrap=3D"">Disabling this option means you give me less control=
 over the setup and=20
I don't like that, thus Feature-NAK.
</pre>
      </blockquote>
      <pre wrap=3D"">
Removing that option means "less confusing code variants that can lead
to 'it works with NCP but not with NCP disabled'".

Since I test all these variants, and find the confusing corner cases, it
would be good to have less code paths throughout OpenVPN, especially=20
in the server option negotiation and key setup phases.


</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">I'd say that removing the ability to disable NCP=A0 =
can happen *only* when=20
all negative side-effects of enabling it have been mitigated fully.=A0 On=20
a slow link the NCP overhead can be quite disastrous and not just during=20
connection setup, but during the *whole* session. To me, yet another=20
reason for Feature-NAK
</pre>
      </blockquote>
      <pre wrap=3D"">
The overhead of NCP is roughly "some 100 bytes sent extra from client to
server in the TLS handshake phase" (to announce the acceptable ciphers)
and "cipher xxx" in the PUSH_REPLY.

There is no overhead in the data phase.

Please explain how this can be "quite disastrous"?


(Of course, if NCP negotiates a cipher with more overhead than you'd
like to use, that would be "more overhead" - but this is fully under=20
the client's control with --data-ciphers.  It even works with "none",
provided both client and server permit this)
</pre>
    </blockquote>
    I was thinking about this email discussion we had in October 2018:<br>
    <br>
    <blockquote type=3D"cite">On 29/10/18 18:08, Gert Doering wrote:
      <br>
      <blockquote type=3D"cite" style=3D"color: #000000;">On Mon, Oct 29,
        2018 at 05:40:04PM +0100, Jan Just Keijser wrote:
        <br>
        <blockquote type=3D"cite" style=3D"color: #000000;">So, the '32' is
          easily explained. However, the rest of the MTU
          <br>
          calculation baffles me.
          <br>
        </blockquote>
        Part of this is "peer-id" (+3 bytes) and "the theoretical
        maximum
        <br>
        crypto + hmac overhead" which 2.3 calculates "for the cipher
        chosen"
        <br>
        and 2.4 needs to calculale for the worst-case cipher+auth, since
        it does
        <br>
        not know what the server will push.
        <br>
        <br>
        In other words, you do not want to know <span
          class=3D"moz-smiley-s1" title=3D":-)"></span> - and the whole
        "match
        <br>
        configured client/server tun-mtu/link-mtu OCC thingie" is a real
        nuisance.
        <br>
      </blockquote>
      <br>
      so I now understand the client MTU:
      <br>
      =A0 openvpn 2.3.18 -&gt; mtu =3D 1431
      <br>
      =A0 openvpn 2.4.6 -&gt; mtu =3D 1428 which accounts for peer-id (+3)
      <br>
      <br>
      but the <b class=3D"moz-txt-star"><span class=3D"moz-txt-tag">*</span=
>server<span
          class=3D"moz-txt-tag">*</span></b> mtu?!?!?!=A0 I would have
      expected that with --ncp-disable added I would end up with more or
      less the same MTU as with the 2.3 code. Instead I see
      <br>
      =A0 openvpn 2.3.18 -&gt; mtu =3D 1431
      <br>
      =A0 openvpn 2.4.6 -&gt; mtu =3D 1379
      <br>
      which is 62 bytes LESS , so even with peer-id subtracted (does it
      apply to the server MTU?)=A0 I end up with 59 bytes unaccounted for
      <b class=3D"moz-txt-star"><span class=3D"moz-txt-tag">*</span>in tun
        mode<span class=3D"moz-txt-tag">*</span></b>.
      <br>
      <br>
    </blockquote>
    and I was hoping that this would be resolved before removing
    something like --ncp-disable. Having said that, I now see that with
    openvpn 2.5, the server mtu is still 1379 in my setup, regardless of
    whether I use --ncp-disable or not=A0 - seems to me that is still too
    low.<br>
    <br>
    On the client side I now see even more confusing fun:<br>
    <br>
    Server has --ncp-disable set:<br>
    - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428<br>
    - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1376=A0 &lt;---
    huh?<br>
    <br>
    Server does not have --ncp-disable set:<br>
    - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428<br>
    - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1448<br>
    (ok I understand the latter).<br>
    <br>
    What I'd really like to see is a way to get the server-side MTU to
    also be 1428/1448 using the right magic options - any idea if that's
    possible?<br>
    The lower the MTU on either side, the lower the maximum bandwidth -
    which will hurt especially over low-bandwidth links.<br>
    <br>
    Also, when this option is dropped, does that mean that a 2.4/2.5
    client with the option set can no longer connect to a 2.6 server? <br>
    <br>
    Conclusion: a further overhaul of the ncp/cipher/data-ciphers logic
    might be in order...<br>
    Which is one of my gut reasons for saying : don't remove
    --ncp-disable until this mess is thoroughly sorted out.<br>
    <br>
    <br>
    JM2CW,<br>
    <br>
    JJK<br>
    <br>
    <br>
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
    Client config:<br>
    <br>
    client<br>
    proto udp<br>
    remote $SERVER<br>
    port 1194<br>
    dev tun<br>
    nobind<br>
    remote-cert-tls server<br>
    ca=A0=A0=A0=A0=A0=A0 ca.crt<br>
    cert=A0=A0=A0=A0 client1.crt<br>
    key=A0=A0=A0=A0=A0 client1.key<br>
    cipher aes-256-cbc<br>
    auth=A0=A0 sha256<br>
    link-mtu 1500<br>
    fragment 0<br>
    mssfix 0<br>
    <br>
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
    Server config:<br>
    <br>
    proto udp<br>
    port 1194<br>
    dev tun<br>
    server 10.200.0.0 255.255.255.0<br>
    dh=A0=A0=A0=A0=A0=A0 dh2048.pem<br>
    ca=A0=A0=A0=A0=A0=A0 ca.crt<br>
    cert=A0=A0=A0=A0 server.crt<br>
    key=A0=A0=A0=A0=A0 server.key<br>
    persist-key<br>
    persist-tun<br>
    keepalive 10 60<br>
    topology subnet<br>
    cipher aes-256-cbc<br>
    auth=A0=A0 sha256<br>
    link-mtu 1500<br>
    fragment 0<br>
    mssfix 0<br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------E0E9AC39644F2DB8952DE810--

