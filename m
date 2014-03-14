MIME-Version: 1.0
In-Reply-To: <20A288CF-1387-4616-B6C4-9DAEADAB02A7@...1837...>
References: <20A288CF-1387-4616-B6C4-9DAEADAB02A7@...1837...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 14 Mar 2014 12:53:27 +0100
Message-ID: <CAA1Abx+WKEMwkcKA-VmNF7oLEN3+KRNACeKY+fHZGcNodJF0ww@...278...>
Content-Type: multipart/alternative; boundary=001a1132ef84f08fb004f48fb843
Subject: Re: [Openvpn-devel] TLS (SSL) handshake upon reconnecting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Abdullah Alshalan <aalshala@...1837...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1132ef84f08fb004f48fb843
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On 03/13/2014 10:37 PM, Abdullah Alshalan wrote:
> Hi,
> I have a few questions about OpenVPN and I would appreciate if you can
answer whatever you can.

I'll give it a try. I assume these questions relate to the 'Triple
Handshake'-attack (https://secure-resumption.com/). I do not understand all
the details of the attack, but I can tell you what I know about OpenVPN.

> 1- Does OpenVPN use a lightweight SSL handshake upon automatic
reconnection?

No. OpenVPN does not initiate TLS session renegotiation or resumption. The
renegotiation messages in OpenVPN connection logs relate to OpenVPN's
data-session key renegotiations, which are not affected by this attack. For
OpenVPN's control channel, it heavily depends on the underlying crypto
library, either OpenSSL of PolarSSL.

The OpenSSL builds of OpenVPN however might respond to session
renegotiations initiated by a malicious server, I'm not completely sure on
OpenSSL's behaviour. It is not clear to me whether a mitm-initiated
renegotiation is enough to mount the secure-resumption attack.

The PolarSSL builds of OpenVPN have session renegotiation disabled, and
will not participate in session renegotiation at all. These are thus not
affected.

> 2- If so, when does OpenVPN do a full handshake vs. lightweight
(abbreviated) handshake?

See above.

> 3- Does it renogotiate the master key upon reconnection?

On any TLS errors reported by OpenSSL, OpenVPN shuts down the previous TLS
session, and starts a new session from scratch. It relies on OpenSSL to do
the master key renegotiation.

> 4- In a mobile environment, would it be better to replace openssl with
WTLS? what's your take on that?

I don't know. WTLS has some interesting properties for mobile environments,
but its security has not been researched as thoroughly as TLS's. It differs
enough from TLS to require its own thorough analysis.

On a final note, I would like to recommend everybody to use OpenVPN's 'TLS
auth'-keys. These add another layer of security to the TLS channel, and
protect against both DoS and MitM attacks on TLS.

Regards,
-Steffan

--001a1132ef84f08fb004f48fb843
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>On 03/13/2014 10:37 PM, Abdullah Alshalan wrote=
:<br>&gt; Hi,<br>&gt; I have a few questions about OpenVPN and I would appr=
eciate if you can answer whatever you can.<br><br>I&#39;ll give it a try. I=
 assume these questions relate to the &#39;Triple Handshake&#39;-attack (<a=
 href=3D"https://secure-resumption.com/">https://secure-resumption.com/</a>=
). I do not understand all the details of the attack, but I can tell you wh=
at I know about OpenVPN.<br>

<br>&gt; 1- Does OpenVPN use a lightweight SSL handshake upon automatic rec=
onnection? <br><br>No. OpenVPN does not initiate TLS session renegotiation =
or resumption. The renegotiation messages in OpenVPN connection logs relate=
 to OpenVPN&#39;s data-session key renegotiations, which are not affected b=
y this attack. For OpenVPN&#39;s control channel, it heavily depends on the=
 underlying crypto library, either OpenSSL of PolarSSL.<br>

<br>The OpenSSL builds of OpenVPN however might respond to session renegoti=
ations initiated by a malicious server, I&#39;m not completely sure on Open=
SSL&#39;s behaviour. It is not clear to me whether a mitm-initiated renegot=
iation is enough to mount the secure-resumption attack.<br>

<br>The PolarSSL builds of OpenVPN have session renegotiation disabled, and=
 will not participate in session renegotiation at all. These are thus not a=
ffected.<br><br>&gt; 2- If so, when does OpenVPN do a full handshake vs. li=
ghtweight (abbreviated) handshake?<br>

<br>See above.<br><br>&gt; 3- Does it renogotiate the master key upon recon=
nection?<br><br>On any TLS errors reported by OpenSSL, OpenVPN shuts down t=
he previous TLS session, and starts a new session from scratch. It relies o=
n OpenSSL to do the master key renegotiation.<br>

<br>&gt; 4- In a mobile environment, would it be better to replace openssl =
with WTLS? what&#39;s your take on that?<br><br>I don&#39;t know. WTLS has =
some interesting properties for mobile environments, but its security has n=
ot been researched as thoroughly as TLS&#39;s. It differs enough from TLS t=
o require its own thorough analysis.<br>

<br>On a final note, I would like to recommend everybody to use OpenVPN&#39=
;s &#39;TLS auth&#39;-keys. These add another layer of security to the TLS =
channel, and protect against both DoS and MitM attacks on TLS.<br><br>
Regards,<br>
-Steffan<br><br></div>

--001a1132ef84f08fb004f48fb843--

