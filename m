MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <CAKh=nwFF-Lc-Q52QCoh0WgP3g0gr0P7_i9CqwcpC2mDzGCi8sw@...278...>
References: <cover.1487368114.git.logout@...260...>
	<e5e93420586b24b7df5b2f5ac2df02ccec5ffdb1.1487368114.git.logout@...260...>
	<66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
	<20170302212621.GE93896@...1296...>
	<735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>
	<72797fe3-23f7-8b10-19df-29cc4f31ef98@...2080...>
	<CAKh=nwFF-Lc-Q52QCoh0WgP3g0gr0P7_i9CqwcpC2mDzGCi8sw@...278...>
From: Emmanuel Deloget <logout@...260...>
Date: Tue, 28 Mar 2017 10:43:54 +0200
Message-ID: <CAKh=nwEuwUVdVK5pu=tW40=YH2bJ-0UxmhPpPoTy0n7m+-5hpQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c123caccb29e4054bc6757a
Subject: Re: [Openvpn-devel] [RFC PATCH v1 05/15] OpenSSL: don't use direct
 access to the internal of X509
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c123caccb29e4054bc6757a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm not sure why but it seems this mail (that I send yesterday) never found
its way to the ML. So I re-send it.

Sorry for the inconvenience.

BR,

-- Emmanuel Deloget

On Mon, Mar 27, 2017 at 5:49 PM, Emmanuel Deloget <logout@...260...> wrote:

> Hi everyone,
>
> I got some time to try to fix all that stuff.
>
> First,
>
> On Sat, Mar 4, 2017 at 11:38 PM, David Sommerseth <openvpn@...2142...
> topphemmelig.net> wrote:
>
>> On 04/03/17 16:13, Steffan Karger wrote:
>> > As a last resort, we could consider keeping the old code inside #if
>> > OSSL_VER < 1.1.0 in release/2.4, but that might just create more
>> > confusion...
>>
>
>
> =E2=80=8BI think I found a solution -- see later in the email.=E2=80=8B
>
> I had a closer look to the corresponding code to see what are the
> differences between the old check and the new one -- and indeed,
> the discrepancies might only happen if the tested certificate is
> kind-of-weird. For exemple, a client certificate:
>
> * has the client bit set
> * has no key, or has a key but the key usage is neither for
>   signature nor for key agreement
> * is not used to auth a client
>
> =E2=80=8BIf a user creates a Frankenstein certificate that look like this,
> it might be a good idea to warn him that such certificate is very
> likely to be refused in the near future (one can have a similar
> reasonning about server certificates).
>
>
>
>>
>> Just a very quick thought here ... I do dislike different behaviours
>> depending on which OpenSSL version being used.  But given that this
>> feature is already deprecated and even removed in OpenSSL-1.1, I think
>> that gives us some options.
>>
>> I agree with Gert that breaking --ns-cert-type isn't good at all.
>> However, consider when people upgrade from OpenSSL v1.0 to v1.1 - that
>> is most commonly when there is major distro update.  It is not something
>> which happens "mid-term", as OpenSSL is quite commonly used by lots of
>> base system packages these days.
>>
>> Regardless of OpenSSL version, I agree to loudly deprecate
>> --ns-cert-type, through documentation, --help and log files.
>>
>> But I think we need to carry the existing behaviour for --ns-cert-type
>> when built against OpenSSL v1.0.  And we can solve through some
>> compatibility wrapper when built against OpenSSL v1.1 - with even louder
>> warnings in the logs that this may break apart.
>>
>
>
> =E2=80=8BFortunately, I think I found a solution that would help
> when using OpenSSL 1.1. Idealy, this should be a call
> to X509_check_purpose(.., X509_PURPOSE_SSL_*_WEAK, ...)=E2=80=8B
> but I don't think the OpenSSL developers will accept such
> a change :)
>
> It might be possible to use the X509_get_ext_d2i() call
> like this:
>
> void *ns =3D X509_get_ext_d2i(x, NID_netscape_cert_type,
>                             NULL, NULL);
>
> =E2=80=8BIn this case, the =E2=80=8Bobtained ns object contains the data
> we're interested in:
>
> * if it exists, then EXFLAG_NSCERT is set
> * if not null, ns is of type ASN1_BIT_STRING, and this
>   type is not opaque (yep, sir).
>
> =E2=80=8BSo the code would look like:
>
> =E2=80=8BASN1_BIT_STRING *ns;
> result_t result =3D FAILURE;
> ns =3D X509_get_ext_d2i(x, NID_netscape_cert_type, NULL, NULL);
> if (ns)
> {
>     if (ns->length > 0)
>     {
>         int flags =3D ns->data[0];
>         if (flags & NS_SSL_CLIENT)
>         {
>             result =3D SUCCESS;
>         }
>     }
>     ASN1_BIT_STRING_free(ns);
> }
>
>
> =E2=80=8BFor the record, it's the code =E2=80=8Bthat is used within funct=
ion
> x509v3_cache_extensions() which builds the X509 flags we
> are using so I'm failry confident it's the right thing to
> do (but it's a bit convoluted and I don't like it much).
>
> =E2=80=8BGood news: the same code should work with nearly all the
> previous versions of OpenSSL.
>
>
>
>> =E2=80=8B<snip>
>>
>>
>> --
>> kind regards,
>>
>> David Sommerseth
>> OpenVPN Technologies, Inc
>>
>
>
> I'll post my new patches as soon as I get over every issues
> that have been talked on the ML (is that even a valid
> sentence?)
>
> =E2=80=8BBest regards,
>
> -- Emmanuel Deloget=E2=80=8B
>

