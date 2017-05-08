MIME-Version: 1.0
In-Reply-To: <20170504173605.8269-1-valdikss@...277...>
References: <20170504173605.8269-1-valdikss@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 8 May 2017 10:47:05 -0400
Message-ID: <CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06ff3e45f1f7054f0451dd
Subject: Re: [Openvpn-devel] [PATCH] Set a low interface metric for tap
 adapter when block-outside-dns is in use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c06ff3e45f1f7054f0451dd
Content-Type: text/plain; charset=UTF-8

Hi,

Please bear with me for making a few more comments. This close to final so
only
a few minor issues.

On Thu, May 4, 2017 at 1:36 PM, ValdikSS <valdikss@...277...> wrote:
>
> Windows 10 before Creators Update used to resolve DNS using all available
> adapters and IP addresses in parallel.
> Now it still resolves addresses using all available adapters but in a
> round-robin way, beginning with random adapter.
> This behaviour introduces significant delay when block-outside-dns is in
> use.
> Fortunately, setting low metric for the TAP interface solves this issue,
> making Windows always pick with TAP adapter first.
>

Nitpicking here, but anyway a new version is required (see below), so
it would be nice if you wrap lines in commit message to something
like about 70 to 80 at most. Not sure whether we have a policy on this..

diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
> index e31765e..9d49355 100644
> --- a/src/openvpn/block_dns.c
> +++ b/src/openvpn/block_dns.c
> @@ -341,4 +341,79 @@ delete_block_dns_filters(HANDLE engine_handle)
>      return err;
>  }
> +/*
> + * Returns interface metric value for specified interface index.
> + *
> + * Arguments:
> + *   index         : The index of TAP adapter.
> + *   family        : Address family (AF_INET for IPv4 and AF_INET6 for
> IPv6).
> + * Returns positive metric value or zero for automatic metric on success,
> + * a less then zero error code on failure.
> + */
> +
> +int
> +get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family)
> +{
> +    DWORD err = 0;
> +    MIB_IPINTERFACE_ROW ipiface;
> +    InitializeIpInterfaceEntry(&ipiface);


InitializeIpInterfaceEntry() is missing in all but very recent mingw32
versions
(their commit logs show it was added in early 2015) so we may need
to declare it in block_dns.c. I use Debian jessie (8.7) -- mingw gcc 4.9.1
and its
not there. I believe Samuli's build system uses an even older version.

Note that 64 bit build still succeeds with a warning but 32 bit will fail
because
of stdcall. Yes, its stdcall though MSDN doesn't mention it as such.


>  typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);
>
>  DWORD
> @@ -36,5 +39,32 @@ DWORD
>  add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR
> *exe_path,
>                        block_dns_msg_handler_t msg_handler_callback);
>
> +/**
> + * Sets interface metric value for specified interface index
>

This would be "Get" or "Return" not "Set"


> + *
> + * @param index The index of TAP adapter
> + * @param family Address family (AF_INET for IPv4 and AF_INET6 for IPv6)
> + *
> + * @return positive metric value or zero for automatic metric on success,
> + * a less then zero error code on failure.
> + */
> +
> +int
> +get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY
> family);
>
>
..



> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 18e7aee..dc411fc 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -61,6 +61,11 @@
>  static HANDLE m_hEngineHandle = NULL; /* GLOBAL */
>
>  /*
> + * TAP adapter original metric value
> + */
> +static int tap_metric = -1; /* GLOBAL */
> +
> +/*
>   * Windows internal socket API state (opaque).
>   */
>  static struct WSAData wsa_state; /* GLOBAL */
> @@ -1337,6 +1342,21 @@ win_wfp_block_dns(const NET_IFINDEX index, const
> HANDLE msg_channel)
>
>      status = add_block_dns_filters(&m_hEngineHandle, index, openvpnpath,
>                                     block_dns_msg_handler);
> +    if (status == 0)
> +    {
> +        tap_metric = get_interface_metric(index, AF_INET);
>

The current metric is queried and saved only for v4 while the metric is
set and restored for both v4 and v6. Isn't it necessary to also save the
metric for both independently? I'm not sure whether anyone really uses
different metric for v4 and v6 but Windows allows it.


> +        if (tap_metric < 0)
> +        {
> +            /* error, should not restore metric */
> +            tap_metric = -1;
> +        }
> +        status = set_interface_metric(index, AF_INET,
> BLOCK_DNS_IFACE_METRIC);
> +        if (!status)
> +        {
> +            set_interface_metric(index, AF_INET6, BLOCK_DNS_IFACE_METRIC);
> +        }
> +    }
> +
>      ret = (status == 0);
>
>  out:
>
>
> @@ -1325,6 +1368,7 @@ static VOID
>  Undo(undo_lists_t *lists)
>  {
>      undo_type_t type;
> +    block_dns_data_t *interface_data;
>      for (type = 0; type < _undo_type_max; type++)
>      {
>          list_item_t **pnext = &(*lists)[type];
> @@ -1350,8 +1394,15 @@ Undo(undo_lists_t *lists)
>                      break;
>
>                  case block_dns:
> -                    delete_block_dns_filters(item->data);
> -                    item->data = NULL;
> +                    interface_data = (block_dns_data_t*)(item->data);
> +                    delete_block_dns_filters(interface_data->engine);
> +                    if (interface_data->metric > 0)
>

Here ">" should be ">=0", else automatic metric is not restored.


> +                    {
> +                        set_interface_metric(interface_data->index,
> AF_INET,
> +                                             interface_data->metric);
> +                        set_interface_metric(interface_data->index,
> AF_INET6,
> +                                             interface_data->metric);
> +                    }
>                      break;
>              }
>

Finally there are some trailing white space errors (6 places). This is a
good
opportunity to fix those too.

Thanks,

Selva

--94eb2c06ff3e45f1f7054f0451dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Please bear with me for making a fe=
w more comments. This close to final so only<br>a few minor issues.<br></di=
v><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Ma=
y 4, 2017 at 1:36 PM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:vald=
ikss@...277..." target=3D"_blank">valdikss@...277...</a>&gt;</span> wrote:<=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
Windows 10 before Creators Update used to resolve DNS using all available a=
dapters and IP addresses in parallel.<br>
Now it still resolves addresses using all available adapters but in a round=
-robin way, beginning with random adapter.<br>
This behaviour introduces significant delay when block-outside-dns is in us=
e.<br>
Fortunately, setting low metric for the TAP interface solves this issue, ma=
king Windows always pick with TAP adapter first.<br></blockquote><div><br><=
/div><div>Nitpicking here, but anyway a new version is required (see below)=
, so</div><div>it would be nice if you wrap lines in commit message to some=
thing</div><div>like about 70 to 80 at most. Not sure whether we have a pol=
icy on this..</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span style=3D"font-size:12.8px">diff --git a/src/openvpn/block_=
dns.c b/src/openvpn/block_dns.c<br></span><span style=3D"font-size:12.8px">=
index e31765e..9d49355 100644<br></span><span style=3D"font-size:12.8px">--=
- a/src/openvpn/block_dns.c<br></span><span style=3D"font-size:12.8px">+++ =
b/src/openvpn/block_dns.c<br></span><span style=3D"font-size:12.8px">@@ -34=
1,4 +341,79 @@ delete_block_dns_filters(</span><span style=3D"font-size:12.=
8px">HANDL<wbr>E engine_handle)<br></span><span style=3D"font-size:12.8px">=
=C2=A0 =C2=A0 =C2=A0return err;<br></span><span style=3D"font-size:12.8px">=
=C2=A0}</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8p=
x">+/*<br></span><span style=3D"font-size:12.8px">+ * Returns interface met=
ric value for specified interface index.<br></span><span style=3D"font-size=
:12.8px">+ *<br></span><span style=3D"font-size:12.8px">+ * Arguments:<br><=
/span><span style=3D"font-size:12.8px">+ *=C2=A0 =C2=A0index=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0: The index of TAP adapter.<br></span><span style=3D"fo=
nt-size:12.8px">+ *=C2=A0 =C2=A0family=C2=A0 =C2=A0 =C2=A0 =C2=A0 : Address=
 family (AF_INET for IPv4 and AF_INET6 for IPv6).<br></span><span style=3D"=
font-size:12.8px">+ * Returns positive metric value or zero for automatic m=
etric on success,<br></span><span style=3D"font-size:12.8px">+ * a less the=
n zero error code on failure.<br></span><span style=3D"font-size:12.8px">+ =
*/<br></span><span style=3D"font-size:12.8px">+<br></span><span style=3D"fo=
nt-size:12.8px">+int<br></span><span style=3D"font-size:12.8px">+get_interf=
ace_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family)<br></span>=
<span style=3D"font-size:12.8px">+{<br></span><span style=3D"font-size:12.8=
px">+=C2=A0 =C2=A0 DWORD err =3D 0;<br></span><span style=3D"font-size:12.8=
px">+=C2=A0 =C2=A0 MIB_IPINTERFACE_ROW ipiface;<br></span><span style=3D"fo=
nt-size:12.8px">+=C2=A0 =C2=A0 InitializeIpInterfaceEntry(&amp;</span><span=
 style=3D"font-size:12.8px">ip<wbr>iface);</span>=C2=A0</blockquote><div><b=
