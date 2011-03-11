MIME-Version: 1.0
In-Reply-To: <AANLkTimvV+iW_ZeF2PFZvFjNNRDwDwZUHzTxY_wY__qr@...278...>
References: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>
	<20110311090414.GE9835@...1296...>
	<4D79ECC4.8010805@...1114...>
	<AANLkTi=5kX-fweV=wzAR0e_mMpvBbNuKGkt0rNQVUZ5P@...278...>
	<AANLkTimvV+iW_ZeF2PFZvFjNNRDwDwZUHzTxY_wY__qr@...278...>
Date: Fri, 11 Mar 2011 13:34:49 -0800
Message-ID: <AANLkTinfb7AZpdOj=-6=2fjpomzwTn2KWKCkvHF7VjMY@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Subject: Re: [Openvpn-devel] openvpn protocol breaks proxies intercepting
	SSL ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joe Patterson <j.m.patterson@...277...>
Cc: openvpn-devel@lists.sourceforge.net

BlueCoat's ProxySG is one that runs tranparent SSL protocol detection
and breaks if openvpn traffic is coming in via 443. This proxy is able
to pass through other non-HTTP pure SSL traffic though and not just
HTTPS.

Vineet
On Fri, Mar 11, 2011 at 11:58 AM, Joe Patterson <j.m.patterson@...277...> w=
rote:
> Do you have a pointer to a specific SSL proxy that you're talking about?
>
> I have this sneaking suspicion that what you're actually referring to
> is a transparent https proxy, which would most definitely *not* work,
> as openvpn rides on top of ssl, but not on top of http on top of ssl.
>
> A good test of this would be to try something like openssl
> s_client/s_server on each side of the proxy, or netcat with ssl
> support and make sure that if you try and pass non-http traffic
> through it, that the proxy doesn't reject or otherwise molest it.
>
> -Joe
>
> On Fri, Mar 11, 2011 at 2:09 PM, Vineet Kumar <vineet.kumar@...277...> wr=
ote:
>> Thanks for your replies.
>>
>> So,
>> - without --tls-auth
>> - with tcp as the transport
>> if we want to make openvpn purely SSL then are these the complete set
>> of things to take care of?:
>> 1. Move all P_CONTROL_* messages to be encapsulated in SSL
>> 2. Stop adding reliability layer over SSL
>>
>> Let's say, theoretically, that the above 2 steps are taken care of
>> (easier said than don, for sure). Will the resulting VPN setup then
>> pass through transparent SSL proxies unbroken?
>>
>> Thanks,
>>
>> Vineet
>> On Fri, Mar 11, 2011 at 1:35 AM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> On 11/03/11 10:04, Gert Doering wrote:
>>> | Hi,
>>> |
>>> | On Thu, Mar 10, 2011 at 05:04:48PM -0800, Vineet Kumar wrote:
>>> |> Also, doesn't this make openvpn different from other SSL VPNs which
>>> |> advertise the fact that they are truly SSL?
>>> |
>>> | Well, OpenVPN is "truly SSL", but it's not "using https as a browser =
would
>>> | do to hide the fact that there is a VPN inside"...
>>>
>>> Kind of. =A0Gert is basically correct. =A0But it is important to unders=
tand that
>>> OpenVPN doesn't use the SSL wire protocol directly, like the majority o=
f SSL
>>> applications does. =A0So all the SSL packets from OpenVPN are encapsula=
ted in
>>> a
>>> kind of OpenVPN container. =A0Which is why some strict proxies or deep =
packet
>>> inspection firewalls might not allow OpenVPN traffic.
>>>
>>> The reason for this is that OpenVPN is primarily written for the UDP
>>> protocol.
>>> ~ While SSL itself is very TCP oriented. =A0To my knowledge, there are =
no UDP
>>> transport support in OpenSSL. =A0So OpenVPN uses OpenSSL differently,
>>> intercepting the network connections and sending the data through OpenV=
PN's
>>> own network socket infrastructure. =A0If OpenVPN's HMAC support (--tls-=
auth)
>>> is
>>> enabled, some extra bytes are added on top of the SSL packet itself.
>>>
>>> Of course, it would probably be possible (I have not investigated this)=
 to
>>> add
>>> a feature which restricts OpenVPN to use the core SSL protocol, without
>>> =A0this
>>> encapsulation on top of the SSL packets. =A0However, when such a featur=
e is
>>> enabled, it would restrict the usage of TCP. =A0In addition, the --tls-=
auth
>>> feature would not be useful in at all.
>>>
>>>
>>> kind regards,
>>>
>>> David Sommerseth
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: GnuPG v1.4.10 (GNU/Linux)
>>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>>
>>> iEYEARECAAYFAk157MQACgkQDC186MBRfrqQdgCdGKarB9OcdlKSQaTxLXZIZnou
>>> qmoAn0G/9cfGHx6+NeWk2v0agOjRJCI9
>>> =3DSOiC
>>> -----END PGP SIGNATURE-----
>>>
>>
>> ------------------------------------------------------------------------=
------
>> Colocation vs. Managed Hosting
>> A question and answer guide to determining the best fit
>> for your organization - today and in the future.
>> http://p.sf.net/sfu/internap-sfd2d
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>
> -------------------------------------------------------------------------=
-----
> Colocation vs. Managed Hosting
> A question and answer guide to determining the best fit
> for your organization - today and in the future.
> http://p.sf.net/sfu/internap-sfd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