--94eb2c123caccb29e4054bc6757a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace">Hi,=C2=A0</div><div class=3D"gmail_default" style=3D"font-fa=
mily:courier new,monospace"><br></div><div class=3D"gmail_default" style=3D=
"font-family:courier new,monospace">I&#39;m not sure why but it seems this =
mail (that I send yesterday) never found its way to the ML. So I re-send it=
.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:courier new,=
monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:cour=
ier new,monospace">Sorry for the inconvenience.</div><div class=3D"gmail_de=
fault" style=3D"font-family:courier new,monospace"><br></div><div class=3D"=
gmail_default" style=3D"font-family:courier new,monospace">BR,=C2=A0</div><=
div class=3D"gmail_default" style=3D"font-family:courier new,monospace"><br=
></div><div class=3D"gmail_default" style=3D"font-family:courier new,monosp=
ace">-- Emmanuel Deloget</div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Mon, Mar 27, 2017 at 5:49 PM, Emmanuel Deloget <span dir=3D=
"ltr">&lt;<a href=3D"mailto:logout@...260..." target=3D"_blank">logout@...1665...=
60...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"l=
tr"><div style=3D"font-family:&quot;courier new&quot;,monospace">Hi everyon=
e,=C2=A0</div><div style=3D"font-family:&quot;courier new&quot;,monospace">=
<br></div><div style=3D"font-family:&quot;courier new&quot;,monospace">I go=
t some time to try to fix all that stuff.=C2=A0</div><div style=3D"font-fam=
ily:&quot;courier new&quot;,monospace"><br></div><div style=3D"font-family:=
&quot;courier new&quot;,monospace">First,=C2=A0</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote"><span class=3D"">On Sat, Mar 4, 2017 at=
 11:38 PM, David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn=
@...2080..." target=3D"_blank">openvpn@...2142...<wbr>topphemmelig.net</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><spa=
n class=3D"m_-3997936357445731331gmail-">On 04/03/17 16:13, Steffan Karger =
wrote:<br>
&gt; As a last resort, we could consider keeping the old code inside #if<br>
&gt; OSSL_VER &lt; 1.1.0 in release/2.4, but that might just create more<br>
&gt; confusion...<br></span></blockquote><div><br></div><div><br></div></sp=
an><div><div style=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=
=8BI think I found a solution -- see later in the email.=E2=80=8B</div></di=
v><div><br></div><div><div style=3D"font-family:&quot;courier new&quot;,mon=
ospace">I had a closer look to the corresponding code to see what are the<b=
r></div></div><div><div style=3D"font-family:&quot;courier new&quot;,monosp=
ace">differences between the old check and the new one -- and indeed,=C2=A0=
</div><div style=3D"font-family:&quot;courier new&quot;,monospace">the disc=
repancies might only happen if the tested certificate is</div><div style=3D=
"font-family:&quot;courier new&quot;,monospace">kind-of-weird. For exemple,=
 a client certificate:</div><div style=3D"font-family:&quot;courier new&quo=
