MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
In-Reply-To: <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Nov 2018 13:41:58 -0500
Message-ID: <CAKuzo_jG+hLcLPAKyAKK2uAKiNvPkWK_jQe6w0ye9iCHym54sg@...278...>
Content-Type: multipart/alternative; boundary="000000000000037720057aa44b76"
Subject: [Openvpn-devel] Fwd: [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000037720057aa44b76
Content-Type: text/plain; charset="UTF-8"

Somehow this didn't get copied to the list

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Wed, Nov 14, 2018 at 11:06 AM
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
when using management-external-key
To: Arne Schwabe <arne@...1227...>


Hi,

On Wed, Nov 14, 2018 at 10:56 AM Arne Schwabe <arne@...1227...> wrote:
>
> Am 14.11.18 um 16:18 schrieb Selva Nair:
> > Hi,
> >
> > snipping a lot of useful stuff as we tend agree on those..
> > ..
> >
> >> But in summary.
> >>
> >> My patch basically amounts to: Support old style
management-external-key
> >> with <= OpenSSL 1.1.0 and use and require a new API if we have OpenSSL
> >> 1.1.1 and to really move and have external key have a sane API, we
would
> >> drop rsa-sig and support for older clients, even with <= OpenSSL 1.1.0
> >> as you oppose my proposl for signalling that a new API should be used.
> >> (version in managemnet protocol is too late and not feasible in my
opinion)
> >> Supporting a half working RSA_SIG option that breaks left and right is
> >> not desirable in my opinion.
> >
> > My point is that even with "--management-external-key foo bar", we
> > will be sending
> > a non workable signature request to old clients so changing that
> > option is not really
> > useful. In other words the early erroring out works only half the time
> > and all that code
> > complication is not worth it.
>
> Okay, I think you misunderstood my code. What it does is basically if we
> detect having TLS 1.3 support (max_tls_version >= TLS 1.3) and not a
> nopadding argument we error out, saying that this combination cannot work.
>
> Yes that means that if you upgrade to OpenSSL 1.1.1 you need to support
> the new API but I think that is acceptable.
>
> Unless I overlooked something, I don't see any situation in which we ask
> for an unsupported signature.

Consider this:
(i) config has --management-external-key nopadding but client announces
version
2. We will not error out but send the signature request as
PK_SIGN <base64data>
without the ALG as client version is not 3 and fail

(ii) tls version max is set 1.2 and openssl 1.1.1 is in use both on
server and client.
PSS signing will get negotiated but we will not error out early as TLS
1.3 is not in  use.

That's why I say that this extension of management-external-key is not
worth it.

Am I missing something?

Selva

--000000000000037720057aa44b76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Somehow this didn&#39;t get copied to the list<br><div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr">---------- Forwarded message -=
--------<br>From: <b class=3D"gmail_sendername" dir=3D"auto">Selva Nair</b>=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...220...=
..277...</a>&gt;</span><br>Date: Wed, Nov 14, 2018 at 11:06 AM<br>Subject: =
Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3 when usi=
ng management-external-key<br>To: Arne Schwabe &lt;<a href=3D"mailto:arne@...220...=
..1227...">arne@...1227...</a>&gt;<br></div><br><br>Hi,<br>
<br>
On Wed, Nov 14, 2018 at 10:56 AM Arne Schwabe &lt;<a href=3D"mailto:arne@...1186...=
.1227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br>
&gt;<br>
&gt; Am 14.11.18 um 16:18 schrieb Selva Nair:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; snipping a lot of useful stuff as we tend agree on those..<br>
&gt; &gt; ..<br>
&gt; &gt;<br>
&gt; &gt;&gt; But in summary.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; My patch basically amounts to: Support old style management-e=
xternal-key<br>
&gt; &gt;&gt; with &lt;=3D OpenSSL 1.1.0 and use and require a new API if w=
e have OpenSSL<br>
&gt; &gt;&gt; 1.1.1 and to really move and have external key have a sane AP=
I, we would<br>
&gt; &gt;&gt; drop rsa-sig and support for older clients, even with &lt;=3D=
 OpenSSL 1.1.0<br>
&gt; &gt;&gt; as you oppose my proposl for signalling that a new API should=
 be used.<br>
&gt; &gt;&gt; (version in managemnet protocol is too late and not feasible =
in my opinion)<br>
&gt; &gt;&gt; Supporting a half working RSA_SIG option that breaks left and=
 right is<br>
&gt; &gt;&gt; not desirable in my opinion.<br>
&gt; &gt;<br>
&gt; &gt; My point is that even with &quot;--management-external-key foo ba=
r&quot;, we<br>
&gt; &gt; will be sending<br>
&gt; &gt; a non workable signature request to old clients so changing that<=
br>
&gt; &gt; option is not really<br>
&gt; &gt; useful. In other words the early erroring out works only half the=
 time<br>
&gt; &gt; and all that code<br>
&gt; &gt; complication is not worth it.<br>
&gt;<br>
&gt; Okay, I think you misunderstood my code. What it does is basically if =
we<br>
&gt; detect having TLS 1.3 support (max_tls_version &gt;=3D TLS 1.3) and no=
t a<br>
&gt; nopadding argument we error out, saying that this combination cannot w=
ork.<br>
&gt;<br>
&gt; Yes that means that if you upgrade to OpenSSL 1.1.1 you need to suppor=
t<br>
&gt; the new API but I think that is acceptable.<br>
&gt;<br>
&gt; Unless I overlooked something, I don&#39;t see any situation in which =
we ask<br>
&gt; for an unsupported signature.<br>
<br>
Consider this:<br>
(i) config has --management-external-key nopadding but client announces ver=
sion<br>
2. We will not error out but send the signature request as<br>
PK_SIGN &lt;base64data&gt;<br>
without the ALG as client version is not 3 and fail<br>
<br>
(ii) tls version max is set 1.2 and openssl 1.1.1 is in use both on<br>
server and client.<br>
PSS signing will get negotiated but we will not error out early as TLS<br>
1.3 is not in=C2=A0 use.<br>
<br>
That&#39;s why I say that this extension of management-external-key is not =
worth it.<br>
<br>
Am I missing something?<br>
<br>
Selva<br>
</div></div></div>

--000000000000037720057aa44b76--

