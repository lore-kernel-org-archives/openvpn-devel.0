MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <72797fe3-23f7-8b10-19df-29cc4f31ef98@...2080...>
References: <cover.1487368114.git.logout@...260...>
	<e5e93420586b24b7df5b2f5ac2df02ccec5ffdb1.1487368114.git.logout@...260...>
	<66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
	<20170302212621.GE93896@...1296...>
	<735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>
	<72797fe3-23f7-8b10-19df-29cc4f31ef98@...2080...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 27 Mar 2017 17:49:48 +0200
Message-ID: <CAKh=nwFF-Lc-Q52QCoh0WgP3g0gr0P7_i9CqwcpC2mDzGCi8sw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c190c2a0fbcaa054bb84b54
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

--94eb2c190c2a0fbcaa054bb84b54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I got some time to try to fix all that stuff.

First,

On Sat, Mar 4, 2017 at 11:38 PM, David Sommerseth <
openvpn@...2080...> wrote:

> On 04/03/17 16:13, Steffan Karger wrote:
> > As a last resort, we could consider keeping the old code inside #if
> > OSSL_VER < 1.1.0 in release/2.4, but that might just create more
> > confusion...
>


=E2=80=8BI think I found a solution -- see later in the email.=E2=80=8B

I had a closer look to the corresponding code to see what are the
differences between the old check and the new one -- and indeed,
the discrepancies might only happen if the tested certificate is
kind-of-weird. For exemple, a client certificate:

* has the client bit set
* has no key, or has a key but the key usage is neither for
  signature nor for key agreement
* is not used to auth a client

=E2=80=8BIf a user creates a Frankenstein certificate that look like this,
it might be a good idea to warn him that such certificate is very
likely to be refused in the near future (one can have a similar
reasonning about server certificates).



>
> Just a very quick thought here ... I do dislike different behaviours
> depending on which OpenSSL version being used.  But given that this
> feature is already deprecated and even removed in OpenSSL-1.1, I think
> that gives us some options.
>
> I agree with Gert that breaking --ns-cert-type isn't good at all.
> However, consider when people upgrade from OpenSSL v1.0 to v1.1 - that
> is most commonly when there is major distro update.  It is not something
> which happens "mid-term", as OpenSSL is quite commonly used by lots of
> base system packages these days.
>
> Regardless of OpenSSL version, I agree to loudly deprecate
> --ns-cert-type, through documentation, --help and log files.
>
> But I think we need to carry the existing behaviour for --ns-cert-type
> when built against OpenSSL v1.0.  And we can solve through some
> compatibility wrapper when built against OpenSSL v1.1 - with even louder
> warnings in the logs that this may break apart.
>


=E2=80=8BFortunately, I think I found a solution that would help
when using OpenSSL 1.1. Idealy, this should be a call
to X509_check_purpose(.., X509_PURPOSE_SSL_*_WEAK, ...)=E2=80=8B
but I don't think the OpenSSL developers will accept such
a change :)

It might be possible to use the X509_get_ext_d2i() call
like this:

void *ns =3D X509_get_ext_d2i(x, NID_netscape_cert_type,
                            NULL, NULL);

=E2=80=8BIn this case, the =E2=80=8Bobtained ns object contains the data
we're interested in:

* if it exists, then EXFLAG_NSCERT is set
* if not null, ns is of type ASN1_BIT_STRING, and this
  type is not opaque (yep, sir).

=E2=80=8BSo the code would look like:

=E2=80=8BASN1_BIT_STRING *ns;
result_t result =3D FAILURE;
ns =3D X509_get_ext_d2i(x, NID_netscape_cert_type, NULL, NULL);
if (ns)
{
    if (ns->length > 0)
    {
        int flags =3D ns->data[0];
        if (flags & NS_SSL_CLIENT)
        {
            result =3D SUCCESS;
        }
    }
    ASN1_BIT_STRING_free(ns);
}


=E2=80=8BFor the record, it's the code =E2=80=8Bthat is used within function
x509v3_cache_extensions() which builds the X509 flags we
are using so I'm failry confident it's the right thing to
do (but it's a bit convoluted and I don't like it much).

