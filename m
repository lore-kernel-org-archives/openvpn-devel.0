MIME-Version: 1.0
In-Reply-To: <56694C04.6020904@...277...>
References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 10:53:30 -0500
Message-ID: <CAKuzo_j6+gjt+_EDVt3CeOR89mAnDNdYtMFfzXDMHbiTjumgnA@...278...>
Content-Type: multipart/alternative; boundary=047d7bfcefb0834b3805268d36d3
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bfcefb0834b3805268d36d3
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 10, 2015 at 4:55 AM, Lev Stipakov <lstipakov@...277...> wrote:

> +bool
> +win_wfp_uninit()
> +{
> +    dmsg (D_LOW, "Uninitializing WFP");
> +    if (m_hEngineHandle) {
> +        FwpmSubLayerDeleteByKey0(m_hEngineHandle, &m_subLayerGUID);
> +        CLEAR(m_subLayerGUID);
> +        FwpmEngineClose0(m_hEngineHandle);
> +        m_hEngineHandle = NULL;
>
>
> FwpmSubLayerDeleteByKey0 will likely fail if there is a filter
> associated with sublayer. On the other side, FwpmEngineClose0 seems to
> be enough to remove blocking.
>
> I think the correct way would be to create GUID for filter same way as
> you did for sublayer and copy it to filter.filterKey. In uninit method,
> before deleting sublayer you call FwpmFilterDeleteByKey0 with that guid.


That sounds useful for yet another reason as well. Its only necessary to
delete and recreate the permit filters when the tun restarts. The block
filters need be set up only once.

Selva

--047d7bfcefb0834b3805268d36d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 10, 2015 at 4:55 AM, Lev Stipakov <span dir=3D"ltr">&lt;<a href=
=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">+bool<b=
r>
+win_wfp_uninit()<br>
+{<br>
+=C2=A0 =C2=A0 dmsg (D_LOW, &quot;Uninitializing WFP&quot;);<br>
+=C2=A0 =C2=A0 if (m_hEngineHandle) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FwpmSubLayerDeleteByKey0(m_hEngineHandle, &amp=
;m_subLayerGUID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CLEAR(m_subLayerGUID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FwpmEngineClose0(m_hEngineHandle);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_hEngineHandle =3D NULL;<br>
<br>
<br>
</span>FwpmSubLayerDeleteByKey0 will likely fail if there is a filter<br>
associated with sublayer. On the other side, FwpmEngineClose0 seems to<br>
be enough to remove blocking.<br>
<br>
I think the correct way would be to create GUID for filter same way as<br>
you did for sublayer and copy it to filter.filterKey. In uninit method,<br>
before deleting sublayer you call FwpmFilterDeleteByKey0 with that guid.</b=
lockquote><div><br></div><div>That sounds useful for yet another reason as =
well. Its only necessary to delete and recreate the permit filters when the=
 tun restarts. The block filters need be set up only once.<br></div></div><=
br></div><div class=3D"gmail_extra">Selva<br></div><div class=3D"gmail_extr=
a"><br></div></div>

--047d7bfcefb0834b3805268d36d3--

