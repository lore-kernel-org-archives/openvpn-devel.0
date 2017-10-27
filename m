MIME-Version: 1.0
Sender: r.owen.mays@...277...
From: Lefty <leftygamer@...277...>
Date: Thu, 26 Oct 2017 22:20:55 -0700
Message-ID: <CACtGRr8ZoT9xi_MFsqOrRnGEAZqM9yVwZCCy1H1zWDpc0PGo3Q@...278...>
Content-Type: multipart/alternative; boundary="94eb2c1443923cfe15055c8075a8"
Subject: [Openvpn-devel] Windows build 2.4.4 fails signature verification
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c1443923cfe15055c8075a8
Content-Type: text/plain; charset="UTF-8"

Hi all,

I recently downloaded the openvpn-install-2.4.4-I601.exe Windows installer,
along with the openvpn-install-2.4.4-I601.exe.asc signature file.

I imported Samuli's new key ( fingerprint 6D04 F8F1 B017 3111 F499 795E
2958 4D9F 4086 4578).
When I run PGP I get the following output:

gpg: armor header: Version: GnuPG v1
gpg: assuming signed data in 'openvpn-install-2.4.4-I601.exe'
gpg: Signature made 09/26/17 06:19:55 Pacific Daylight Time
gpg:                using RSA key D72AF3448CC2B034
gpg: Can't check signature: No public key

It appears the installer has been signed with the "Security Mailing List
GPG Key" instead of the key described on the sig page.

Am I doing the verification wrong?
Any suggestions much appreciated!

-Lefty

--94eb2c1443923cfe15055c8075a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi all,<br><br></div>I recently downloaded the o=
penvpn-install-2.4.4-I601.exe Windows installer, along with the openvpn-ins=
tall-2.4.4-I601.exe.asc signature file.<br><br></div>I imported Samuli&#39;=
s new key ( fingerprint 6D04 F8F1 B017 3111 F499 795E 2958 4D9F 4086 4578).=
 <br><div><div><div>When I run PGP I get the following output:</div><div><b=
r></div><div>gpg: armor header: Version: GnuPG v1<br>gpg: assuming signed d=
ata in &#39;openvpn-install-2.4.4-I601.exe&#39;<br>gpg: Signature made 09/2=
6/17 06:19:55 Pacific Daylight Time<br>gpg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 using RSA key =
D72AF3448CC2B034<br>gpg: Can&#39;t check signature: No public key<br></div>=
<div><br></div><div>It appears the installer has been signed with the &quot=
;Security Mailing List GPG Key&quot; instead of the key described on the si=
g page.</div><div><br></div><div>Am I doing the verification wrong? <br></d=
iv><div>Any suggestions much appreciated!</div><div><br></div><div>-Lefty</=
div></div></div></div>

--94eb2c1443923cfe15055c8075a8--

