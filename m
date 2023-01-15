MIME-Version: 1.0
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
In-Reply-To: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 15 Jan 2023 08:23:11 -0500
Message-ID: <CAKuzo_i+zwgpg_zq050WQtNm+s0p-OMDkLGUUHn+hSApJfrorA@...278...>
Content-Type: multipart/alternative; boundary="0000000000003d929f05f24d5f9f"
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0000000000003d929f05f24d5f9f
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to be able to continue to build/ship OpenVPN with mbed
> TLS. We want all contributors to ask if they agree to license change
> that adds explicit permission to link with Apache 2 licensed libraries:
>
>
> Special exception for linking OpenVPN with Apache 2 licensed libraries:
>
>    In addition, as a special exception, OpenVPN Inc and contributors
>    give permission to link the code of this program to libraries with the
>    "APACHE LICENSE, VERSION 2.0", and distribute linked combination
>    including the two.  You must obey the GNU General Public License in
>    all respects for all of the code used other than these libraries.  If
>    you modify this file, you may extend this exception to your version of
>    the file, but you are not obligated to do so.  If you do not wish to
>    do so, delete this exception statement from your version.
>

Instead of this exemption I would vote for a change to 'GPL v2 or any later
version'.
That would keep the license in the spirit by which people like me
contributed.

Using an existing license that has already been vetted also avoids the need
for legal counsel.

I do not understand the argument about 'GPLv2 and later...' and embedded
devices. Those who
are currently embedding based on GPL v2 can continue to do so, those who
want/need v3
can do so too. Those who need v3 but also want to lock the firmware on a
consumer device
may be affected. But that's a choice they make, why would we want to
promote that?

Some may find this discussion a waste of time but let's not belittle
people's contributions.
I do care about how my work is licensed.

Selva

--0000000000003d929f05f24d5f9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">We would like to be able to continue t=
o build/ship OpenVPN with mbed <br>
TLS. We want all contributors to ask if they agree to license change <br>
that adds explicit permission to link with Apache 2 licensed libraries:<br>
<br>
<br>
Special exception for linking OpenVPN with Apache 2 licensed libraries:<br>
<br>
=C2=A0 =C2=A0In addition, as a special exception, OpenVPN Inc and contribut=
ors<br>
=C2=A0 =C2=A0give permission to link the code of this program to libraries =
with the<br>
=C2=A0 =C2=A0&quot;APACHE LICENSE, VERSION 2.0&quot;, and distribute linked=
 combination<br>
=C2=A0 =C2=A0including the two.=C2=A0 You must obey the GNU General Public =
License in<br>
=C2=A0 =C2=A0all respects for all of the code used other than these librari=
es.=C2=A0 If<br>
=C2=A0 =C2=A0you modify this file, you may extend this exception to your ve=
rsion of<br>
=C2=A0 =C2=A0the file, but you are not obligated to do so.=C2=A0 If you do =
not wish to<br>
=C2=A0 =C2=A0do so, delete this exception statement from your version.<br><=
/blockquote><div><br></div><div>Instead of this exemption=C2=A0I would vote=
 for a change to &#39;GPL v2 or any later version&#39;.</div><div>That woul=
d keep the license in the spirit by which people like me contributed.=C2=A0=
</div><div><br></div><div>Using an existing=C2=A0license that has already b=
een vetted also avoids the need</div><div>for legal counsel.</div><div><br>=
</div><div>I do not understand the argument about &#39;GPLv2 and later...&#=
39; and embedded devices. Those who</div><div>are currently=C2=A0embedding =
based on GPL v2 can continue to do so, those who want/need v3</div><div>can=
 do so too. Those who need=C2=A0v3 but also want to lock the firmware=C2=A0=
on a consumer device</div><div>may be affected. But that&#39;s a choice the=
y make, why would we want to promote that?</div><div><br></div><div>Some ma=
y find this discussion a waste of time but let&#39;s not belittle people&#3=
9;s contributions.</div><div>I do care about how my work is licensed.</div>=
<div><br></div></div><div class=3D"gmail_quote"><div>Selva</div></div></div>

--0000000000003d929f05f24d5f9f--

