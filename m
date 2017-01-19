MIME-Version: 1.0
In-Reply-To: <4fba3b6f-cffe-6e7a-71f8-c654721c0235@...2080...>
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
	<3e2e63ed-99fb-e880-11dc-b0748f501567@...2080...>
	<CAKuzo_g+PPAfxUZMAmE0L4JKk7Wwp6Y58VfdAJGQA5Ys6j52OQ@...278...>
	<4fba3b6f-cffe-6e7a-71f8-c654721c0235@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 19 Jan 2017 14:46:51 -0500
Message-ID: <CAKuzo_h97pt=DO_v-sy1CicduBvcBJvogqBva+byHHtE3BtPcA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0626689efe05054677cc7a
Subject: Re: [Openvpn-devel] [PATCH] Add a check for -Wl,
	--wrap support in linker
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0626689efe05054677cc7a
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Jan 19, 2017 at 2:36 PM, David Sommerseth <
openvpn@...2080...> wrote:

> > So currently its just a preprocessor define that provides a solution
> > waiting for a problem. If the consensus is not to define it, fine with
> me.
>
> I have no issues adding such an AC_DEFINE when we have a good use-case
> for it.  But if we don't need it now, I think it's best to keep things
> as simple as possible, in particular in the autotools stuff which can
> already be quite confusing.


Then please take it out at merge time -- its only one line. And if we need
it in future could be easily added.

Selva

--94eb2c0626689efe05054677cc7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Jan 19, 2017 at 2:36 PM, David =
Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." targ=
et=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">&gt; So currently its just a preprocessor de=
fine that provides a solution<br>
&gt; waiting for a problem. If the consensus is not to define it, fine with=
 me.<br>
<br>
</span>I have no issues adding such an AC_DEFINE when we have a good use-ca=
se<br>
for it.=C2=A0 But if we don&#39;t need it now, I think it&#39;s best to kee=
p things<br>
as simple as possible, in particular in the autotools stuff which can<br>
already be quite confusing.</blockquote></div><br>Then please take it out a=
t merge time -- its only one line. And if we need it in future could be eas=
ily added.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ex=
tra">Selva</div></div>

--94eb2c0626689efe05054677cc7a--

