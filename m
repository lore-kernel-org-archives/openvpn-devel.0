MIME-Version: 1.0
Sender: fyellin@...277...
In-Reply-To: <20090528092618.GA31165@...1066...>
References: <f9615cc80905271048v646f546fod19ecec32c2a172a@...278...>
	<20090528055401.GB24851@...1066...>
	<f9615cc80905272317pa53b833vbe66477de31537b9@...278...>
	<20090528092618.GA31165@...1066...>
Date: Fri, 29 May 2009 11:19:10 -0700
Message-ID: <f9615cc80905291119h4e8c5cb1s6632f49aaa693b1b@...278...>
From: Frank Yellin <fy@...1222...>
Content-Type: multipart/alternative; boundary=00163628360aebc631046b111c75
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00163628360aebc631046b111c75
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A simpler way to see the crypto bug. . . .

$ openvpn --secret static.key --test-crypto
     ....
Fri May 29 10:56:58 2009 OpenVPN crypto self-test mode SUCCEEDED.

$ openvpn --secret static.key --test-crypto --cipher bf-ofb
Fri May 29 11:12:07 2009 OpenVPN 2.1_rc15 mipsel-unknown-linux-gnu [SSL]
[LZO2] built on May  2 2009
Fri May 29 11:12:07 2009 OpenVPN 2.1_rc15 mipsel-unknown-linux-gnu [SSL]
[LZO2] built on May  2 2009
Fri May 29 11:12:07 2009 Entering OpenVPN crypto self-test mode.
Fri May 29 11:12:07 2009 TESTING ENCRYPT/DECRYPT of packet length=1
Fri May 29 11:12:07 2009 Assertion failed at crypto.c:162
Fri May 29 11:12:07 2009 Exiting

I'd like someone who understands this code to confirm that the ASSERT is
incorrect.

(I'll also point out the minor bug of the header being printed out twice!)

--00163628360aebc631046b111c75
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

A simpler way to see the crypto bug. . . .<br><br><div style=3D"margin-left=
: 40px;">$ openvpn --secret static.key --test-crypto<br>=A0 =A0=A0 .... <br=
>Fri May 29 10:56:58 2009 OpenVPN crypto self-test mode SUCCEEDED.<br><br>$=
 openvpn --secret static.key --test-crypto --cipher bf-ofb<br>
Fri May 29 11:12:07 2009 OpenVPN 2.1_rc15 mipsel-unknown-linux-gnu [SSL] [L=
ZO2] built on May=A0 2 2009<br>Fri May 29 11:12:07 2009 OpenVPN 2.1_rc15 mi=
psel-unknown-linux-gnu [SSL] [LZO2] built on May=A0 2 2009<br>Fri May 29 11=
:12:07 2009 Entering OpenVPN crypto self-test mode.<br>
Fri May 29 11:12:07 2009 TESTING ENCRYPT/DECRYPT of packet length=3D1<br>Fr=
i May 29 11:12:07 2009 Assertion failed at crypto.c:162<br>Fri May 29 11:12=
:07 2009 Exiting<br><br></div>I&#39;d like someone who understands this cod=
e to confirm that the ASSERT is incorrect.=A0 <br>
<br>(I&#39;ll also point out the minor bug of the header being printed out =
twice!)<br><br><br><br>

--00163628360aebc631046b111c75--

