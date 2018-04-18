MIME-Version: 1.0
In-Reply-To: <a2e0b87d-19bc-3b7b-4873-b211edab78a0@...515...>
References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
 <99D61A626FDA8A4B90A270669121BE10862C1C09@...2294...>
 <a2e0b87d-19bc-3b7b-4873-b211edab78a0@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 18 Apr 2018 13:22:52 -0400
Message-ID: <CAKuzo_gTpFDQ9YV70WDD_EEMiScAJL+eQ9wZWyT2REg43yHGCg@...278...>
Content-Type: multipart/alternative; boundary="000000000000ac4377056a22b531"
Subject: Re: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--000000000000ac4377056a22b531
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 17, 2018 at 3:01 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

>
>
> Excellent and thanks for testing! This gives me a lot more confidence in
> the Authenticode signature.
>

I don't want to question that as none of my Windows hosts complains about
the signature. But the driver details tab shows the file as not digitally
signed. That's as in, adapter properties -> driver -> driver details. One
level before that it shows Digital signer: OpenVPN Tech.. Go figure.. And
likely this "problem" existed in previous version too. This is on Windows 7.

Looking into this further using pnputil and sigverify:

C:\Windows\System32>pnputil -e
Microsoft PnP Utility

.. snipped...

Published name :            oem13.inf
Driver package provider :   Microsoft
Class :                     Printers
Driver date and version :   05/28/2012 15.0.4128.4000
Signer name :               Microsoft Windows Hardware Compatibility
Publisher

Published name :            oem14.inf
Driver package provider :   TAP-Windows Provider V9
Class :                     Network adapters
Driver date and version :   04/13/2018 9.00.00.21
Signer name :

...snipped...

C:\Windows\System32\catroot>  sigverify

This also lists tap0901.sys as unsigned.

Is this a known Windows 7 issue? Will check Windows 10 later tonight.

Selva

--000000000000ac4377056a22b531
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi,<br><br></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote">On Tue, Apr 17, 2018 at 3:01 AM=
, Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...1387...=
5..." target=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div class=3D"m_619487726974665781=
4gmail-HOEnZb"><div class=3D"m_6194877269746657814gmail-h5"><br>
<br>
</div></div>Excellent and thanks for testing! This gives me a lot more conf=
idence in<br>
the Authenticode signature.<br></blockquote><div><br></div><div>I don&#39;t=
 want to question that as none of my Windows hosts complains about the sign=
ature. But the driver details tab shows the file as not digitally signed. T=
hat&#39;s as in, adapter properties -&gt; driver -&gt; driver details. One =
level before that it shows Digital signer: OpenVPN Tech.. Go figure.. And l=
ikely this &quot;problem&quot; existed in previous version too. This is on =
Windows 7.<br><br></div><div>Looking into this further using pnputil and si=
gverify:<br><br>C:\Windows\System32&gt;pnputil -e<br>Microsoft PnP Utility<=
br><br></div><div>.. snipped...<br><br></div><div>Published name :=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oem13.inf<br>Driv=
er package provider :=C2=A0=C2=A0 Microsoft<br>Class :=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Printers<br>Driver date and version :=C2=A0=C2=A0 =
05/28/2012 15.0.4128.4000<br>Signer name :=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Microsoft Windows Hardw=
are Compatibility Publisher<br><br>Published name :=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oem14.inf<br>Driver package prov=
ider :=C2=A0=C2=A0 TAP-Windows Provider V9<br>Class :=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Network adapters<br>Driver date and version :=C2=
=A0=C2=A0 04/13/2018 9.00.00.21<br>Signer name :<br><br>...snipped...<br><b=
r>C:\Windows\System32\catroot&gt;=C2=A0 sigverify<br><br></div><div>This al=
so lists tap0901.sys as unsigned.<br><br></div><div>Is this a known Windows=
 7 issue? Will check Windows 10 later tonight.<br><br></div><div>Selva<br><=
/div></div></div></div>

--000000000000ac4377056a22b531--