t;,monospace"><br></div><div style=3D"font-family:&quot;courier new&quot;,m=
onospace">* has the client bit set</div><div style=3D"font-family:&quot;cou=
rier new&quot;,monospace">* has no key, or has a key but the key usage is n=
either for=C2=A0</div><div style=3D"font-family:&quot;courier new&quot;,mon=
ospace">=C2=A0 signature nor for key agreement</div><div style=3D"font-fami=
ly:&quot;courier new&quot;,monospace">* is not used to auth a client</div><=
br></div><div><div style=3D"font-family:&quot;courier new&quot;,monospace">=
=E2=80=8BIf a user creates a Frankenstein certificate that look like this,=
=C2=A0</div></div><div style=3D"font-family:&quot;courier new&quot;,monospa=
ce">it might be a good idea to warn him that such certificate is very</div>=
<div style=3D"font-family:&quot;courier new&quot;,monospace">likely to be r=
efused in the near future (one can have a similar</div><div style=3D"font-f=
amily:&quot;courier new&quot;,monospace">reasonning about server certificat=
es).=C2=A0</div><span class=3D""><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><span class=3D"m_-39979363574457313=
31gmail-">
<br>
</span>Just a very quick thought here ... I do dislike different behaviours=
<br>
depending on which OpenSSL version being used.=C2=A0 But given that this<br>
feature is already deprecated and even removed in OpenSSL-1.1, I think<br>
that gives us some options.<br>
<br>
I agree with Gert that breaking --ns-cert-type isn&#39;t good at all.<br>
However, consider when people upgrade from OpenSSL v1.0 to v1.1 - that<br>
is most commonly when there is major distro update.=C2=A0 It is not somethi=
ng<br>
which happens &quot;mid-term&quot;, as OpenSSL is quite commonly used by lo=
ts of<br>
base system packages these days.<br>
<br>
Regardless of OpenSSL version, I agree to loudly deprecate<br>
--ns-cert-type, through documentation, --help and log files.<br>
<br>
But I think we need to carry the existing behaviour for --ns-cert-type<br>
when built against OpenSSL v1.0.=C2=A0 And we can solve through some<br>
compatibility wrapper when built against OpenSSL v1.1 - with even louder<br>
warnings in the logs that this may break apart.<br></blockquote><div><br></=
div><div><br></div></span><div><div style=3D"font-family:&quot;courier new&=
quot;,monospace">=E2=80=8BFortunately, I think I found a solution that woul=
d help</div><div style=3D"font-family:&quot;courier new&quot;,monospace">wh=
en using OpenSSL 1.1. Idealy, this should be a call</div><div style=3D"font=
-family:&quot;courier new&quot;,monospace">to X509_check_purpose(.., X509_P=
URPOSE_SSL_*_WEAK, ...)=E2=80=8B</div><div style=3D"font-family:&quot;couri=
er new&quot;,monospace">but I don&#39;t think the OpenSSL developers will a=
ccept such</div><div style=3D"font-family:&quot;courier new&quot;,monospace=
">a change :)</div><div style=3D"font-family:&quot;courier new&quot;,monosp=
ace"><br></div><div style=3D"font-family:&quot;courier new&quot;,monospace"=
>It might be possible to use the=C2=A0X509_get_ext_d2i() call</div><div sty=
le=3D"font-family:&quot;courier new&quot;,monospace">like this:=C2=A0</div>=
<div style=3D"font-family:&quot;courier new&quot;,monospace"><br></div><div=
 style=3D"font-family:&quot;courier new&quot;,monospace">void *ns =3D X509_=
