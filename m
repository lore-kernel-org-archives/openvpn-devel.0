MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Wed, 25 Nov 2020 10:33:21 +0800
Message-ID: <CAAUX2SUjd8azhSZta8KT8b2LjTG6v7P6LxKwVN1-+U6B8_vtJg@...278...>
Content-Type: multipart/alternative; boundary="000000000000e7672805b4e54022"
Subject: [Openvpn-devel] [ovpn-dco] question about the comment about AEAD
 nonce
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net

--000000000000e7672805b4e54022
Content-Type: text/plain; charset="UTF-8"

Hi Antonio,

I'm reading the source code to study this module driven by intertest. I'm
new to crypto stuffs. In pktid.h:

/* When the OpenVPN protocol is run in AEAD mode, use
 * the OpenVPN packet ID as the AEAD nonce:
 *
 *    00000005 521c3b01 4308c041 83ba3099
 *    [seq # ] [nonce_tail                                    ]
 *    [               12-byte full IV                            ] ->
NONCE_SIZE
 *    [4-bytes                                                       ->
NONCE_WIRE_SIZE
 *    on wire]
 */

/* AEAD nonce size */
#define NONCE_SIZE 12

Is " 00000005 521c3b01 4308c041 83ba3099" wrong? Its size is 16 bytes, but
you also comment
"12-byte full IV" after two lines of it.

Tony

--000000000000e7672805b4e54022
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Antonio,<div><br></div><div>I&#39;m reading the source =
code to study this module driven by intertest. I&#39;m new to crypto stuffs=
. In pktid.h:</div><div><br></div><div>/* When the OpenVPN protocol is run =
in AEAD mode, use<br>=C2=A0* the OpenVPN packet ID as the AEAD nonce:<br>=
=C2=A0*<br>=C2=A0* =C2=A0 =C2=A000000005 521c3b01 4308c041 83ba3099<br>=C2=
=A0* =C2=A0 =C2=A0[seq # ] [nonce_tail=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ]<br>=C2=A0* =C2=A0 =C2=A0[ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 12-byte full IV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ] -&gt; NONCE_S=
IZE<br>=C2=A0* =C2=A0 =C2=A0[4-bytes=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0-&gt; NONCE_WIRE_SIZE<br>=C2=A0* =C2=A0 =C2=A0on wire]<br>=C2=A0*=
/<br><br>/* AEAD nonce size */<br>#define NONCE_SIZE 12<br></div><div><br><=
/div><div>Is &quot; 00000005 521c3b01 4308c041 83ba3099&quot; wrong? Its si=
ze is 16 bytes, but you also comment</div><div>&quot;12-byte full IV&quot; =
after two lines of it.=C2=A0</div><div><br></div><div>Tony</div></div>

--000000000000e7672805b4e54022--

