MIME-Version: 1.0
References: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
 <0a3df5d288681bbf31d8f886d429d848a4ad3df7-EmailReplacePatchSet-HTML@...2715...>
In-Reply-To: <0a3df5d288681bbf31d8f886d429d848a4ad3df7-EmailReplacePatchSet-HTML@...2715...>
From: Jon Chiappetta <root@...2904...>
Date: Thu, 11 Sep 2025 13:32:57 -0400
Message-ID: <CAOh3LPOqmhVvtNJmJCiT_qtJVyyGv7U0gx0rak7t_KOYpW6O-g@...278...>
Content-Type: multipart/alternative; boundary="000000000000ddd3a6063e8a1e70"
Subject: Re: [Openvpn-devel] [XS] Change in openvpn[master]: Multi-socket
 win: avoid repeated socket_set()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: gianmarco@...2726..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--000000000000ddd3a6063e8a1e70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't have proof of it but I think I was being hit with this accept issue
as I've been running and testing OpenVPN in TCP client/server modes only.
I'll wait for this to hit master and rebase my PRs - thanks :)

On Thu, Sep 11, 2025 at 10:23=E2=80=AFAM its_Giaan (Code Review) <gerrit@...1186...=
.515...>
wrote:

> Attention is currently required from: flichtenheld, plaisthos.
>
> its_Giaan *uploaded patch set #3* to this change.
>
> View Change <http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail>
>
> Multi-socket win: avoid repeated socket_set()
>
> On Windows, multi-socket support failed with
> mixed protocols due to repeated socket_set()
> calls, which caused accept() to be triggered
> before having an event to process.
> This fix skips socket_set() calls for
> non-UDP sockets in MODE_SERVER inside
> multi_io_process_flags().
>
> Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b
> Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
> ---
> M src/openvpn/forward.c
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
> git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1174/3
>
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 03b6a0c..5d22fa3 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -2121,10 +2121,15 @@
>
>      /*
>       * Configure event wait based on socket, tuntap flags.
> +     * (for TCP server sockets this happens in
> +     *  socket_set_listen_persistent()).
>       */
>      for (int i =3D 0; i < c->c1.link_sockets_num; i++)
>      {
> -        socket_set(c->c2.link_sockets[i], es, socket, &c->c2.link_socket=
s[i]->ev_arg, NULL);
> +        if ((c->options.mode !=3D MODE_SERVER) || (proto_is_dgram(c->c2.=
link_sockets[i]->info.proto)))
> +        {
> +            socket_set(c->c2.link_sockets[i], es, socket, &c->c2.link_so=
ckets[i]->ev_arg, NULL);
> +        }
>      }
>
>      tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);
>
> To view, visit change 1174
> <http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail>. To unsubscribe,
> or for help writing mail filters, visit settings
> <http://gerrit.openvpn.net/settings>.
> Gerrit-Project: openvpn
> Gerrit-Branch: master
> Gerrit-Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b
> Gerrit-Change-Number: 1174
> Gerrit-PatchSet: 3
> Gerrit-Owner: its_Giaan <gianmarco@...2726...>
> Gerrit-Reviewer: flichtenheld <frank@...2641...>
> Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
> Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
> Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
> Gerrit-Attention: flichtenheld <frank@...2641...>
> Gerrit-MessageType: newpatchset
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000ddd3a6063e8a1e70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t have proof of it but I think I was being hit w=
ith this accept issue as I&#39;ve been running and testing OpenVPN in TCP c=
lient/server modes only. I&#39;ll wait for this to hit master and rebase my=
 PRs - thanks :)=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 11, 2025 at 10:23=
=E2=80=AFAM its_Giaan (Code Review) &lt;<a href=3D"mailto:gerrit@...515..."=
>gerrit@...515...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;border-left-color:rgb(204,204,204);padding-left:1ex"><p> Attention is=
 currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail" target=3D=
"_blank">View Change</a></p><pre style=3D"font-family:monospace,monospace;w=
hite-space:pre-wrap">Multi-socket win: avoid repeated socket_set()<br><br>O=
n Windows, multi-socket support failed with<br>mixed protocols due to repea=
ted socket_set()<br>calls, which caused accept() to be triggered<br>before =
having an event to process.<br>This fix skips socket_set() calls for<br>non=
-UDP sockets in MODE_SERVER inside<br>multi_io_process_flags().<br><br>Chan=
ge-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b<br>Signed-off-by: Gianmarc=
o De Gregori &lt;<a href=3D"mailto:gianmarco@...2726..." target=3D"_blank">=
gianmarco@...2726...</a>&gt;<br>---<br>M src/openvpn/forward.c<br>1 file ch=
anged, 6 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-famil=
y:monospace,monospace;white-space:pre-wrap">git pull ssh://<a href=3D"http:=
//gerrit.openvpn.net:29418/openvpn" target=3D"_blank">gerrit.openvpn.net:29=
418/openvpn</a> refs/changes/74/1174/3</pre><pre style=3D"font-family:monos=
pace,monospace;white-space:pre-wrap"><span>diff --git a/src/openvpn/forward=
.c b/src/openvpn/forward.c</span><br><span>index 03b6a0c..5d22fa3 100644</s=
pan><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn=
/forward.c</span><br><span>@@ -2121,10 +2121,15 @@</span><br><span> </span>=
<br><span>     /*</span><br><span>      * Configure event wait based on soc=
ket, tuntap flags.</span><br><span style=3D"color:rgb(0,204,0)">+     * (fo=
r TCP server sockets this happens in</span><br><span style=3D"color:rgb(0,2=
04,0)">+     *  socket_set_listen_persistent()).</span><br><span>      */</=
span><br><span>     for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++=
)</span><br><span>     {</span><br><span style=3D"color:rgb(204,0,0)">-    =
    socket_set(c-&gt;c2.link_sockets[i], es, socket, &amp;c-&gt;c2.link_soc=
kets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color:rgb(0,204,0)">+  =
      if ((c-&gt;options.mode !=3D MODE_SERVER) || (proto_is_dgram(c-&gt;c2=
.link_sockets[i]-&gt;info.proto)))</span><br><span style=3D"color:rgb(0,204=
,0)">+        {</span><br><span style=3D"color:rgb(0,204,0)">+            s=
ocket_set(c-&gt;c2.link_sockets[i], es, socket, &amp;c-&gt;c2.link_sockets[=
i]-&gt;ev_arg, NULL);</span><br><span style=3D"color:rgb(0,204,0)">+       =
 }</span><br><span>     }</span><br><span> </span><br><span>     tun_set(c-=
&gt;c1.tuntap, es, tuntap, (void *)tun_shift, NULL);</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1174?usp=3Demail" target=3D"_blank">change 1174</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings" target=3D"_blank">settings</a>.</p><div><div></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c=
23c17c04e6e9b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1174 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;<a href=3D"mailto:=
gianmarco@...2726..." target=3D"_blank">gianmarco@...2726...</a>&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;<a href=3D"m=
ailto:frank@...2641..." target=3D"_blank">frank@...2641...</a>&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;<a href=3D"mail=
to:arne-openvpn@...1227..." target=3D"_blank">arne-openvpn@...1227...</a>&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;<a href=3D"mailto=
:openvpn-devel@lists.sourceforge.net" target=3D"_blank">openvpn-devel@...1697...=
.sourceforge.net</a>&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;<a href=3D"mai=
lto:arne-openvpn@...1227..." target=3D"_blank">arne-openvpn@...1227...</a>&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;<a href=3D"=
mailto:frank@...2641..." target=3D"_blank">frank@...2641...</a>&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>

_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000ddd3a6063e8a1e70--

