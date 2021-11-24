MIME-Version: 1.0
References: <20211119015548.687-1-lstipakov@...277...>
 <202111241005.1AOA5Os7011522@...2054...>
 <CAGyAFMWf57YwLvvDERYmUv4427amuAkHro5c4vMHP-7huLoxaA@...278...>
In-Reply-To: <CAGyAFMWf57YwLvvDERYmUv4427amuAkHro5c4vMHP-7huLoxaA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Nov 2021 09:53:52 -0500
Message-ID: <CAKuzo_gAuKviVbFDJ6UUahnqXW1C8eLsBCDLvAR_Cz8fzd_ZGQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000ad53d805d18a0769"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Load OpenSSL config on
 Windows from trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ad53d805d18a0769
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Nov 24, 2021 at 9:28 AM Lev Stipakov <lstipakov@...277...> wrote:

> Do we need this fix in openvpn-gui? It only (?) uses openssl to change
> private key password, could this functionality be affected by config?
>

I do not know.. We do not call any functions that would lead to a config
loading, so probably not required. Automatic crypto initialization does not
load the config, nor does an explicit call to OPENSSL_init_crypto() unless
instructed to. OPENSSL_init_ssl() loads the config unless explicitly
disabled, but we do not use it in the GUI.

However, to be on the safe side, we could set these env vars if not already
set by the user.

Selva

--000000000000ad53d805d18a0769
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Nov 24, 2021 at 9:28 AM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Do we need this fix in openvpn-gui? It only (?) uses openssl to change<br>
private key password, could this functionality be affected by config?<br></=
blockquote><div><br></div><div>I do not know.. We do not call any functions=
 that would lead to a config loading, so probably not required. Automatic c=
rypto initialization does not load the config, nor does an explicit call to=
 OPENSSL_init_crypto() unless instructed to. OPENSSL_init_ssl() loads the c=
onfig unless explicitly disabled, but we do not use it in the GUI.=C2=A0</d=
iv><div><br></div><div>However, to be on the safe side, we could set these =
env vars if not already set by the user.=C2=A0</div><div><br></div><div>Sel=
va</div></div></div>

--000000000000ad53d805d18a0769--

