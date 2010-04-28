MIME-Version: 1.0
In-Reply-To: <4B22D7B2.8070903@...41...>
References: <411d6d370912111509s7dafa468p80e1e41537a5a976@...278...> 
	<4B22D7B2.8070903@...41...>
From: Jon Onstott <jononstott@...277...>
Date: Wed, 28 Apr 2010 09:34:17 -0700
Message-ID: <p2z411d6d371004280934h56cd4aa5yfcfc2d6ec94befcb@...278...>
Content-Type: multipart/alternative; boundary=001636457042fb785304854e9594
Subject: Re: [Openvpn-devel] Building the TAP drivers from source and then
	signing them (possible?)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

--001636457042fb785304854e9594
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I would like to go ahead and compile and sign the TAP drivers myself.  Does
anyone know which certificate would be best to purchase?

Thanks,
-Jon

On Fri, Dec 11, 2009 at 4:37 PM, James Yonan <jim@...41...> wrote:

> Jon Onstott wrote:
>
>> Hello,
>>
>> I am compiling OpenVPN and the TAP driver from source and would like the
>> TAP driver to be signed so that it installs correctly on Vista (and doesn't
>> pop-up warning dialog boxes).  I noticed that the configure scripts attempt
>> to do that if "signtool" is defined.  Is there any way that I could sign the
>> TAP driver?
>>
>
> I think for most people, signing drivers themselves would be more pain than
> it's worth.  You have to get a special certificate from Verisign that costs
> ~$450/year.  You have to get the full WDK toolchain from Microsoft.
>
>  I have thought about using the prebuilt TAP driver (from
>> openvpn.net/prebuilt/ <http://openvpn.net/prebuilt/>) but the prebuilt
>> binaries lag behind the current version and I need the TAP driver to be the
>> most recent one possible.
>>
>
> The TAP driver in http://openvpn.net/prebuilt/ is based on rc22 which is
> identical to the driver that was just released with 1.2.0.
>
> James
>

--001636457042fb785304854e9594
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I would like to go ahead and compile and sign the TAP drivers=
 myself.=A0 Does anyone know which certificate would be best to purchase?<b=
r><br>Thanks,<br>-Jon<br><br><div class=3D"gmail_quote">On Fri, Dec 11, 200=
9 at 4:37 PM, James Yonan <span dir=3D"ltr">&lt;<a href=3D"mailto:jim@...1362...=
..." target=3D"_blank">jim@...41...</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div>Jon Onstott wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hello,<br>
<br>
I am compiling OpenVPN and the TAP driver from source and would like the TA=
P driver to be signed so that it installs correctly on Vista (and doesn&#39=
;t pop-up warning dialog boxes). =A0I noticed that the configure scripts at=
tempt to do that if &quot;signtool&quot; is defined. =A0Is there any way th=
at I could sign the TAP driver?<br>



</blockquote>
<br></div>
I think for most people, signing drivers themselves would be more pain than=
 it&#39;s worth. =A0You have to get a special certificate from Verisign tha=
t costs ~$450/year. =A0You have to get the full WDK toolchain from Microsof=
t.<br>



<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
I have thought about using the prebuilt TAP driver (from <a href=3D"http://=
openvpn.net/prebuilt/" target=3D"_blank">openvpn.net/prebuilt/</a> &lt;<a h=
ref=3D"http://openvpn.net/prebuilt/" target=3D"_blank">http://openvpn.net/p=
rebuilt/</a>&gt;) but the prebuilt binaries lag behind the current version =
and I need the TAP driver to be the most recent one possible.<br>



</blockquote>
<br>
The TAP driver in <a href=3D"http://openvpn.net/prebuilt/" target=3D"_blank=
">http://openvpn.net/prebuilt/</a> is based on rc22 which is identical to t=
he driver that was just released with 1.2.0.<br><font color=3D"#888888">
<br>
James<br>
</font></blockquote></div><br>

--001636457042fb785304854e9594--