get_ext_d2i(x, NID_netscape_cert_type,=C2=A0</div><div style=3D"font-family=
:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL);</d=
iv><br></div><div><div style=3D"font-family:&quot;courier new&quot;,monospa=
ce">=E2=80=8BIn this case, the =E2=80=8Bobtained ns object contains the dat=
a</div><div style=3D"font-family:&quot;courier new&quot;,monospace">we&#39;=
re interested in:=C2=A0</div><div style=3D"font-family:&quot;courier new&qu=
ot;,monospace"><br></div><div style=3D"font-family:&quot;courier new&quot;,=
monospace">* if it exists, then=C2=A0EXFLAG_NSCERT is set</div><div style=
=3D"font-family:&quot;courier new&quot;,monospace">* if not null, ns is of =
type=C2=A0ASN1_BIT_STRING, and this</div><div style=3D"font-family:&quot;co=
urier new&quot;,monospace">=C2=A0 type is not opaque (yep, sir).</div></div=
><div>=C2=A0</div><div><div style=3D"font-family:&quot;courier new&quot;,mo=
nospace">=E2=80=8BSo the code would look like:</div><div style=3D"font-fami=
ly:&quot;courier new&quot;,monospace"><br></div><div style=3D"font-family:&=
quot;courier new&quot;,monospace">=E2=80=8BASN1_BIT_STRING *ns;</div><div><=
font face=3D"courier new, monospace">result_t result =3D FAILURE;</font><br=
></div><div style=3D"font-family:&quot;courier new&quot;,monospace">ns =3D =
X509_get_ext_d2i(x, NID_netscape_cert_type, NULL, NULL);</div><div style=3D=
"font-family:&quot;courier new&quot;,monospace">if (ns)=C2=A0</div><div sty=
le=3D"font-family:&quot;courier new&quot;,monospace">{</div><div style=3D"f=
ont-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 if (ns-&gt;leng=
th &gt; 0)</div><div style=3D"font-family:&quot;courier new&quot;,monospace=
">=C2=A0 =C2=A0 {</div><div style=3D"font-family:&quot;courier new&quot;,mo=
nospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags =3D ns-&gt;data[0];</div><di=
v style=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (flags &amp; NS_SSL_CLIENT)</div><div style=3D"font-family:&q=
uot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 {</div><div st=
yle=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 result =3D SUCCESS;</div><div style=3D"font-family:&qu=
ot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div sty=
le=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 }</div><=
div style=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 A=
SN1_BIT_STRING_free(ns);</div><div style=3D"font-family:&quot;courier new&q=
uot;,monospace">}</div><br></div><div><br></div><div><div style=3D"font-fam=
ily:&quot;courier new&quot;,monospace">=E2=80=8BFor the record, it&#39;s th=
e code =E2=80=8Bthat is used within function</div><div><font face=3D"courie=
r new, monospace">x509v3_cache_extensions() which builds the X509 flags we<=
/font><br></div><div><font face=3D"courier new, monospace">are using so I&#=
39;m failry confident it&#39;s the right thing to</font></div><div><font fa=
ce=3D"courier new, monospace">do (but it&#39;s a bit convoluted and I don&#=
39;t like it much).=C2=A0</font></div><br></div><div><div style=3D"font-fam=
ily:&quot;courier new&quot;,monospace">=E2=80=8BGood news: the same code sh=
ould work with nearly all the</div><div style=3D"font-family:&quot;courier =
new&quot;,monospace">previous versions of OpenSSL.</div><br></div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<div style=3D"font-family:&quot;courier new&quot;,monospace;display:inline"=
>=E2=80=8B&lt;snip&gt;</div><span class=3D""><span class=3D"m_-399793635744=
5731331gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br></font></span></span></blockquote><div><br></d=
iv><div style=3D"font-family:&quot;courier new&quot;,monospace"><br></div><=
div style=3D"font-family:&quot;courier new&quot;,monospace">I&#39;ll post m=
y new patches as soon as I get over every issues</div><div style=3D"font-fa=
mily:&quot;courier new&quot;,monospace">that have been talked on the ML (is=
 that even a valid=C2=A0</div><div style=3D"font-family:&quot;courier new&q=
uot;,monospace">sentence?)</div><span class=3D""><div style=3D"font-family:=
&quot;courier new&quot;,monospace"><br></div><div style=3D"font-family:&quo=
t;courier new&quot;,monospace">=E2=80=8BBest regards,=C2=A0</div><div style=
=3D"font-family:&quot;courier new&quot;,monospace"><br></div><div style=3D"=
font-family:&quot;courier new&quot;,monospace">-- Emmanuel Deloget=E2=80=8B=
</div></span></div></div></div>
</blockquote></div><br></div></div>

--94eb2c123caccb29e4054bc6757a--