=E2=80=8BGood news: the same code should work with nearly all the
previous versions of OpenSSL.



> =E2=80=8B<snip>
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>


I'll post my new patches as soon as I get over every issues
that have been talked on the ML (is that even a valid
sentence?)

=E2=80=8BBest regards,

-- Emmanuel Deloget=E2=80=8B

--94eb2c190c2a0fbcaa054bb84b54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:&quot;co=
urier new&quot;,monospace">Hi everyone,=C2=A0</div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;courier new&quot;,monospace"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monos=
pace">I got some time to try to fix all that stuff.=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">=
<br></div><div class=3D"gmail_default" style=3D"font-family:&quot;courier n=
ew&quot;,monospace">First,=C2=A0</div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Sat, Mar 4, 2017 at 11:38 PM, David Sommerseth <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">o=
penvpn@...2080...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><span class=3D"gmail-">On 04/03/17 16:13, Steffan Karger =
wrote:<br>
&gt; As a last resort, we could consider keeping the old code inside #if<br>
&gt; OSSL_VER &lt; 1.1.0 in release/2.4, but that might just create more<br>
&gt; confusion...<br></span></blockquote><div><br></div><div><br></div><div=
><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,=
monospace">=E2=80=8BI think I found a solution -- see later in the email.=
=E2=80=8B</div></div><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-family:&quot;courier new&quot;,monospace">I had a closer look to t=
he corresponding code to see what are the<br></div></div><div><div class=3D=
"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">dif=
ferences between the old check and the new one -- and indeed,=C2=A0</div><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,mon=
ospace">the discrepancies might only happen if the tested certificate is</d=
iv><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot=
;,monospace">kind-of-weird. For exemple, a client certificate:</div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospac=
e"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;courie=
r new&quot;,monospace">* has the client bit set</div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;courier new&quot;,monospace">* has no key=
, or has a key but the key usage is neither for=C2=A0</div><div class=3D"gm=
ail_default" style=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0=
 signature nor for key agreement</div><div class=3D"gmail_default" style=3D=
"font-family:&quot;courier new&quot;,monospace">* is not used to auth a cli=
ent</div><br></div><div><div class=3D"gmail_default" style=3D"font-family:&=
quot;courier new&quot;,monospace">=E2=80=8BIf a user creates a Frankenstein=
 certificate that look like this,=C2=A0</div></div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;courier new&quot;,monospace">it might be a =
good idea to warn him that such certificate is very</div><div class=3D"gmai=
l_default" style=3D"font-family:&quot;courier new&quot;,monospace">likely t=
o be refused in the near future (one can have a similar</div><div class=3D"=
gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">reas=
onning about server certificates).=C2=A0</div><div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">
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
div><div><br></div><div><div class=3D"gmail_default" style=3D"font-family:&=
quot;courier new&quot;,monospace">=E2=80=8BFortunately, I think I found a s=
olution that would help</div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;courier new&quot;,monospace">when using OpenSSL 1.1. Idealy, this=
 should be a call</div><div class=3D"gmail_default" style=3D"font-family:&q=
