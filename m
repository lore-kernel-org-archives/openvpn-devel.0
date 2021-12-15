References: <YYfa3rAEKJKQ4RpK@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <05b1477c-a1b5-fbe4-e475-076fa44e5988@...1147...>
Date: Wed, 15 Dec 2021 09:45:24 +0100
MIME-Version: 1.0
In-Reply-To: <YYfa3rAEKJKQ4RpK@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] NTLMv1, NTLMv2 HTTP proxy support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi Gert,

On 07/11/21 14:55, Gert Doering wrote:
> Hi Community,
>
> OpenVPN supports HTTP proxies that require NTLM authentication,
> supporting NTLMv1 and NTLMv2 protocols.
>
> This is old code, which was written in the dark ages, is not currently
> unit/client tested, and uses DES which got deprecated in OpenSSL 3.0.0...
>
> That said, if people still *use* it, we are likely to keep it - otherwise
> it might just become lost :-)
>
> So - if you use HTTP proxy in OpenVPN, and that proxy authenticates
> against a Windows AD domain, and you use NTLMv1 or NTLMv2 authentication,
> please speak up and tell us about your use case!
>
>
it took me a while, but I finallly have a working setup with a Samba=20
4.15 and a CentOS 7 webserver with mod_auth_ntlm_winbind ; especially=20
the latter part is tricky/important, as that code is not supported on=20
newer platforms, it seems.

The good news is:=A0=A0 openvpn 2.5.1 still works , both with NTLMv1 and=20
NTLMv2; I added two debug statements to ntlm.c and can clearly see:

NTLMv1:
2021-12-15 09:36:16 Info: generate NTLM response
2021-12-15 09:36:16 NTLM response: add security buffer

NTLMv2:
2021-12-15 09:35:44 Info: generate NTLMv2 response
2021-12-15 09:35:44 NTLMv2 response: add security buffer

Having said that, I think we can safely drop (at least) NTLMv1 support,=20
as it is pretty hard to set up a system to support that - easiest way is=20
to grab a legacy Windows server system (e.g. Windows Server 2003) but=20
nobody should run that anyways. Or put another way
 =A0 "if your local proxy is running unsupported legacy code in an=20
unsecure setup,
 =A0=A0 then you will have to resort to openvpn 2.4.x "

or similar.

BTW, do you know who worked on the obfuscation/transport API stuff? Was=20
that David S?

cheers,

JJK / Jan Just Keijser


