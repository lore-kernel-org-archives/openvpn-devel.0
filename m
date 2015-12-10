MIME-Version: 1.0
In-Reply-To: <5669AD21.4000301@...2070...>
References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...> <20151210162651.GI24952@...1296...>
	<5669AD21.4000301@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 12:17:24 -0500
Message-ID: <CAKuzo_jhYhGT7y_+O1Z73RLW51RuHB702MxxmHbVS5XG2jg0dw@...278...>
Content-Type: multipart/alternative; boundary=001a1148ce1c88803a05268e6217
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
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148ce1c88803a05268e6217
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 10, 2015 at 11:49 AM, ValdikSS <iam@...2070...> wrote:

> It's a very minor actually, FwpmSubLayerDeleteByKey0 is indeed fails every
> time but it doesn't break anything since we close the engine right after.
> Lev suggested to use a correct way with making a filter GUID and deleting
> it before deleting sublayer, but I'd better go with just closing the engine
> without deleting everything. I don't see any drawbacks, that should be
> perfectly OK for a dynamic session.


Provided it doesn't leak memory. As the current implementation of
wfp_add_filter does return the id of the added filter (in &filterid) , its
easy to save them into some globals and delete all the filters in
wfp_uninit.

However, If you are sure there is no leak, just closing the engine is fine.

Other than this v8 is good to go.

Selva

--001a1148ce1c88803a05268e6217
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 10, 2015 at 11:49 AM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D=
"mailto:iam@...2070..." target=3D"_blank">iam@...2070...</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">It&#39;s a very minor actually, FwpmS=
ubLayerDeleteByKey0 is indeed fails
    every time but it doesn&#39;t break anything since we close the engine
    right after. Lev suggested to use a correct way with making a filter
    GUID and deleting it before deleting sublayer, but I&#39;d better go
    with just closing the engine without deleting everything. I don&#39;t
    see any drawbacks, that should be perfectly OK for a dynamic
    session.</blockquote></div><br></div><div class=3D"gmail_extra">Provide=
d it doesn&#39;t leak memory. As the current implementation of wfp_add_filt=
er does return the id of the added filter (in &amp;filterid) , its easy to =
save them into some globals and delete all the filters in wfp_uninit.<br><b=
r></div><div class=3D"gmail_extra">However, If you are sure there is no lea=
k, just closing the engine is fine.<br><br></div><div class=3D"gmail_extra"=
>Other than this v8 is good to go.<br></div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra">Selva<br></div></div>

--001a1148ce1c88803a05268e6217--

