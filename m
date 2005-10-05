From: =?iso-8859-2?q?Sz=FCts=20P=E9ter=20?= <pelo@...468...>
Message-ID: <DPG.WIN.400.0509181859229314825870@...469...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Client's private key
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct  5 12:20:58 2005
Content-type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


Hello !

I've read somewhere in the OpenVPN documentation that the client uses the s=
erver's public key to encode the temporary secret and the server uses its p=
rivate key to decode it. After that the secure channel could be encrypted w=
ith the temporary secret. But where do we use the client's private key ? Wh=
y do we need it anyway ? I tried to establish a connection without the clie=
nt's private key, but ended up with an error. Sorry for my English and than=
ks in advance. :)

Peter

--=20
P=E9L=F3