uot;courier new&quot;,monospace">to X509_check_purpose(.., X509_PURPOSE_SSL=
_*_WEAK, ...)=E2=80=8B</div><div class=3D"gmail_default" style=3D"font-fami=
ly:&quot;courier new&quot;,monospace">but I don&#39;t think the OpenSSL dev=
elopers will accept such</div><div class=3D"gmail_default" style=3D"font-fa=
mily:&quot;courier new&quot;,monospace">a change :)</div><div class=3D"gmai=
l_default" style=3D"font-family:&quot;courier new&quot;,monospace"><br></di=
v><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;=
,monospace">It might be possible to use the=C2=A0X509_get_ext_d2i() call</d=
iv><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot=
;,monospace">like this:=C2=A0</div><div class=3D"gmail_default" style=3D"fo=
nt-family:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail_=
default" style=3D"font-family:&quot;courier new&quot;,monospace">void *ns =
=3D X509_get_ext_d2i(x, NID_netscape_cert_type,=C2=A0</div><div class=3D"gm=
ail_default" style=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL, NULL);</div><br></div><div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BIn th=
is case, the =E2=80=8Bobtained ns object contains the data</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">=
we&#39;re interested in:=C2=A0</div><div class=3D"gmail_default" style=3D"f=
ont-family:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail=
_default" style=3D"font-family:&quot;courier new&quot;,monospace">* if it e=
xists, then=C2=A0EXFLAG_NSCERT is set</div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;courier new&quot;,monospace">* if not null, ns is o=
f type=C2=A0ASN1_BIT_STRING, and this</div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 type is not opa=
que (yep, sir).</div></div><div>=C2=A0</div><div><div class=3D"gmail_defaul=
t" style=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BSo the =
code would look like:</div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BASN1_BIT_=
STRING *ns;</div><div class=3D"gmail_default"><font face=3D"courier new, mo=
nospace">result_t result =3D FAILURE;</font><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:&quot;courier new&quot;,monospace">ns =3D X509=
_get_ext_d2i(x, NID_netscape_cert_type, NULL, NULL);</div><div class=3D"gma=
il_default" style=3D"font-family:&quot;courier new&quot;,monospace">if (ns)=
=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:&quot;courier=
 new&quot;,monospace">{</div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 if (ns-&gt;length &gt;=
 0)</div><div class=3D"gmail_default" style=3D"font-family:&quot;courier ne=
w&quot;,monospace">=C2=A0 =C2=A0 {</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int flags =3D ns-&gt;data[0];</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (flags &amp; NS_SSL_CLIENT)</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 {</div><div class=3D"gmail_default" style=3D"font-family:&quot;courier =
new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D S=
UCCESS;</div><div class=3D"gmail_default" style=3D"font-family:&quot;courie=
r new&quot;,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div class=3D"gma=
il_default" style=3D"font-family:&quot;courier new&quot;,monospace">=C2=A0 =
=C2=A0 }</div><div class=3D"gmail_default" style=3D"font-family:&quot;couri=
er new&quot;,monospace">=C2=A0 =C2=A0 ASN1_BIT_STRING_free(ns);</div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospa=
ce">}</div><br></div><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BFor the record,=
 it&#39;s the code =E2=80=8Bthat is used within function</div><div class=3D=
"gmail_default"><font face=3D"courier new, monospace">x509v3_cache_extensio=
ns() which builds the X509 flags we</font><br></div><div class=3D"gmail_def=
ault"><font face=3D"courier new, monospace">are using so I&#39;m failry con=
fident it&#39;s the right thing to</font></div><div class=3D"gmail_default"=
><font face=3D"courier new, monospace">do (but it&#39;s a bit convoluted an=
d I don&#39;t like it much).=C2=A0</font></div><br></div><div><div class=3D=
"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">=E2=
=80=8BGood news: the same code should work with nearly all the</div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospac=
e">previous versions of OpenSSL.</div><br></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
<div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,m=
onospace;display:inline">=E2=80=8B&lt;snip&gt;</div><span class=3D"gmail-HO=
EnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br></font></span></blockquote><div><br></div><div=
 class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monos=
pace"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;cou=
rier new&quot;,monospace">I&#39;ll post my new patches as soon as I get ove=
r every issues</div><div class=3D"gmail_default" style=3D"font-family:&quot=
;courier new&quot;,monospace">that have been talked on the ML (is that even=
 a valid=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:&quot=
;courier new&quot;,monospace">sentence?)</div><div class=3D"gmail_default" =
style=3D"font-family:&quot;courier new&quot;,monospace"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace"=
>=E2=80=8BBest regards,=C2=A0</div><div class=3D"gmail_default" style=3D"fo=
nt-family:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail_=
default" style=3D"font-family:&quot;courier new&quot;,monospace">-- Emmanue=
l Deloget=E2=80=8B</div></div></div></div>

--94eb2c190c2a0fbcaa054bb84b54--

