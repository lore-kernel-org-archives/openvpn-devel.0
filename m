MIME-Version: 1.0
In-Reply-To: <AANLkTi=5kX-fweV=wzAR0e_mMpvBbNuKGkt0rNQVUZ5P@...278...>
References: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>
	<20110311090414.GE9835@...1296...>
	<4D79ECC4.8010805@...1114...>
	<AANLkTi=5kX-fweV=wzAR0e_mMpvBbNuKGkt0rNQVUZ5P@...278...>
From: Joe Patterson <j.m.patterson@...277...>
Date: Fri, 11 Mar 2011 14:58:44 -0500
Message-ID: <AANLkTimvV+iW_ZeF2PFZvFjNNRDwDwZUHzTxY_wY__qr@...278...>
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
To: openvpn-devel@lists.sourceforge.net

Do you have a pointer to a specific SSL proxy that you're talking about?

I have this sneaking suspicion that what you're actually referring to
is a transparent https proxy, which would most definitely *not* work,
as openvpn rides on top of ssl, but not on top of http on top of ssl.

A good test of this would be to try something like openssl
s_client/s_server on each side of the proxy, or netcat with ssl
support and make sure that if you try and pass non-http traffic
through it, that the proxy doesn't reject or otherwise molest it.

-Joe

On Fri, Mar 11, 2011 at 2:09 PM, Vineet Kumar <vineet.kumar@...277...> wrot=
e:
> Thanks for your replies.
>
> So,
> - without --tls-auth
> - with tcp as the transport
> if we want to make openvpn purely SSL then are these the complete set
> of things to take care of?:
> 1. Move all P_CONTROL_* messages to be encapsulated in SSL
> 2. Stop adding reliability layer over SSL
>
> Let's say, theoretically, that the above 2 steps are taken care of
> (easier said than don, for sure). Will the resulting VPN setup then
> pass through transparent SSL proxies unbroken?
>
> Thanks,
>
> Vineet
> On Fri, Mar 11, 2011 at 1:35 AM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 11/03/11 10:04, Gert Doering wrote:
>> | Hi,
>> |
>> | On Thu, Mar 10, 2011 at 05:04:48PM -0800, Vineet Kumar wrote:
>> |> Also, doesn't this make openvpn different from other SSL VPNs which
>> |> advertise the fact that they are truly SSL?
>> |
>> | Well, OpenVPN is "truly SSL", but it's not "using https as a browser w=
ould
>> | do to hide the fact that there is a VPN inside"...
>>
>> Kind of. =A0Gert is basically correct. =A0But it is important to underst=
and that
>> OpenVPN doesn't use the SSL wire protocol directly, like the majority of=
 SSL
>> applications does. =A0So all the SSL packets from OpenVPN are encapsulat=
ed in
>> a
>> kind of OpenVPN container. =A0Which is why some strict proxies or deep p=
acket
>> inspection firewalls might not allow OpenVPN traffic.
>>
>> The reason for this is that OpenVPN is primarily written for the UDP
>> protocol.
>> ~ While SSL itself is very TCP oriented. =A0To my knowledge, there are n=
o UDP
>> transport support in OpenSSL. =A0So OpenVPN uses OpenSSL differently,
>> intercepting the network connections and sending the data through OpenVP=
N's
>> own network socket infrastructure. =A0If OpenVPN's HMAC support (--tls-a=
uth)
>> is
>> enabled, some extra bytes are added on top of the SSL packet itself.
>>
>> Of course, it would probably be possible (I have not investigated this) =
to
>> add
>> a feature which restricts OpenVPN to use the core SSL protocol, without
>> =A0this
>> encapsulation on top of the SSL packets. =A0However, when such a feature=
 is
>> enabled, it would restrict the usage of TCP. =A0In addition, the --tls-a=
uth
>> feature would not be useful in at all.
>>
>>
>> kind regards,
>>
>> David Sommerseth
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.10 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAk157MQACgkQDC186MBRfrqQdgCdGKarB9OcdlKSQaTxLXZIZnou
>> qmoAn0G/9cfGHx6+NeWk2v0agOjRJCI9
>> =3DSOiC
>> -----END PGP SIGNATURE-----
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

