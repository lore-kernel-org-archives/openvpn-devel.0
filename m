Message-ID: <4CB7FF56.8080107@...515...>
Date: Fri, 15 Oct 2010 10:14:30 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <LAAT8C$AF2127EA27C5D0C15118FCEFC2FE06E1@...1417...>
In-Reply-To: <LAAT8C$AF2127EA27C5D0C15118FCEFC2FE06E1@...1417...>
Subject: Re: [Openvpn-devel] openvpn, NTLM and McAfee Web Gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> dear all,
>
> a few days ago I deployed an ovpn solution in a medium sized company.
> One of the two ends of the vpn network is passing through a proxy with
> NTLM authentication. ovpn has problems to recognize the authentication
> because immediately after sending the message type 1, the proxy sends
> no response, so I had to modify the source code by replacing the
> current message with a similar but different one.
>
> in particular this one:
>
> TlRMTVNTUAABAAAAAgIAAA=3D=3D
>
>
> become:
>
> TlRMTVNTUAABAAAAB4IIogAAAAAAAAAAAAAAAAAAAAAFASgKAAAADw=3D=3D
>
>
> A detail of the work is available at:
>
> http://www.morzello.com/?p=3D350 (in Italian).
>
> I was wondering if you could have a function that supports this type
> of proxy (such as McAfee Web Gateway).
>
> thank you very much.
Hi,

I read your blog post, interesting stuff. The strings the client sends
seem to be base64 encoded and the first part on both messages look like
this (in nano/vi):

NTLMSSP

It's followed by this, which is apparently the message type hex string:

^@^A^@^@^@

After this they differ noticeably. I'd guess they are just sending
different NTLM flags:

<http://davenport.sourceforge.net/ntlm.html#theNtlmMessageHeaderLayout>

Can somebody more fluent in NTLM protocol decipher these two messages?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


