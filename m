MIME-Version: 1.0
In-Reply-To: <61d8d41f-4c77-5235-a202-642983d494a3@...1227...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<61d8d41f-4c77-5235-a202-642983d494a3@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 31 May 2016 11:24:16 -0400
Message-ID: <CAKuzo_gyWfFnOe72CKkyPfAHAfN5uF8jWqp2jCosdZkJBYwoBw@...278...>
Content-Type: multipart/alternative; boundary=001a11449adc7c2425053424f8ce
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11449adc7c2425053424f8ce
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, May 31, 2016 at 4:37 AM, Arne Schwabe <arne@...1227...> wrote:

> Am 31.05.16 um 06:22 schrieb Selva Nair:
> > +#define PULL_FILTER_LIST_SIZE 64
> We already have dymanic lists, used for ignore-unknown-options and
> --route, any reason not to use them here?
>

I just thought 64 is good enough and kept it simple like the
connection_list.

Will consider making it dynamic if we go for a v2.

Thanks,

Selva

--001a11449adc7c2425053424f8ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, May 31, 2016 at 4:37 AM, Arne S=
chwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"_=
blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div>Am <s=
pan><span>31.05.16</span></span> um <span><span>06:22</span></span> schrieb=
 Selva Nair:<br>
&gt; +#define PULL_FILTER_LIST_SIZE 64<br>
We already have dymanic lists, used for ignore-unknown-options and<br>
--route, any reason not to use them here?</div></blockquote><div>=C2=A0</di=
v><div>I just thought 64 is good enough and kept it simple like the connect=
ion_list.</div><div><br></div><div>Will consider making it dynamic if we go=
 for a v2.</div></div></div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Thanks,</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div></div>

--001a11449adc7c2425053424f8ce--

