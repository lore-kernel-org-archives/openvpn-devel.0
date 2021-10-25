MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-13-arne@...1227...>
 <CAKuzo_hKfjbU2WhcTmerbq4qRU=rftc4y++TQ0piMzW-3Hg3CA@...278...>
In-Reply-To: <CAKuzo_hKfjbU2WhcTmerbq4qRU=rftc4y++TQ0piMzW-3Hg3CA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 25 Oct 2021 13:37:33 -0400
Message-ID: <CAKuzo_jjC5iEJ4AHy6WvJmtZg0AWmc4qtKCcNYsBa8wd5n6w9g@...278...>
Content-Type: multipart/alternative; boundary="000000000000e0c27405cf30d154"
Subject: Re: [Openvpn-devel] [PATCH v3 12/21] [OSSL 3.0] Allow loading of
 non default providers
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

--000000000000e0c27405cf30d154
Content-Type: text/plain; charset="UTF-8"

Hi,

I have caused more than enough chatter about this patch, hopefully this is
the last comment

I previously wrote:

>
> We should not repeatedly load providers in each SIGHUP loop without
> unloading them in some uninit() call. That would require saving pointers to
> these explicitly loaded providers, unfortunately...
>

I want to suggest an alternative: act on this option only the first time,
not in every SIGHUP loop. The reason being it's not easy to support
changing of loaded providers in the default libctx during every SIGHUP in a
good way:

OpenSSL will parse its config file only once and cannot be convinced to do
it again at SIGHUP. Also it will attempt to do the automatic provider
loading only once (the so-called fallback to default). That means, running
with "--providers foo" and doing a SIGHUP with that option removed from the
config file will result in no providers if we unload "foo". If we do not
unload it on SIGHUP, it will always be loaded contrary to user intent, as
well as leak memory due to multiple loads.

Just document that "--providers" will be parsed once and the program has to
be restarted to change it.

There are other approaches like swapping the default libctx, but not worth
the trouble, IMO.

Selva

>

--000000000000e0c27405cf30d154
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>I have caused more=
 than enough chatter about this patch, hopefully this is the last comment</=
div><div><br></div><div>I previously wrote:</div></div><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div class=3D"gmail_quote"><div><br></div><div>We should not repeatedly load=
 providers in each SIGHUP loop without unloading them in some uninit() call=
. That would require saving pointers to these explicitly loaded providers, =
unfortunately...</div></div></div></blockquote><div><br></div><div>I want t=
o suggest an alternative: act on this option only the first time, not in ev=
ery SIGHUP loop. The reason being it&#39;s not easy to support changing of =
loaded providers in the default libctx during every SIGHUP in a good way:</=
div><div><br></div><div>OpenSSL will parse its config file only once and ca=
nnot be convinced to do it again at SIGHUP. Also it will attempt to do the =
automatic provider loading only once (the so-called fallback to default). T=
hat means, running with &quot;--providers foo&quot; and doing a SIGHUP with=
 that option removed from the config=C2=A0file will result in no providers =
if we unload &quot;foo&quot;. If we do not unload it on SIGHUP, it=C2=A0wil=
l always be loaded contrary to user intent, as well as leak memory due to m=
ultiple loads.</div><div><br></div><div>Just document that &quot;--provider=
s&quot; will be parsed once and the program has to be restarted to change i=
t.</div><div><br></div><div>There are other approaches like swapping the de=
fault libctx, but not worth the trouble, IMO.</div><div><br></div><div>Selv=
a</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div>

--000000000000e0c27405cf30d154--