r></div><div>InitializeIpInterfaceEntry() is missing in all but very recent=
 mingw32 versions<br></div><div>(their commit logs show it was added in ear=
ly 2015) so we may need</div><div>to declare it in block_dns.c. I use Debia=
n jessie (8.7) -- mingw gcc 4.9.1 and its<br></div><div>not there. I believ=
e Samuli&#39;s build system uses an even older version.</div><div><br></div=
><div>Note that 64 bit build still succeeds with a warning but 32 bit will =
fail because</div><div>of stdcall. Yes, its stdcall though MSDN doesn&#39;t=
 mention it as such.<br></div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><br>
=C2=A0typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);=
<br>
<br>
=C2=A0DWORD<br>
@@ -36,5 +39,32 @@ DWORD<br>
=C2=A0add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *e=
xe_path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0block_dns_msg_handler_t msg_handler_callback);<br>
<br>
+/**<br>
+ * Sets interface metric value for specified interface index<br>
</blockquote><div><br></div><div>This would be &quot;Get&quot; or &quot;Ret=
urn&quot; not &quot;Set&quot;</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">+ *<br>
+ * @param index The index of TAP adapter<br>
+ * @param family Address family (AF_INET for IPv4 and AF_INET6 for IPv6)<b=
r>
+ *<br>
+ * @return positive metric value or zero for automatic metric on success,<=
br>
+ * a less then zero error code on failure.<br>
+ */<br>
+<br>
+int<br>
+get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family)=
;<br><br></blockquote><div><br></div><div>..</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c<br>
index 18e7aee..dc411fc 100644<br>
--- a/src/openvpn/win32.c<br>
+++ b/src/openvpn/win32.c<br>
@@ -61,6 +61,11 @@<br>
=C2=A0static HANDLE m_hEngineHandle =3D NULL; /* GLOBAL */<br>
<br>
=C2=A0/*<br>
+ * TAP adapter original metric value<br>
+ */<br>
+static int tap_metric =3D -1; /* GLOBAL */<br>
+<br>
+/*<br>
=C2=A0 * Windows internal socket API state (opaque).<br>
=C2=A0 */<br>
=C2=A0static struct WSAData wsa_state; /* GLOBAL */<br>
@@ -1337,6 +1342,21 @@ win_wfp_block_dns(const NET_IFINDEX index, const HAN=
DLE msg_channel)<br>
<br>
=C2=A0 =C2=A0 =C2=A0status =3D add_block_dns_filters(&amp;m_hEngi<wbr>neHan=
dle, index, openvpnpath,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block_dns_msg_handler)=
;<br>
+=C2=A0 =C2=A0 if (status =3D=3D 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_metric =3D get_interface_metric(index, AF_=
INET);<br></blockquote><div><br></div><div>The current metric is queried an=
d saved only for v4 while the metric is</div><div>set and restored for both=
 v4 and v6. Isn&#39;t it necessary to also save the</div><div>metric for bo=
th independently? I&#39;m not sure whether anyone really uses<br>different =
metric for v4 and v6 but Windows allows it.<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tap_metric &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error, should not restore met=
ric */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_metric =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D set_interface_metric(index, AF_INET=
, BLOCK_DNS_IFACE_METRIC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!status)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_interface_metric(index, AF_I=
NET6, BLOCK_DNS_IFACE_METRIC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ret =3D (status =3D=3D 0);<br>
<br>
=C2=A0out:<br><br><br>
@@ -1325,6 +1368,7 @@ static VOID<br>
=C2=A0Undo(undo_lists_t *lists)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0undo_type_t type;<br>
+=C2=A0 =C2=A0 block_dns_data_t *interface_data;<br>
=C2=A0 =C2=A0 =C2=A0for (type =3D 0; type &lt; _undo_type_max; type++)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_item_t **pnext =3D &amp;(*lists)[typ=
e];<br>
@@ -1350,8 +1394,15 @@ Undo(undo_lists_t *lists)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case block_dn=
s:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dele=
te_block_dns_filters(item-<wbr>&gt;data);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 item=
-&gt;data =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inte=
rface_data =3D (block_dns_data_t*)(item-&gt;data<wbr>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dele=
te_block_dns_filters(inter<wbr>face_data-&gt;engine);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
interface_data-&gt;metric &gt; 0)<br>
</blockquote><div><br></div><div>Here &quot;&gt;&quot; should be &quot;&gt;=
=3D0&quot;, else automatic metric is not restored.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 set_interface_metric(interface<wbr>_data-&gt;index, AF_INET,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0interface_data-&gt;metric);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 set_interface_metric(interface<wbr>_data-&gt;index, AF_INET6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0interface_data-&gt;metric);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br>=
</div><div>Finally there are some trailing white space errors (6 places). T=
his is a good</div><div>opportunity to fix those too.</div><div><br></div><=
div>Thanks,</div><div><br></div><div>Selva</div></div></div></div></div>

--94eb2c06ff3e45f1f7054f0451dd--

