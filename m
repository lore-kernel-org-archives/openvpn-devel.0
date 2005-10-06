From: =?iso-8859-2?q?Sz=FCts=20P=E9ter=20?= <pelo@...468...>
Message-ID: <DPG.WIN.400.0509182229354737875638@...469...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Client key exchange (fwd)
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
Date: Thu Oct  6 13:28:25 2005
Content-type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


Hello !

I see I have to be more specific, otherwise you underestimate me. :)) So he=
re's the big deal:
I've found OpenVPN client key exchange in http://www.sans.org/rr/whitepaper=
s/vpns/1459.php It says in message 3: "The client also generates and sends =
what is called a pre-master secret. The pre-master secret is the last param=
eter in the key derivation/exchange function and is encrypted with the serv=
er's public key."=20
In the end we have the same pre-master secret on both sides and the client =
and server could generate the same master secret with a well-known mechanis=
m. It's all clear, but the OpenVPN howto says I have to declare in the clie=
nt configuration file where to find the client's private key. If OpenVPN us=
es the key derivation method mentioned above, why do we need the client's p=
rivate key in the config file ? Where are we using it ? By accident, don't =
you have a flow chart or message exchange figure about this ? :)
Otherwise I'm a student from Budapest Technical and Economical University, =
faculty of electrical engineering, dealing with electrical services and sec=
urity. We're working on a project, that's why we need this information. Tha=
nks in advance:

Peter


