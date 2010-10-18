Message-ID: <4CBC285B.4010800@...1147...>
Date: Mon, 18 Oct 2010 12:58:35 +0200
From: Jan Just Keijser <janjust@...1147...>
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
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn <openvpn@...1416...>
Cc: openvpn-devel@lists.sourceforge.net

openvpn wrote:
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
> TlRMTVNTUAABAAAAAgIAAA==
>
>
> become:
>
> TlRMTVNTUAABAAAAB4IIogAAAAAAAAAAAAAAAAAAAAAFASgKAAAADw==
>
>
> A detail of the work is available at:
>
> http://www.morzello.com/?p=350 (in Italian).
>
> I was wondering if you could have a function that supports this type 
> of proxy (such as McAfee Web Gateway).
>
I applied your "patch" and I still cannot get it to work for my 
httpd+mod_ntlm (NTLMv1 only) installation. The NTLM handshake that 
OpenVPN does is broken. Without the patch Wireshark tells me the first 
NTLMSPP message is invalid
  http://www.nikhef.nl/~janjust/openvpn/openvpn-ntlm-error1.png
If I change the phase_1 NTLM message to the above I get one step further 
but then it breaks at the next packet:
  http://www.nikhef.nl/~janjust/openvpn/openvpn-ntlm-error2.png
It seems the Windows domain and username are not stored properly inside 
the request. The same httpd+mod_ntlm installation works flawlessly using 
Internet Explorer 7: in that case the domain and user name are encoded 
just fine.

What am I doing wrong?

cheers,

JJK


