Message-ID: <183b0eb60712181138i5be9fbb9lfc861e7e64fab77a@...278...>
Date: Wed, 19 Dec 2007 03:38:30 +0800
From: "dingchengyin 45702" <dingchengyin@...1067...>
Sender: chandlerding@...277...
In-Reply-To: <35f70db10712172330o59bfd1f1nd238f2ba0aaebbeb@...278...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11094_7289085.1198006710774"
References: <183b0eb60712161553m869c18bn4cddb22c89756b3a@...278...>
	<35f70db10712172330o59bfd1f1nd238f2ba0aaebbeb@...278...>
Subject: Re: [Openvpn-devel] Openvpn having problems while pass-through
	NetApp NetCache.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ross.cameron@...1049...
Cc: openvpn-devel@lists.sourceforge.net

------=_Part_11094_7289085.1198006710774
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've tried the connection with or without proxy, as long as the port of
server is 80 or 443, the NetApp NetCache will broke the connection after the
TCP connection established and client sent 1 packet.
I think it's because the first packet sent by client is not a TLSv1 CLIENT
HELLO Message( I can't parse it with ethereal ).

I've tried other SSL VPN software, it worked ,the only difference between
the other SSL VPN is the TLS handshake process.
So , again ,can we make the TLS handshake standard compatible.

On Dec 18, 2007 3:30 PM, Ross Cameron <ross.cameron@...1049...> wrote:

> On Dec 17, 2007 1:53 AM, dingchengyin 45702 <dingchengyin@...1067...>
> wrote:
> > Hey,
> >     I think you all have noticed that the TLS handshake procedure of
> openvpn
> > client with server is different with the standard OpenSSL TLSv1
> handshake
> > procedure that with normal SSL/TLS browser with server.
> >     Since I'm using open in a HTTP Proxy + NetApp NetCache network. The
> > NetCache act as a transparent proxy, If I set my Openvpn server's listen
> > port to TCP 443 or port 80, then the client cannot connect to the server
> ,
> > after the first packet sent to server, the NetCache disconnect the  TCP
> > connection. This problem will not appear when I set the server listen on
> > other ports like 1194.
> >     This shouldn't be a big problem while I can connect to Internet, but
> > when I work in a Private network that only can go out though a HTTP
> Proxy,
> > then there are problems: the 80/443 port are the only two ports that
> allowed
> > to pass the filter of the proxy, while the NetCache will interrupt me
> from
> > connect to the server.
> >    Can we make the TLSv1 connection initialization process the same as
> the
> > OpenSSL library do, I mean there should be a Client Hello first ,then
> the
> > server reply with its certificate until it's encrypted on both
> direction.
> > Then we can send what ever data we want, right?
>
> Have you configured OpenVPN's client side to be aware of the proxy
> server or not?
> I've had a similar issue when I forgot to configure the clients to
>
> I stand corrected but I think OpenVPN changes its handshaking slightly
> when its configured to be used as a client /BEHIND/  a proxy server.
>      Assuming that it would pass through just any http(s) proxy when
> the server side port is 443/80 is flawed logic.
> Yes OpenVPN is a TLS/SSL VPN but this does not justify assuming that
> it works the same way as https.
>
> Try re-configuring you're client side to be aware of the proxying
> host, I'm sure that you will probably have a vastly improved
> experience.
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by:
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services
> for just about anything Open Source.
>
> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

------=_Part_11094_7289085.1198006710774
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve tried the connection with or without proxy, as long as the port of server is 80 or 443, the NetApp NetCache will broke the connection after the TCP connection established and client sent 1 packet.<br>I think it&#39;s because the first packet sent by client is not a TLSv1 CLIENT HELLO Message( I can&#39;t parse it with ethereal ).
<br><br>I&#39;ve tried other SSL VPN software, it worked ,the only difference between the other SSL VPN is the TLS handshake process.<br>So , again ,can we make the TLS handshake standard compatible.<br><br><div class="gmail_quote">
On Dec 18, 2007 3:30 PM, Ross Cameron &lt;<a href="mailto:ross.cameron@...1049...">ross.cameron@...1049...</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">On Dec 17, 2007 1:53 AM, dingchengyin 45702 &lt;<a href="mailto:dingchengyin@...1067...">dingchengyin@...1067...</a>&gt; wrote:<br>&gt; Hey,<br>&gt; &nbsp; &nbsp; I think you all have noticed that the TLS handshake procedure of openvpn
<br>&gt; client with server is different with the standard OpenSSL TLSv1 handshake<br>&gt; procedure that with normal SSL/TLS browser with server.<br>&gt; &nbsp; &nbsp; Since I&#39;m using open in a HTTP Proxy + NetApp NetCache network. The
<br>&gt; NetCache act as a transparent proxy, If I set my Openvpn server&#39;s listen<br>&gt; port to TCP 443 or port 80, then the client cannot connect to the server ,<br>&gt; after the first packet sent to server, the NetCache disconnect the &nbsp;TCP
<br>&gt; connection. This problem will not appear when I set the server listen on<br>&gt; other ports like 1194.<br>&gt; &nbsp; &nbsp; This shouldn&#39;t be a big problem while I can connect to Internet, but<br>&gt; when I work in a Private network that only can go out though a HTTP Proxy,
<br>&gt; then there are problems: the 80/443 port are the only two ports that allowed<br>&gt; to pass the filter of the proxy, while the NetCache will interrupt me from<br>&gt; connect to the server.<br>&gt; &nbsp; &nbsp;Can we make the TLSv1 connection initialization process the same as the
<br>&gt; OpenSSL library do, I mean there should be a Client Hello first ,then the<br>&gt; server reply with its certificate until it&#39;s encrypted on both direction.<br>&gt; Then we can send what ever data we want, right?
<br><br></div></div>Have you configured OpenVPN&#39;s client side to be aware of the proxy<br>server or not?<br>I&#39;ve had a similar issue when I forgot to configure the clients to<br><br>I stand corrected but I think OpenVPN changes its handshaking slightly
<br>when its configured to be used as a client /BEHIND/ &nbsp;a proxy server.<br> &nbsp; &nbsp; &nbsp;Assuming that it would pass through just any http(s) proxy when<br>the server side port is 443/80 is flawed logic.<br>Yes OpenVPN is a TLS/SSL VPN but this does not justify assuming that
<br>it works the same way as https.<br><br>Try re-configuring you&#39;re client side to be aware of the proxying<br>host, I&#39;m sure that you will probably have a vastly improved<br>experience.<br><br>-------------------------------------------------------------------------
<br>SF.Net email is sponsored by:<br>Check out the new SourceForge.net Marketplace.<br>It&#39;s the best place to buy or sell services<br>for just about anything Open Source.<br><a href="http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace" target="_blank">
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace</a><br>_______________________________________________<br>Openvpn-devel mailing list<br><a href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br></blockquote></div><br>

------=_Part_11094_7289085.1198006710774--

