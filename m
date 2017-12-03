MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 3 Dec 2017 14:57:32 +0500
Message-ID: <CAFHpkQEM9P8P4vUuzySan4Mt3CRscrio+D87jeGZY=zzNZm=Pw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0b80766c3ebd055f6ca168"
Subject: [Openvpn-devel] strange behaviour of "auth-token"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0b80766c3ebd055f6ca168
Content-Type: text/plain; charset="UTF-8"

Hello,

I noticed strange "TLS Auth Error: Auth Username/Password verification
failed for peer" when I restarted openvpn server.

deeper digging into that discovered the following flow

1) client is authenticated via login/password --> auth token is assigned
2) reauth is done via username/token (token is kept in server memory)
3) server is restarted
4) username/token is passed to auth program --> auth failed

so..

1) shouldn't client retry auth with username/password if username/token is
failed ?
2) shouldn't server just fail token and not pass it to "extrenla script" ?

Cheers,
Ilya Shipitsin

--94eb2c0b80766c3ebd055f6ca168
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div><div>Hel=
lo,<br><br></div>I noticed strange &quot;TLS Auth Error: Auth Username/Pass=
word verification failed for peer&quot; when I restarted openvpn server.<br=
><br></div>deeper digging into that discovered the following flow<br><br></=
div>1) client is authenticated via login/password --&gt; auth token is assi=
gned<br></div>2) reauth is done via username/token (token is kept in server=
 memory)<br></div>3) server is restarted<br></div>4) username/token is pass=
ed to auth program --&gt; auth failed<br><br></div>so..<br><br></div>1) sho=
uldn&#39;t client retry auth with username/password if username/token is fa=
iled ? <br></div>2) shouldn&#39;t server just fail token and not pass it to=
 &quot;extrenla script&quot; ?<br><br></div>Cheers,<br></div>Ilya Shipitsin=
<br><div><div><div><div><div><div><div><div><br></div></div></div></div></d=
iv></div></div></div></div>

--94eb2c0b80766c3ebd055f6ca168--

