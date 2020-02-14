MIME-Version: 1.0
References: <20191117181243.28919-3-arne@...1227...>
 <20200213135126.9131-1-arne@...1227...>
In-Reply-To: <20200213135126.9131-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 14 Feb 2020 15:08:10 +0200
Message-ID: <CAGyAFMUUqvVoioxidB0utxQUQ+YsbgNUO+Zhj9SHkvNNH1q+qQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000713bec059e88e6cd"
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] Move NCP related function into a
 seperate file and add unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000713bec059e88e6cd
Content-Type: text/plain; charset="UTF-8"

Hi,

<skip>

I was planning to send a separate patch, but since you moved
this code, maybe you could fix it here.

> +bool
> +tls_item_in_cipher_list(const char *item, const char *list)
> +{
> +    char *tmp_ciphers = string_alloc(list, NULL);
> +    char *tmp_ciphers_orig = tmp_ciphers;

This is redundant. strtok() manipulates string, but doesn't modify pointer,
unlike strsep. So it should be safe to to call

 > free(tmp_ciphers)

instead of

> +    free(tmp_ciphers_orig);

Same case as here:
https://sourceforge.net/p/openvpn/mailman/message/35421870/

Also could you apply following diff, which makes sure that
ssl_ncp.[ch] are displayed under correct Source/Headers folder in MSVC?

diff --git a/src/openvpn/openvpn.vcxproj.filters
b/src/openvpn/openvpn.vcxproj.filters
index 41e62d14..80eb52b3 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -243,6 +243,9 @@
     <ClCompile Include="ring_buffer.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="ssl_ncp.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -506,10 +509,13 @@
     <ClInclude Include="ring_buffer.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="ssl_ncp.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
       <Filter>Resource Files</Filter>
     </ResourceCompile>
   </ItemGroup>
-</Project>
+</Project>
\ No newline at end of file

Other than that, looks good.

--000000000000713bec059e88e6cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><br><div>&lt;skip&gt;</div><div><br></div><div=
>I was planning to send a separate patch, but since you=C2=A0moved<br></div=
><div><div>this code, maybe you could fix it here.</div></div><div><br>&gt;=
 +bool<br>&gt; +tls_item_in_cipher_list(const char *item, const char *list)=
<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0char *tmp_ciphers =3D string_alloc(list,=
 NULL);<br>&gt; + =C2=A0 =C2=A0char *tmp_ciphers_orig =3D tmp_ciphers;</div=
><div><br></div><div>This is redundant. strtok() manipulates string, but do=
esn&#39;t modify pointer,</div><div>unlike strsep. So it should be safe to =
to call</div><div><br></div><div>=C2=A0&gt; free(tmp_ciphers)</div><div><br=
></div><div>instead of=C2=A0</div><div><br>&gt; + =C2=A0 =C2=A0free(tmp_cip=
hers_orig);</div><div><br></div><div>Same case as here:=C2=A0<a href=3D"htt=
ps://sourceforge.net/p/openvpn/mailman/message/35421870/">https://sourcefor=
ge.net/p/openvpn/mailman/message/35421870/</a></div><div><br></div><div>Als=
o could you apply following diff, which makes sure that</div><div>ssl_ncp.[=
ch] are displayed under correct Source/Headers folder in MSVC?</div><div><b=
r></div><div>diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn=
/openvpn.vcxproj.filters<br>index 41e62d14..80eb52b3 100644<br>--- a/src/op=
envpn/openvpn.vcxproj.filters<br>+++ b/src/openvpn/openvpn.vcxproj.filters<=
br>@@ -243,6 +243,9 @@<br>=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot=
;ring_buffer.c&quot;&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source=
 Files&lt;/Filter&gt;<br>=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>+ =C2=A0=
 =C2=A0&lt;ClCompile Include=3D&quot;ssl_ncp.c&quot;&gt;<br>+ =C2=A0 =C2=A0=
 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>+ =C2=A0 =C2=A0&lt;/ClC=
ompile&gt;<br>=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>=C2=A0 =C2=A0&lt;ItemGroup=
&gt;<br>=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;base64.h&quot;&gt=
;<br>@@ -506,10 +509,13 @@<br>=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&=
quot;ring_buffer.h&quot;&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;He=
ader Files&lt;/Filter&gt;<br>=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>+ =
=C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;ssl_ncp.h&quot;&gt;<br>+ =C2=A0 =
=C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>+ =C2=A0 =C2=A0&l=
t;/ClInclude&gt;<br>=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>=C2=A0 =C2=A0&lt;Ite=
mGroup&gt;<br>=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile Include=3D&quot;openv=
pn_win32_resources.rc&quot;&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt=
;Resource Files&lt;/Filter&gt;<br>=C2=A0 =C2=A0 =C2=A0&lt;/ResourceCompile&=
gt;<br>=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>-&lt;/Project&gt;<br>+&lt;/Projec=
t&gt;<br>\ No newline at end of file<br><br></div><div>Other than that, loo=
ks good.</div><div><br></div></div></div>

--000000000000713bec059e88e6cd--

