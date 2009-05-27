MIME-Version: 1.0
Sender: fyellin@...277...
Date: Wed, 27 May 2009 10:48:30 -0700
Message-ID: <f9615cc80905271048v646f546fod19ecec32c2a172a@...278...>
From: Frank Yellin <fy@...1222...>
Content-Type: multipart/alternative; boundary=0016362836a096c611046ae8737e
Subject: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0016362836a096c611046ae8737e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I posted the following onto the OpenVPN forum, but it was suggested that I
would be better off mailing directly to this list.

=========================

I seem to have found a bug in 2.1_rc16 that is also apparent in earlier
versions. Although OpenVPN claims to support -CFB and -OFB cipher modes,
using them seems to cause OpenVPN to crash consistently.

For example, when I run the simple TLS example on the 2.1 documentation
page, it works fine.  But if I add "--cipher bf-cfb" to both the client and
server command lines, one or the other will crash. The error message is
always "Assertion failed at crypto.c:162". The crasher is always the first
one to try and send an encrypted message.

Looking at that line of code, we have
.... outlen gets number of bytes written from previous EVP_CipherFinal ....
ASSERT(outlen == iv_size)

While for a block cipher such as the default BF-CBC, it makes sense that
EVP_CipherFinal always writes out a final block, this is not the case for a
stream ciphers.  For stream ciphers, EVP_CipherFinal may write out no bytes
whatsover! I don't quite understand the rest of the code, so I'm not quite
sure whether this is necessary for the rest of the code to run successfuly,
or if this is just an incorrect sanity check.
.
 When I comment out this line, the program runs just fine, and I can
successfully use BF-CFB and BF-OFB.

Thanks.

-- Frank Yellin

--0016362836a096c611046ae8737e
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I posted the following onto the OpenVPN forum, but it was suggested that I =
would be better off mailing directly to this list.<br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br> I seem=
 to have found a bug in 2.1_rc16 that is also apparent in earlier
versions. Although OpenVPN claims to support -CFB and -OFB cipher modes,
using them seems to cause OpenVPN to crash consistently.=A0<br>
=A0<br>
For example, when I run the simple TLS example on the 2.1 documentation
page, it works fine.=A0 But if I add &quot;--cipher bf-cfb&quot; to both th=
e client
and server command lines, one or the other will crash. The error message is
always &quot;Assertion failed at crypto.c:162&quot;. The crasher is always =
the first one to try and send an encrypted message.<br>
=A0<br>
Looking at that line of code, we have<br>
      <div style=3D"margin-left: 40px;"><span style=3D"font-family: courier=
 new,monospace;">.... outlen gets number of bytes written from previous EVP=
_CipherFinal ....=A0</span><br style=3D"font-family: courier new,monospace;=
"><span style=3D"font-family: courier new,monospace;">
      ASSERT(outlen =3D=3D iv_size)=A0</span><br></div>
<br>While for a block cipher such as the default BF-CBC, it makes sense tha=
t EVP_CipherFinal always writes out a final block, this is not the case for=
 a stream ciphers.=A0 For stream ciphers, EVP_CipherFinal may write out no =
bytes whatsover! I don&#39;t quite understand the rest of the code, so I&#3=
9;m not quite sure whether this is necessary for the rest of the code to ru=
n successfuly, or if this is just an incorrect sanity check.<br>
. =A0<br>=A0When I comment out this line, the program runs just fine, and I=
 can successfully use BF-CFB and BF-OFB.<br><br>Thanks.<br><br>-- Frank Yel=
lin<br>

--0016362836a096c611046ae8737e--

