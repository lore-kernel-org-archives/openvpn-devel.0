MIME-Version: 1.0
In-Reply-To: <CAAS2iOP_P__9EC9G_=FPs_kBeWwGsHCQv_F8emGykH41OZqxsA@...278...>
References: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
 <1ba4b18f-1861-f211-42ef-9ee23cb92563@...2181...>
 <CAAS2iOP_P__9EC9G_=FPs_kBeWwGsHCQv_F8emGykH41OZqxsA@...278...>
From: Yovie Ramadhan <ramadhanyovie99@...277...>
Date: Sat, 30 Jun 2018 15:56:40 -0700
Message-ID: <CAAS2iOOH+KAmtppBH1L=AyX5N2VLgvF98tBRDRSvM9_DcBpJXw@...278...>
Content-Type: multipart/alternative; boundary="000000000000a8d93b056fe3e0c8"
Subject: Re: [Openvpn-devel] [PATCH] Remove deprecated plugin functions from
 code samples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Greg Cox <gcox@...1057...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--000000000000a8d93b056fe3e0c8
Content-Type: text/plain; charset="UTF-8"

Minggu, 01 Juli 2018, Yovie Ramadhan <ramadhanyovie99@...277...> menulis:

>
>
> Minggu, 01 Juli 2018, Antonio Quartulli <a@...2181...> menulis:
>
>> Hi,
>>
>> On 01/07/18 00:58, Greg Cox wrote:
>> > While writing up a plugin, I found that the sample plugin code was using
>> > openvpn_plugin_open_v1.  Since that and openvpn_plugin_func_v1 are
>> listed
>> > as 'deprecated' in openvpn-plugin.h, it made sense to me that you
>> shouldn't
>> > list those functions as sample code for others to clone.
>> >
>> > This edits only sample code and since it's my first patch I thought I'd
>> > limit to that.  src/plugins/auth-pam and src/plugins/down-root have
>> similar
>> > 'issues', though, and may need the same treatment, if I have the right
>> idea.
>> >
>> > Thanks for reading.
>> > -Greg
>> >
>>
>> I'd remove the last paragraph and the greetings from the commit message.
>> But this might be done at commit time.
>>
>> > ---
>> >  sample/sample-plugins/defer/simple.c    | 5 +++--
>> >  sample/sample-plugins/defer/simple.def  | 4 ++--
>> >  sample/sample-plugins/log/log.c         | 6 ++++--
>> >  sample/sample-plugins/simple/simple.c   | 6 ++++--
>> >  sample/sample-plugins/simple/simple.def | 4 ++--
>> >  5 files changed, 15 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/sample/sample-plugins/defer/simple.c
>> > b/sample/sample-plugins/defer/simple.c
>> > index
>> > d18695b59d6966e5cc84a19e176ea9ec18d0b452..d55e47be01aa346cfc
>> 9c70aa24f8722e5a1d67f9
>> > 100644
>> > --- a/sample/sample-plugins/defer/simple.c
>> > +++ b/sample/sample-plugins/defer/simple.c
>> > @@ -131,11 +131,12 @@ atoi_null0(const char *str)
>> >  }
>> >
>> >  OPENVPN_EXPORT openvpn_plugin_handle_t
>> > -openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[],
>> const
>> > char *envp[])
>> > +openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[],
>> const
>> > char *envp[],
>> > +                       struct openvpn_plugin_string_list **return_list)
>> >  {
>> >      struct plugin_context *context;
>> >
>> > -    printf("FUNC: openvpn_plugin_open_v1\n");
>> > +    printf("FUNC: openvpn_plugin_open_v2\n");
>> >
>> >      /*
>> >       * Allocate our context
>> > diff --git a/sample/sample-plugins/defer/simple.def
>> > b/sample/sample-plugins/defer/simple.def
>> > index
>> > a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce818
>> 29253f7a7fae9898be221a
>> > 100755
>> > --- a/sample/sample-plugins/defer/simple.def
>> > +++ b/sample/sample-plugins/defer/simple.def
>> > @@ -1,6 +1,6 @@
>> >  LIBRARY   OpenVPN_PLUGIN_SAMPLE
>> >  DESCRIPTION "Sample OpenVPN plug-in module."
>> >  EXPORTS
>> > -   openvpn_plugin_open_v1   @1
>> > -   openvpn_plugin_func_v1   @2
>> > +   openvpn_plugin_open_v2   @1
>> > +   openvpn_plugin_func_v2   @2
>> >     openvpn_plugin_close_v1  @3
>> > diff --git a/sample/sample-plugins/log/log.c
>> > b/sample/sample-plugins/log/log.c
>> > index
>> > ecf62c0e653c8ec852ab641e75363747b795c1af..efa8e5184db34f36a3
>> 11fb61436cdfd61dd02f78
>> > 100644
>> > --- a/sample/sample-plugins/log/log.c
>> > +++ b/sample/sample-plugins/log/log.c
>> > @@ -70,7 +70,8 @@ get_env(const char *name, const char *envp[])
>> >  }
>> >
>> >  OPENVPN_EXPORT openvpn_plugin_handle_t
>> > -openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[],
>> const
>> > char *envp[])
>> > +openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[],
>> const
>> > char *envp[],
>> > +                       struct openvpn_plugin_string_list **return_list)
>> >  {
>> >      struct plugin_context *context;
>> >
>> > @@ -164,7 +165,8 @@ show(const int type, const char *argv[], const char
>> > *envp[])
>> >  }
>> >
>> >  OPENVPN_EXPORT int
>> > -openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type,
>> > const char *argv[], const char *envp[])
>> > +openvpn_plugin_func_v2(openvpn_plugin_handle_t handle, const int type,
>> > const char *argv[], const char *envp[],
>> > +                       void *per_client_context, struct
>> > openvpn_plugin_string_list **return_list)
>> >  {
>> >      struct plugin_context *context = (struct plugin_context *) handle;
>> >
>> > diff --git a/sample/sample-plugins/simple/simple.c
>> > b/sample/sample-plugins/simple/simple.c
>> > index
>> > 950c547e22c1d44c59812eb90606fbdb52981021..66695950abfcbc6ebb
>> 0a4d4fa621627a6099ba76
>> > 100644
>> > --- a/sample/sample-plugins/simple/simple.c
>> > +++ b/sample/sample-plugins/simple/simple.c
>> > @@ -72,7 +72,8 @@ get_env(const char *name, const char *envp[])
>> >  }
>> >
>> >  OPENVPN_EXPORT openvpn_plugin_handle_t
>> > -openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[],
>> const
>> > char *envp[])
>> > +openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[],
>> const
>> > char *envp[],
>> > +                       struct openvpn_plugin_string_list **return_list)
>> >  {
>> >      struct plugin_context *context;
>> >
>> > @@ -97,7 +98,8 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const
>> > char *argv[], const char *
>> >  }
>> >
>> >  OPENVPN_EXPORT int
>> > -openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type,
>> > const char *argv[], const char *envp[])
>> > +openvpn_plugin_func_v2(openvpn_plugin_handle_t handle, const int type,
>> > const char *argv[], const char *envp[],
>> > +                       void *per_client_context, struct
>> > openvpn_plugin_string_list **return_list)
>> >  {
>> >      struct plugin_context *context = (struct plugin_context *) handle;
>> >
>> > diff --git a/sample/sample-plugins/simple/simple.def
>> > b/sample/sample-plugins/simple/simple.def
>> > index
>> > a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce818
>> 29253f7a7fae9898be221a
>> > 100755
>> > --- a/sample/sample-plugins/simple/simple.def
>> > +++ b/sample/sample-plugins/simple/simple.def
>> > @@ -1,6 +1,6 @@
>> >  LIBRARY   OpenVPN_PLUGIN_SAMPLE
>> >  DESCRIPTION "Sample OpenVPN plug-in module."
>> >  EXPORTS
>> > -   openvpn_plugin_open_v1   @1
>> > -   openvpn_plugin_func_v1   @2
>> > +   openvpn_plugin_open_v2   @1
>> > +   openvpn_plugin_func_v2   @2
>> >     openvpn_plugin_close_v1  @3
>> > --
>> > 2.15.2 (Apple Git-101.1)
>>
>> did you concatenate two patches? or what happened? It seems that the
>> part after this is not recognised as proper patch.
>>
>>
>> Cheers,
>>
>>
>> --
>> Antonio Quartulli
>>
>>

--000000000000a8d93b056fe3e0c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>Minggu, 01 Juli 2018, Yovie Ramadhan &lt;<a href=3D"mailto:ramadhan=
yovie99@...277...">ramadhanyovie99@...277...</a>&gt; menulis:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><br><br>Minggu, 01 Juli 2018, Antonio Quartulli &lt;a@=
...2181...&gt; menulis:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On 01/07/18 00:58, Greg Cox wrote:<br>
&gt; While writing up a plugin, I found that the sample plugin code was usi=
ng<br>
&gt; openvpn_plugin_open_v1.=C2=A0 Since that and openvpn_plugin_func_v1 ar=
e listed<br>
&gt; as &#39;deprecated&#39; in openvpn-plugin.h, it made sense to me that =
you shouldn&#39;t<br>
&gt; list those functions as sample code for others to clone.<br>
&gt; <br>
&gt; This edits only sample code and since it&#39;s my first patch I though=
t I&#39;d<br>
&gt; limit to that.=C2=A0 src/plugins/auth-pam and src/plugins/down-root ha=
ve similar<br>
&gt; &#39;issues&#39;, though, and may need the same treatment, if I have t=
he right idea.<br>
&gt; <br>
&gt; Thanks for reading.<br>
&gt; -Greg<br>
&gt; <br>
<br>
I&#39;d remove the last paragraph and the greetings from the commit message=
.<br>
But this might be done at commit time.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 sample/sample-plugins/defer/si<wbr>mple.c=C2=A0 =C2=A0 | 5 +++--=
<br>
&gt;=C2=A0 sample/sample-plugins/defer/si<wbr>mple.def=C2=A0 | 4 ++--<br>
&gt;=C2=A0 sample/sample-plugins/log/log.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 6 ++++--<br>
&gt;=C2=A0 sample/sample-plugins/simple/s<wbr>imple.c=C2=A0 =C2=A0| 6 ++++-=
-<br>
&gt;=C2=A0 sample/sample-plugins/simple/s<wbr>imple.def | 4 ++--<br>
&gt;=C2=A0 5 files changed, 15 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/sample/sample-plugins/defer/<wbr>simple.c<br>
&gt; b/sample/sample-plugins/defer/<wbr>simple.c<br>
&gt; index<br>
&gt; d18695b59d6966e5cc84a19e176ea9<wbr>ec18d0b452..d55e47be01aa346cfc<wbr>=
9c70aa24f8722e5a1d67f9<br>
&gt; 100644<br>
&gt; --- a/sample/sample-plugins/defer/<wbr>simple.c<br>
&gt; +++ b/sample/sample-plugins/defer/<wbr>simple.c<br>
&gt; @@ -131,11 +131,12 @@ atoi_null0(const char *str)<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 OPENVPN_EXPORT openvpn_plugin_handle_t<br>
&gt; -openvpn_plugin_open_v1(unsign<wbr>ed int *type_mask, const char *argv=
[], const<br>
&gt; char *envp[])<br>
&gt; +openvpn_plugin_open_v2(unsign<wbr>ed int *type_mask, const char *argv=
[], const<br>
&gt; char *envp[],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct openvpn_plugin_string_list **return_list)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct plugin_context *context;<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 printf(&quot;FUNC: openvpn_plugin_open_v1\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 printf(&quot;FUNC: openvpn_plugin_open_v2\n&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Allocate our context<br>
&gt; diff --git a/sample/sample-plugins/defer/<wbr>simple.def<br>
&gt; b/sample/sample-plugins/defer/<wbr>simple.def<br>
&gt; index<br>
&gt; a87507d1fdc0f0bfd0434de577a818<wbr>ef0cc62afb..556f362308bc6ce818<wbr>=
29253f7a7fae9898be221a<br>
&gt; 100755<br>
&gt; --- a/sample/sample-plugins/defer/<wbr>simple.def<br>
&gt; +++ b/sample/sample-plugins/defer/<wbr>simple.def<br>
&gt; @@ -1,6 +1,6 @@<br>
&gt;=C2=A0 LIBRARY=C2=A0 =C2=A0OpenVPN_PLUGIN_SAMPLE<br>
&gt;=C2=A0 DESCRIPTION &quot;Sample OpenVPN plug-in module.&quot;<br>
&gt;=C2=A0 EXPORTS<br>
&gt; -=C2=A0 =C2=A0openvpn_plugin_open_v1=C2=A0 =C2=A0@...912...<br>
&gt; -=C2=A0 =C2=A0openvpn_plugin_func_v1=C2=A0 =C2=A0@...1611...<br>
&gt; +=C2=A0 =C2=A0openvpn_plugin_open_v2=C2=A0 =C2=A0@...912...<br>
&gt; +=C2=A0 =C2=A0openvpn_plugin_func_v2=C2=A0 =C2=A0@...1611...<br>
&gt;=C2=A0 =C2=A0 =C2=A0openvpn_plugin_close_v1=C2=A0 @3<br>
&gt; diff --git a/sample/sample-plugins/log/lo<wbr>g.c<br>
&gt; b/sample/sample-plugins/log/lo<wbr>g.c<br>
&gt; index<br>
&gt; ecf62c0e653c8ec852ab641e753637<wbr>47b795c1af..efa8e5184db34f36a3<wbr>=
11fb61436cdfd61dd02f78<br>
&gt; 100644<br>
&gt; --- a/sample/sample-plugins/log/lo<wbr>g.c<br>
&gt; +++ b/sample/sample-plugins/log/lo<wbr>g.c<br>
&gt; @@ -70,7 +70,8 @@ get_env(const char *name, const char *envp[])<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 OPENVPN_EXPORT openvpn_plugin_handle_t<br>
&gt; -openvpn_plugin_open_v1(unsign<wbr>ed int *type_mask, const char *argv=
[], const<br>
&gt; char *envp[])<br>
&gt; +openvpn_plugin_open_v2(unsign<wbr>ed int *type_mask, const char *argv=
[], const<br>
&gt; char *envp[],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct openvpn_plugin_string_list **return_list)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct plugin_context *context;<br>
&gt; <br>
&gt; @@ -164,7 +165,8 @@ show(const int type, const char *argv[], const cha=
r<br>
&gt; *envp[])<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 OPENVPN_EXPORT int<br>
&gt; -openvpn_plugin_func_v1(openvp<wbr>n_plugin_handle_t handle, const int=
 type,<br>
&gt; const char *argv[], const char *envp[])<br>
&gt; +openvpn_plugin_func_v2(openvp<wbr>n_plugin_handle_t handle, const int=
 type,<br>
&gt; const char *argv[], const char *envp[],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0void *per_client_context, struct<br>
&gt; openvpn_plugin_string_list **return_list)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct plugin_context *context =3D (struct plugin_=
context *) handle;<br>
&gt; <br>
&gt; diff --git a/sample/sample-plugins/simple<wbr>/simple.c<br>
&gt; b/sample/sample-plugins/simple<wbr>/simple.c<br>
&gt; index<br>
&gt; 950c547e22c1d44c59812eb90606fb<wbr>db52981021..66695950abfcbc6ebb<wbr>=
0a4d4fa621627a6099ba76<br>
&gt; 100644<br>
&gt; --- a/sample/sample-plugins/simple<wbr>/simple.c<br>
&gt; +++ b/sample/sample-plugins/simple<wbr>/simple.c<br>
&gt; @@ -72,7 +72,8 @@ get_env(const char *name, const char *envp[])<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 OPENVPN_EXPORT openvpn_plugin_handle_t<br>
&gt; -openvpn_plugin_open_v1(unsign<wbr>ed int *type_mask, const char *argv=
[], const<br>
&gt; char *envp[])<br>
&gt; +openvpn_plugin_open_v2(unsign<wbr>ed int *type_mask, const char *argv=
[], const<br>
&gt; char *envp[],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct openvpn_plugin_string_list **return_list)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct plugin_context *context;<br>
&gt; <br>
&gt; @@ -97,7 +98,8 @@ openvpn_plugin_open_v1(unsigne<wbr>d int *type_mask,=
 const<br>
&gt; char *argv[], const char *<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 OPENVPN_EXPORT int<br>
&gt; -openvpn_plugin_func_v1(openvp<wbr>n_plugin_handle_t handle, const int=
 type,<br>
&gt; const char *argv[], const char *envp[])<br>
&gt; +openvpn_plugin_func_v2(openvp<wbr>n_plugin_handle_t handle, const int=
 type,<br>
&gt; const char *argv[], const char *envp[],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0void *per_client_context, struct<br>
&gt; openvpn_plugin_string_list **return_list)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct plugin_context *context =3D (struct plugin_=
context *) handle;<br>
&gt; <br>
&gt; diff --git a/sample/sample-plugins/simple<wbr>/simple.def<br>
&gt; b/sample/sample-plugins/simple<wbr>/simple.def<br>
&gt; index<br>
&gt; a87507d1fdc0f0bfd0434de577a818<wbr>ef0cc62afb..556f362308bc6ce818<wbr>=
29253f7a7fae9898be221a<br>
&gt; 100755<br>
&gt; --- a/sample/sample-plugins/simple<wbr>/simple.def<br>
&gt; +++ b/sample/sample-plugins/simple<wbr>/simple.def<br>
&gt; @@ -1,6 +1,6 @@<br>
&gt;=C2=A0 LIBRARY=C2=A0 =C2=A0OpenVPN_PLUGIN_SAMPLE<br>
&gt;=C2=A0 DESCRIPTION &quot;Sample OpenVPN plug-in module.&quot;<br>
&gt;=C2=A0 EXPORTS<br>
&gt; -=C2=A0 =C2=A0openvpn_plugin_open_v1=C2=A0 =C2=A0@...912...<br>
&gt; -=C2=A0 =C2=A0openvpn_plugin_func_v1=C2=A0 =C2=A0@...1611...<br>
&gt; +=C2=A0 =C2=A0openvpn_plugin_open_v2=C2=A0 =C2=A0@...912...<br>
&gt; +=C2=A0 =C2=A0openvpn_plugin_func_v2=C2=A0 =C2=A0@...1611...<br>
&gt;=C2=A0 =C2=A0 =C2=A0openvpn_plugin_close_v1=C2=A0 @3<br>
&gt; --<br>
&gt; 2.15.2 (Apple Git-101.1)<br>
<br>
did you concatenate two patches? or what happened? It seems that the<br>
part after this is not recognised as proper patch.<br>
<br>
<br>
Cheers,<br>
<br>
<br>
-- <br>
Antonio Quartulli<br>
<br>
</blockquote>
</blockquote>

--000000000000a8d93b056fe3e0c8--

