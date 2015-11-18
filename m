MIME-Version: 1.0
In-Reply-To: <564BA6DB.4070703@...2070...>
References: <56307DAA.30700@...2070...> <564BA6DB.4070703@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 17 Nov 2015 21:07:36 -0500
Message-ID: <CAKuzo_isk-KVZ=LLUw_-O4Db-Zimr1FfNAzZ7WBa3uUtHCXyWA@...278...>
Content-Type: multipart/alternative; boundary=001a1130cd465ac32c0524c71cdd
Subject: Re: [Openvpn-devel] [PATCH v3-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns').
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1130cd465ac32c0524c71cdd
Content-Type: text/plain; charset=UTF-8

Hi,

I feel some of the errors may have to be treated as  FATAL. I understand
this patch was discussed in the last IRC meeting, so may be I'm
misunderstanding this, please bear with me.

I presume, the main purpose of the option is to work around something seen
as a serious security issue for some people (dns leak). If so, when a user
specifies --block-outside-dns, and we fail to block it, shouldn't we exit?

On Tue, Nov 17, 2015 at 5:14 PM, ValdikSS <iam@...2070...> wrote:

> +      if (c->options.block_outside_dns)
> +      {
> +          if (!win_wfp_init())
> +            msg (M_NONFATAL, "Initialising WFP failed!");
> +            else
> +            {
> +                dmsg (D_LOW, "Blocking outside DNS");
> +                if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
> +                    msg (M_NONFATAL, "Blocking DNS failed!");
>

M_FATAL here and a few other places?

Further, if there is an error during the set up of a filter, all previously
setup filters should be removed, This may become a non-issue if errors are
made FATAL.

Selva

--001a1130cd465ac32c0524c71cdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">I feel some of the errors may have to be treated as=C2=A0 FATA=
L. I understand this patch was discussed in the last IRC meeting, so may be=
 I&#39;m misunderstanding this, please bear with me.<br><br>I presume, the =
main purpose of the option is to work around something seen as a serious se=
curity issue for some people (dns leak). If so, when a user specifies --blo=
ck-outside-dns, and we fail to block it, shouldn&#39;t we exit? <br></div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote">On Tue, Nov 17, 2015 at 5:14 PM, ValdikSS <span dir=3D"ltr=
">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...2070...</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":61i" clas=
s=3D"a3s" style=3D"overflow:hidden">+=C2=A0 =C2=A0 =C2=A0 if (c-&gt;options=
.block_outside_dns)<br>
+=C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_init())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_NONFATAL, &quot;Initialis=
ing WFP failed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg (D_LOW, &quot=
;Blocking outside DNS&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_block=
_dns(c-&gt;c1.tuntap-&gt;adapter_index))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =
(M_NONFATAL, &quot;Blocking DNS failed!&quot;);</div></blockquote></div><br=
></div><div class=3D"gmail_extra">M_FATAL here and a few other places?<br><=
br></div><div class=3D"gmail_extra">Further, if there is an error during th=
e set up of a filter, all previously setup filters should be removed, This =
may become a non-issue if errors are made FATAL.<br></div><div class=3D"gma=
il_extra"><br></div><div class=3D"gmail_extra">Selva<br></div><div class=3D=
"gmail_extra"><br></div></div>

--001a1130cd465ac32c0524c71cdd--

