MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 1 Jan 2018 14:57:17 +0100
Message-ID: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
Content-Type: multipart/alternative; boundary="94eb2c046b9e3921bb0561b75c92"
Subject: [Openvpn-devel] PKCS#11 - a little bit of help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c046b9e3921bb0561b75c92
Content-Type: text/plain; charset="UTF-8"

Hello everybody,

I'm trying to get openvpn read my certificates from a TPM2 using a
specially crafted PKCS#11 provider (the existing tpm2-pk11 is quite limited
for now but I might be able to extend it).

However, the PKCS#11 API is not something I'm comfortable with, and I'd
like to know if there is some document (design or anything, really) that
could help me to understand what openvpn wants exactly in order for me to
provide the missing bits. I've read the documents at [1] but found nothing
here of interest (for me).

So, does someone have any pointer?

Best regards,

-- Emmanuel Deloget

[1] https://openvpn.net/index.php/open-source/documentation.html

--94eb2c046b9e3921bb0561b75c92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello everybody,=C2=A0</div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:monospace,monospace">I&#39;m trying to get openvpn re=
ad my certificates from a TPM2 using a specially crafted PKCS#11 provider (=
the existing tpm2-pk11 is quite limited for now but I might be able to exte=
nd it).=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace">However, the PKCS#11 API is not something I&#39;m comf=
ortable with, and I&#39;d like to know if there is some document (design or=
 anything, really) that could help me to understand what openvpn wants exac=
tly in order for me to provide the missing bits. I&#39;ve read the document=
s at [1] but found nothing here of interest (for me).=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace">So, does=
 someone have any pointer?=C2=A0</div><div class=3D"gmail_default" style=3D=
"font-family:monospace,monospace"><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:monospace,monospace">Best regards,=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace">-- Emman=
uel Deloget</div><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace">[1] <a href=3D"https://openvpn.net/index.php/open-source=
/documentation.html">https://openvpn.net/index.php/open-source/documentatio=
n.html</a><br></div></div>

--94eb2c046b9e3921bb0561b75c92--

