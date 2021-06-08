MIME-Version: 1.0
References: <20210525092510.27517-1-heiko.wundram@...2614...>
 <CAKuzo_gESgnmaN8QUdnThR-qPcSxdW1Ursvw+vioZFYHTd04Dg@...278...>
 <7ad638911b9c4581946c82fe768811c9@...2614...>
In-Reply-To: <7ad638911b9c4581946c82fe768811c9@...2614...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 8 Jun 2021 11:54:44 -0400
Message-ID: <CAKuzo_hXhb6cR3RLROonZcx8eUPAyehOX19gA+OJFjTXbVAsqA@...278...>
Content-Type: multipart/alternative; boundary="0000000000008eed7605c4432f05"
Subject: Re: [Openvpn-devel] [PATCH] Implement Windows CA template match for
 Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Gehrkens.IT GmbH | Heiko Wundram" <heiko.wundram@...2614...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000008eed7605c4432f05
Content-Type: text/plain; charset="UTF-8"

Hi,

>
> > > +static const CRYPT_OID_INFO *
> > > +find_oid(DWORD keytype, const void *key, DWORD groupid, bool
> > > +fallback) {
> > > +    const CRYPT_OID_INFO *info = NULL;
> > > +
> > > +    /* force resolve from local as first step */
> > > +    if (groupid != CRYPT_HASH_ALG_OID_GROUP_ID &&
> > > +        groupid != CRYPT_ENCRYPT_ALG_OID_GROUP_ID &&
> > > +        groupid != CRYPT_PUBKEY_ALG_OID_GROUP_ID &&
> > > +        groupid != CRYPT_SIGN_ALG_OID_GROUP_ID &&
> > > +        groupid != CRYPT_RDN_ATTR_OID_GROUP_ID &&
> > > +        groupid != CRYPT_EXT_OR_ATTR_OID_GROUP_ID &&
> > > +        groupid != CRYPT_KDF_OID_GROUP_ID)
> > > +    {
> >
> > Why not do the local lookup for all grupids? Anyway you are falling
back to
> > domain-wide look up if this fails.
>

> > Simply because Microsoft does it this way in their generic wrapping of
> CryptFindOIDInfo for certificate selection helpers:
> https://github.com/dotnet/runtime/blob/01b7e73cd378145264a7cb7a09365b41ed42b240/src/libraries/Common/src/Interop/Windows/Crypt32/Interop.FindOidInfo.cs#L51
> ff - the groups excluded here will always be looked up locally, independent
> of the CRYPT_OID_DISABLE_SEARCH_FLAG, so that we can save one call for them.


>
> > > +        info = CryptFindOIDInfo(keytype, (void*)key, groupid |
> > CRYPT_OID_DISABLE_SEARCH_DS_FLAG);

You are misreading the usage in dotnet sources. Their reasoning is that for
those listed algorithms AD will not be consulted and there is no need to
explicitly add the DISABLE_SEARCH_FLAG. But adding it doesn't hurt and
simplifies the code.

So change the above to

info = CryptFindOIDInfo(keytype, (void*)key,
groupid|CRYPT_OID_DISABLE_SEARCH_DS_FLAG);

with no if clause. That way we first search without querying the AD
irrespective of the algorithm.

> > > +    }
> > > +
> > > +    /* try proper resolve if not found yet, also including AD */
> > > +    if (!info)
> > > +    {
> > > +        info = CryptFindOIDInfo(keytype, (void*)key, groupid);
> >
> > How long would this take to time out -- we try to avoid calling
functions that
> > need network access to the DC as that's often not available before the
tunnel
> > comes up.
>
> Good question which I hadn't taken into account so far; from what I've
seen on machine clients I've deployed that select their certificate using
this logic, the timeout is almost instantaneous, i.e. CryptFindOIDInfo does
not find an object for the TMPL: parameter if it can't reach the domain. Of
course, your note generally limits the functionality of actually using
CryptFindOIDInfo to resolve a printable template name from a specific
domain to an OID (which is then found in the actual certificate), but I
wouldn't take this out if it doesn't introduce a long delay (possibly,
there are two tunnels in some cases, where an independent tunnel sets up
reachability of the domain).

Actually there are reports out there that CryptFindOIDInfo can take a long
while to timeout if AD is unreachable. To make things worse we are here
querying the AD two times one with groupid and second time for all groups.
But we can't do much about it except to add a caveat that anyone using
template match should be aware of it.

Please also update the man page (description of --cryptoapicert).

Selva

--0000000000008eed7605c4432f05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br>&gt;<br>&gt; &gt; &gt; +static const CRYPT_OID=
_INFO *<br>&gt; &gt; &gt; +find_oid(DWORD keytype, const void *key, DWORD g=
roupid, bool<br>&gt; &gt; &gt; +fallback) {<br>&gt; &gt; &gt; + =C2=A0 =C2=
=A0const CRYPT_OID_INFO *info =3D NULL;<br>&gt; &gt; &gt; +<br>&gt; &gt; &g=
t; + =C2=A0 =C2=A0/* force resolve from local as first step */<br>&gt; &gt;=
 &gt; + =C2=A0 =C2=A0if (groupid !=3D CRYPT_HASH_ALG_OID_GROUP_ID &amp;&amp=
;<br>&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0groupid !=3D CRYPT_ENCRYPT=
_ALG_OID_GROUP_ID &amp;&amp;<br>&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0groupid !=3D CRYPT_PUBKEY_ALG_OID_GROUP_ID &amp;&amp;<br>&gt; &gt; &gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0groupid !=3D CRYPT_SIGN_ALG_OID_GROUP_ID &amp;=
&amp;<br>&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0groupid !=3D CRYPT_RDN=
_ATTR_OID_GROUP_ID &amp;&amp;<br>&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0groupid !=3D CRYPT_EXT_OR_ATTR_OID_GROUP_ID &amp;&amp;<br>&gt; &gt; &gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0groupid !=3D CRYPT_KDF_OID_GROUP_ID)<br>&gt; =
&gt; &gt; + =C2=A0 =C2=A0{<br>&gt; &gt;<br>&gt; &gt; Why not do the local l=
ookup for all grupids? Anyway you are falling back to<br>&gt; &gt; domain-w=
ide look up if this fails.<br>&gt;<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">&gt; Simply because Microsoft does it this way in their generi=
c wrapping of CryptFindOIDInfo for certificate selection helpers: <a href=
=3D"https://github.com/dotnet/runtime/blob/01b7e73cd378145264a7cb7a09365b41=
ed42b240/src/libraries/Common/src/Interop/Windows/Crypt32/Interop.FindOidIn=
fo.cs#L51">https://github.com/dotnet/runtime/blob/01b7e73cd378145264a7cb7a0=
9365b41ed42b240/src/libraries/Common/src/Interop/Windows/Crypt32/Interop.Fi=
ndOidInfo.cs#L51</a> ff - the groups excluded here will always be looked up=
 locally, independent of the CRYPT_OID_DISABLE_SEARCH_FLAG, so that we can =
save one call for them.</blockquote><br>&gt;<br>&gt; &gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0info =3D CryptFindOIDInfo(keytype, (void*)key, groupid |<b=
r>&gt; &gt; CRYPT_OID_DISABLE_SEARCH_DS_FLAG);<br><br>You are misreading th=
e usage in dotnet sources. Their reasoning is that for those listed algorit=
hms AD will not be consulted and there is no need to explicitly add the DIS=
ABLE_SEARCH_FLAG. But adding it doesn&#39;t hurt and simplifies the code.<b=
r><br>So change=C2=A0the above to<br><br><div>info =3D CryptFindOIDInfo(key=
type, (void*)key, groupid|CRYPT_OID_DISABLE_SEARCH_DS_FLAG);<br><br>with no=
 if clause. That way we first search without querying the AD irrespective o=
f the algorithm.<div><br>&gt; &gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; &gt; =
+<br>&gt; &gt; &gt; + =C2=A0 =C2=A0/* try proper resolve if not found yet, =
also including AD */<br>&gt; &gt; &gt; + =C2=A0 =C2=A0if (!info)<br>&gt; &g=
t; &gt; + =C2=A0 =C2=A0{<br>&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0inf=
o =3D CryptFindOIDInfo(keytype, (void*)key, groupid);<br>&gt; &gt;<br>&gt; =
&gt; How long would this take to time out -- we try to avoid calling functi=
ons that<br>&gt; &gt; need network access to the DC as that&#39;s often not=
 available before the tunnel<br>&gt; &gt; comes up.<br>&gt;<br>&gt; Good qu=
estion which I hadn&#39;t taken into account so far; from what I&#39;ve see=
n on machine clients I&#39;ve deployed that select their certificate using =
this logic, the timeout is almost instantaneous, i.e. CryptFindOIDInfo does=
 not find an object for the TMPL: parameter if it can&#39;t reach the domai=
n. Of course, your note generally limits the functionality of actually usin=
g CryptFindOIDInfo to resolve a printable template name from a specific dom=
ain to an OID (which is then found in the actual certificate), but I wouldn=
&#39;t take this out if it doesn&#39;t introduce a long delay (possibly, th=
ere are two tunnels in some cases, where an independent tunnel sets up reac=
hability of the domain).</div><div><br></div><div>Actually there are report=
s out there that CryptFindOIDInfo can take a long while to timeout if AD is=
 unreachable. To make things worse we are here querying the AD two times on=
e with groupid and second time for all groups. But we can&#39;t do much abo=
ut it except to add a caveat=C2=A0that anyone using template match should b=
e aware of it.=C2=A0</div><div><br></div></div><div>Please also update the =
man page (description of --cryptoapicert).</div><div><br></div><div>Selva</=
div></div></div>

--0000000000008eed7605c4432f05--

