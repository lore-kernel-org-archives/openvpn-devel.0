MIME-Version: 1.0
References: <20220310115718.11188-1-gert@...1296...>
 <CAAYFXLmCztuh1AZHzdGW=3cKM9g5GjaEWy4pBWzbsaGsp7ri+w@...278...>
 <YioVqLia58hlN1RI@...1296...>
In-Reply-To: <YioVqLia58hlN1RI@...1296...>
From: Pete Nelson <petiepooo@...277...>
Date: Thu, 10 Mar 2022 18:32:05 +0000
Message-ID: <CAAYFXLkaXFubFWMf2J-PQR+GshnJ3Y0o+4UPfL2nPg9XN1R8Lg@...278...>
Content-Type: multipart/alternative; boundary="000000000000f477e105d9e16e76"
Subject: Re: [Openvpn-devel] [PATCH] Enable deferred auth for multiple
 plugins (RFC).
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000f477e105d9e16e76
Content-Type: text/plain; charset="UTF-8"

Hi Gert.

On Thu, Mar 10, 2022 at 3:13 PM Gert Doering <gert@...1296...> wrote:

> Yes, your report triggered this work.  I think I misunderstood the
> original scenario (I thought it involved two plugins both going
> "deferred"), but this patch introduces a "short circuit" approach
> to plugin authentication where anything that fails will immediately
> abort all other plugin calls.  So, it will fix that scenario(*).
>

You didn't misunderstand; they were always two separate issues.  I just
noticed the multiple-deferred issue when I was reviewing the code for why
it wasn't failing on the first fail.  The multiple-deferred issue I brought
to the sec list, and I submitted https://patchwork.openvpn.net/patch/2071/
as a possible fix for the other.  It's likely moot now with your other
updates.

Thanks for the multi-auth plugin source.  I'll try to make the community
IRC on the 12th; it's just real early for me.
--
Pete

--000000000000f477e105d9e16e76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gert.<br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 10, 2022 at 3:13 PM Gert Doer=
ing &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Yes, your report =
triggered this work.=C2=A0 I think I misunderstood the <br>
original scenario (I thought it involved two plugins both going <br>
&quot;deferred&quot;), but this patch introduces a &quot;short circuit&quot=
; approach <br>
to plugin authentication where anything that fails will immediately<br>
abort all other plugin calls.=C2=A0 So, it will fix that scenario(*).<br></=
blockquote><div><br></div><div>You didn&#39;t misunderstand; they were alwa=
ys two separate issues.=C2=A0 I just noticed the multiple-deferred issue wh=
en I was reviewing the code for why it wasn&#39;t failing on the first fail=
.=C2=A0 The multiple-deferred issue I brought to the sec list, and I submit=
ted <a href=3D"https://patchwork.openvpn.net/patch/2071/">https://patchwork=
.openvpn.net/patch/2071/</a> as a possible fix for the other.=C2=A0 It&#39;=
s likely moot now with your other updates.<br></div><div>=C2=A0</div><div>T=
hanks for the multi-auth plugin source.=C2=A0 I&#39;ll try to make the comm=
unity IRC on the 12th; it&#39;s just real early for me.<br></div><div>--</d=
iv><div>Pete<br></div></div></div>

--000000000000f477e105d9e16e76--

