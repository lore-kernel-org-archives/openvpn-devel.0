MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sun, 2 May 2021 19:13:16 -0400
Message-ID: <CAKuzo_izpuBXtnXHq2=QfSOen8OY0np-Gy=0=wA23uuCq6Etew@...278...>
Content-Type: multipart/alternative; boundary="000000000000451d8305c160fe53"
Subject: [Openvpn-devel] Adding RSA-PSS support in pkcs11-helper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>, tincanteksup <tincanteksup@...277...>

--000000000000451d8305c160fe53
Content-Type: text/plain; charset="UTF-8"

Hi,

Currently RSA-PSS signatures are handled in pkcs11-helper by asking the
token to do raw RSA signature of data already padded by OpenSSL. Many new
hardware tokens refuse to support this mode and require the padding to be
done in hardware.

For a recent user report see this thread:
https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg05732.html

Probably there are some related tickets on Trac too.

In OpenVPN, we have a couple of options to fix this:

(i) Use a different library like libp11 (for OpenSSL only).
(ii) Extend pkcs11-helper
(iii) Roll something new on our own :)

After some thought, I have decided that extending pkcs11-helper may be the
least painful approach --- not including the mental distress in getting
code reviews and changes accepted. The "helper" has several features that
we depend on and not readily available in alternatives.

If anyone is interested in testing this, see
https://github.com/selvanair/pkcs11-helper/releases/tag/pss-support

Though I've opened a PR at https://github.com/OpenSC/pkcs11-helper/pull/31
, it's only an RFC and would likely require some iterations.

Comments, suggestions for improvement, and test reports, are most welcome.

Thanks,

Selva

--000000000000451d8305c160fe53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Currently RSA-PSS signatures are handled in pkc=
s11-helper by asking the token to do raw RSA signature of data already padd=
ed by OpenSSL. Many new hardware tokens refuse to support this mode and req=
uire the padding to be done in hardware.<br><br>For a recent user report se=
e this thread:<br><a href=3D"https://www.mail-archive.com/openvpn-users@...1484...=
ts.sourceforge.net/msg05732.html">https://www.mail-archive.com/openvpn-user=
s@lists.sourceforge.net/msg05732.html</a><br><br>Probably there are some re=
lated tickets on Trac too.<div>=C2=A0<br>In OpenVPN, we have a couple of op=
tions to fix this:</div><div><br>(i) Use a different library like libp11 (f=
or OpenSSL only).<br>(ii) Extend pkcs11-helper<br>(iii) Roll something new =
on our own :)<br><br>After some thought, I have decided that extending pkcs=
11-helper may be the least painful approach ---=C2=A0not including the ment=
al distress in getting code reviews and changes accepted. The &quot;helper&=
quot; has several features that we depend on and not readily available in a=
lternatives.<br><br>If anyone is interested in testing this, see<br><a href=
=3D"https://github.com/selvanair/pkcs11-helper/releases/tag/pss-support">ht=
tps://github.com/selvanair/pkcs11-helper/releases/tag/pss-support</a><br><b=
r></div><div>Though I&#39;ve opened a PR at <a href=3D"https://github.com/O=
penSC/pkcs11-helper/pull/31">https://github.com/OpenSC/pkcs11-helper/pull/3=
1</a> , it&#39;s only an RFC and would likely require=C2=A0some iterations.=
<br><br>Comments, suggestions for improvement, and test reports, are most w=
elcome.<br><br>Thanks,<br><br>Selva</div></div>

--000000000000451d8305c160fe53--

