MIME-Version: 1.0
In-Reply-To: <1340730302-3077-1-git-send-email-alon.barlev@...277...>
References: <1340730302-3077-1-git-send-email-alon.barlev@...277...>
Date: Tue, 26 Jun 2012 20:07:21 +0300
Message-ID: <CAOazyz27P1YrdLFmL-DR7L1dgORwUyBa-NGRqPNo8Ex+3Q7vag@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] plugin: load plugin relative to
	plugindir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Tue, Jun 26, 2012 at 8:05 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Currently openvpn requires/endorses specifying full path in plugin
> parameter. As build system already aware of plugin location, it is
> possible to load plugin relative to this directory, so full path is not
> required nor more secured.
>
> Windows is a little more complex as user may change installation
> directory at install time, so we read plugindir location from the
> registry, installer will set this value.
>
> This replaces the old unused logic of the PLUGIN_LIBDIR macro.
>
> The old unused logic of =C2=A0ENABLE_PLUGIN_SEARCH is also removed as plu=
gins
> are relative to the plugindir.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0src/openvpn/Makefile.am | =C2=A0 =C2=A01 +
> =C2=A0src/openvpn/options.c =C2=A0 | =C2=A0 =C2=A03 +
> =C2=A0src/openvpn/plugin.c =C2=A0 =C2=A0| =C2=A0102 +++++++++++++++++++++=
++++++++++----------------
> =C2=A03 files changed, 72 insertions(+), 34 deletions(-)

Yes,
I don't know why I keep doing this to my-self so with the current attitude.
But every place I look I find stuff that should be modified.

