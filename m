MIME-Version: 1.0
Date: Fri, 22 Apr 2016 13:46:15 +0530
Message-ID: <CAP=zTkOpzBtS05aN0XmdtX+DJS-owGaSK-qHXEA2vwsSO_NCjg@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a11c3c26cd3419105310e7057
Subject: [Openvpn-devel] OpenSSL connect and disconnect calls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a11c3c26cd3419105310e7057
Content-Type: text/plain; charset=UTF-8

Hello,

I was going through the codebase, and found myself a bit confused. I wanted
to customize some functionalities and run some tests

I was specifically looking for the methods where we start (performing the
handshake) and end an OpenSSL session.

How and where are the OpenSSL calls like the SSL_connect(),
SSL_SESSION_free(), SSL_shutdown(),  SSL_free(), implemented?

I am following openvpn's release/2.3 branch on github:
https://github.com/openvpn/openvpn/tree/release/2.3

Thanks

-- 
Regards
Shubham Chauhan

--001a11c3c26cd3419105310e7057
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I was going through the codebase=
, and found myself a bit confused. I wanted to customize some functionaliti=
es and run some tests</div><div><br></div><div>I was specifically looking f=
or the methods where we start (performing the handshake) and end an OpenSSL=
 session.</div><div><br></div><div>How and where are the OpenSSL calls like=
 the SSL_connect(), SSL_SESSION_free(), SSL_shutdown(), =C2=A0SSL_free(), i=
mplemented?</div><div><br></div><div>I am following openvpn&#39;s release/2=
.3 branch on github:=C2=A0<a href=3D"https://github.com/openvpn/openvpn/tre=
e/release/2.3">https://github.com/openvpn/openvpn/tree/release/2.3</a></div=
><div><br></div><div>Thanks<br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature"><div dir=3D"ltr">Regards<br>Shubham Chauhan<br></div=
></div>
</div></div>

--001a11c3c26cd3419105310e7057--

