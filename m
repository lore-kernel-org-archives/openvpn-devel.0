Message-ID: <35f70db10712172330o59bfd1f1nd238f2ba0aaebbeb@...278...>
Date: Tue, 18 Dec 2007 09:30:16 +0200
From: "Ross Cameron" <ross.cameron@...1049...>
Sender: abalour@...277...
In-Reply-To: <183b0eb60712161553m869c18bn4cddb22c89756b3a@...278...>
MIME-Version: 1.0
References: <183b0eb60712161553m869c18bn4cddb22c89756b3a@...278...>
Subject: Re: [Openvpn-devel] Openvpn having problems while pass-through
	NetApp NetCache.
Reply-To: ross.cameron@...1049...
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
Content-Disposition: inline
To: dingchengyin 45702 <dingchengyin@...1067...>
Cc: openvpn-devel@lists.sourceforge.net

On Dec 17, 2007 1:53 AM, dingchengyin 45702 <dingchengyin@...1067...> wrote:
> Hey,
>     I think you all have noticed that the TLS handshake procedure of openvpn
> client with server is different with the standard OpenSSL TLSv1 handshake
> procedure that with normal SSL/TLS browser with server.
>     Since I'm using open in a HTTP Proxy + NetApp NetCache network. The
> NetCache act as a transparent proxy, If I set my Openvpn server's listen
> port to TCP 443 or port 80, then the client cannot connect to the server ,
> after the first packet sent to server, the NetCache disconnect the  TCP
> connection. This problem will not appear when I set the server listen on
> other ports like 1194.
>     This shouldn't be a big problem while I can connect to Internet, but
> when I work in a Private network that only can go out though a HTTP Proxy,
> then there are problems: the 80/443 port are the only two ports that allowed
> to pass the filter of the proxy, while the NetCache will interrupt me from
> connect to the server.
>    Can we make the TLSv1 connection initialization process the same as the
> OpenSSL library do, I mean there should be a Client Hello first ,then the
> server reply with its certificate until it's encrypted on both direction.
> Then we can send what ever data we want, right?

Have you configured OpenVPN's client side to be aware of the proxy
server or not?
I've had a similar issue when I forgot to configure the clients to

I stand corrected but I think OpenVPN changes its handshaking slightly
when its configured to be used as a client /BEHIND/  a proxy server.
      Assuming that it would pass through just any http(s) proxy when
the server side port is 443/80 is flawed logic.
Yes OpenVPN is a TLS/SSL VPN but this does not justify assuming that
it works the same way as https.

Try re-configuring you're client side to be aware of the proxying
host, I'm sure that you will probably have a vastly improved
experience.

