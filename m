Message-ID: <183b0eb60712161553m869c18bn4cddb22c89756b3a@...278...>
Date: Mon, 17 Dec 2007 07:53:39 +0800
From: "dingchengyin 45702" <dingchengyin@...1067...>
Sender: chandlerding@...277...
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6392_5382129.1197849219225"
Subject: [Openvpn-devel] Openvpn having problems while pass-through NetApp
	NetCache.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_6392_5382129.1197849219225
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey,
    I think you all have noticed that the TLS handshake procedure of openvpn
client with server is different with the standard OpenSSL TLSv1 handshake
procedure that with normal SSL/TLS browser with server.
    Since I'm using open in a HTTP Proxy + NetApp NetCache network. The
NetCache act as a transparent proxy, If I set my Openvpn server's listen
port to TCP 443 or port 80, then the client cannot connect to the server ,
after the first packet sent to server, the NetCache disconnect the  TCP
connection. This problem will not appear when I set the server listen on
other ports like 1194.
    This shouldn't be a big problem while I can connect to Internet, but
when I work in a Private network that only can go out though a HTTP Proxy,
then there are problems: the 80/443 port are the only two ports that allowed
to pass the filter of the proxy, while the NetCache will interrupt me from
connect to the server.
   Can we make the TLSv1 connection initialization process the same as the
OpenSSL library do, I mean there should be a Client Hello first ,then the
server reply with its certificate until it's encrypted on both direction.
Then we can send what ever data we want, right?

------=_Part_6392_5382129.1197849219225
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey,<br>&nbsp;&nbsp;&nbsp; I think you all have noticed that the TLS handshake procedure of openvpn client with server is different with the standard OpenSSL TLSv1 handshake procedure that with normal SSL/TLS browser with server. <br>&nbsp;&nbsp;&nbsp; Since I&#39;m using open in a HTTP Proxy + NetApp NetCache network. The NetCache act as a transparent proxy, If I set my Openvpn server&#39;s listen port to TCP 443 or port 80, then the client cannot connect to the server , after the first packet sent to server, the NetCache disconnect the&nbsp; TCP connection. This problem will not appear when I set the server listen on other ports like 1194.
<br>&nbsp;&nbsp;&nbsp; This shouldn&#39;t be a big problem while I can connect to Internet, but when I work in a Private network that only can go out though a HTTP Proxy, then there are problems: the 80/443 port are the only two ports that allowed to pass the filter of the proxy, while the NetCache will interrupt me from connect to the server.
<br>&nbsp;&nbsp; Can we make the TLSv1 connection initialization process the same as the OpenSSL library do, I mean there should be a Client Hello first ,then the server reply with its certificate until it&#39;s encrypted on both direction. Then we can send what ever data we want, right?
<br>

------=_Part_6392_5382129.1197849219225--

