MIME-Version: 1.0
References: <CAD3upLv_mr3DXJinqHdxPivkhdHWrBkpZ3xNjcNtHkzERGbCPw@...278...>
 <f3b7fa32-0e9c-f6e6-6079-5e942f50a600@...1227...>
In-Reply-To: <f3b7fa32-0e9c-f6e6-6079-5e942f50a600@...1227...>
From: Turritopsis Dohrnii Teo En Ming <tdtemccnp@...277...>
Date: Mon, 14 Nov 2022 23:45:17 +0800
Message-ID: <CAD3upLs7GCX4OkeCB42H1iX6BqRmQwF27_izJL5KSMS_oHjOqA@...278...>
Content-Type: multipart/alternative; boundary="000000000000e065fa05ed702003"
Subject: Re: [Openvpn-devel] Do most commercial firewall appliances and VPN
 routers have OpenVPN-powered SSL VPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, ceo@...2703...

--000000000000e065fa05ed702003
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Nov 2022 at 23:41, Arne Schwabe <arne@...1227...> wrote:

> Am 14.11.22 um 16:03 schrieb Turritopsis Dohrnii Teo En Ming:
> > Subject: Do most commercial firewall appliances and VPN routers have
> > OpenVPN-powered SSL VPN?
> >
> > Good day from Singapore,
> >
> > On 10 Nov 2022, I saw the logs from Sophos XG210 Firewall SSL VPN client
> > for Windows. Below are a few lines from the logs.
> >
> > 2022-11-10 14:10:03 WARNING: Compression for receiving enabled.
> > Compression has been used in the past to break encryption. Sent packets
> > are not compressed unless "allow-compression yes" is also set.
> > 2022-11-10 14:10:03 DEPRECATED OPTION: --cipher set to 'AES-128-CBC' but
> > missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN
> > version will ignore --cipher for cipher negotiations. Add 'AES-128-CBC'
> > to --data-ciphers or change --cipher 'AES-128-CBC' to
> > --data-ciphers-fallback 'AES-128-CBC' to silence this warning.
> > 2022-11-10 14:10:03 OpenVPN 2.5.6 Windows-MSVC [SSL (OpenSSL)] [LZO]
> > [LZ4] [PKCS11] [AEAD] built on Apr 22 2022
> > 2022-11-10 14:10:03 Windows version 10.0 (Windows 10 or greater) 64bit
> > 2022-11-10 14:10:03 library versions: OpenSSL 1.1.1n  15 Mar 2022, LZO
> 2.10
> >
> > Without question, this goes to show that the SSL VPN Server in Sophos
> > XG210 firewall appliance is powered by OpenVPN.
> >
> > Do most commercial firewall appliances and VPN routers have
> > OpenVPN-powered SSL VPN? Is there an official list?
>
> This is the developers' mailing list and not for user question. And yes
> there are many commercial appliances that use OpenVPN but there is no
> official list and also OpenVPN Inc (the company) will probably not
> maintaining an official one as these products are competing with their
> own offerings.
>
> If you are looking to support companies that contribute to the OpenVPN
> open source itself then Sophos did that in the past but does no longer
> (branch of that company that did that was closed) and quite recently
> netgate (pfsense) and of course OpenVPN Inc itself (sorry if I forgot
> somebody)
>
> Arne
>
>
Noted with thanks.

My client is using Sophos XG210 firewall appliance and personally I am
using pfSense community edition firewall.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore

--000000000000e065fa05ed702003
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 14 Nov 2022 at 23:41, Arne Sc=
hwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 14.11.22 um =
16:03 schrieb Turritopsis Dohrnii Teo En Ming:<br>
&gt; Subject: Do most commercial firewall appliances and VPN routers have <=
br>
&gt; OpenVPN-powered SSL VPN?<br>
&gt; <br>
&gt; Good day from Singapore,<br>
&gt; <br>
&gt; On 10 Nov 2022, I saw the logs from Sophos XG210 Firewall SSL VPN clie=
nt <br>
&gt; for Windows. Below are a few lines from the logs.<br>
&gt; <br>
&gt; 2022-11-10 14:10:03 WARNING: Compression for receiving enabled. <br>
&gt; Compression has been used in the past to break encryption. Sent packet=
s <br>
&gt; are not compressed unless &quot;allow-compression yes&quot; is also se=
t.<br>
&gt; 2022-11-10 14:10:03 DEPRECATED OPTION: --cipher set to &#39;AES-128-CB=
C&#39; but <br>
&gt; missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN <b=
r>
&gt; version will ignore --cipher for cipher negotiations. Add &#39;AES-128=
-CBC&#39; <br>
&gt; to --data-ciphers or change --cipher &#39;AES-128-CBC&#39; to <br>
&gt; --data-ciphers-fallback &#39;AES-128-CBC&#39; to silence this warning.=
<br>
&gt; 2022-11-10 14:10:03 OpenVPN 2.5.6 Windows-MSVC [SSL (OpenSSL)] [LZO] <=
br>
&gt; [LZ4] [PKCS11] [AEAD] built on Apr 22 2022<br>
&gt; 2022-11-10 14:10:03 Windows version 10.0 (Windows 10 or greater) 64bit=
<br>
&gt; 2022-11-10 14:10:03 library versions: OpenSSL 1.1.1n =C2=A015 Mar 2022=
, LZO 2.10<br>
&gt; <br>
&gt; Without question, this goes to show that the SSL VPN Server in Sophos =
<br>
&gt; XG210 firewall appliance is powered by OpenVPN.<br>
&gt; <br>
&gt; Do most commercial firewall appliances and VPN routers have <br>
&gt; OpenVPN-powered SSL VPN? Is there an official list?<br>
<br>
This is the developers&#39; mailing list and not for user question. And yes=
 <br>
there are many commercial appliances that use OpenVPN but there is no <br>
official list and also OpenVPN Inc (the company) will probably not <br>
maintaining an official one as these products are competing with their <br>
own offerings.<br>
<br>
If you are looking to support companies that contribute to the OpenVPN <br>
open source itself then Sophos did that in the past but does no longer <br>
(branch of that company that did that was closed) and quite recently <br>
netgate (pfsense) and of course OpenVPN Inc itself (sorry if I forgot <br>
somebody)<br>
<br>
Arne<br>
<br></blockquote><div><br></div><div>Noted with thanks.</div><div><br></div=
><div>My client is using Sophos XG210 firewall appliance and personally I a=
m using pfSense community edition firewall.</div><div><br></div><div>Regard=
s,</div><div><br></div><div>Mr. Turritopsis Dohrnii Teo En Ming</div><div>T=
argeted Individual in Singapore=C2=A0</div></div></div>

--000000000000e065fa05ed702003--

