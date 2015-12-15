MIME-Version: 1.0
In-Reply-To: <CAKuzo_jrxgCRMjYA3T_tJNmNsHXy+MqqVMo8NK3KEDgmseMMBg@...278...>
References: <CAHSx_StWk=Es9qg9TSq6yXACPhTLneeeUWNDDaKqp06S0x6R=w@...278...>
	<1449766646-3519-1-git-send-email-wayne@...2099...>
	<CAKuzo_jrxgCRMjYA3T_tJNmNsHXy+MqqVMo8NK3KEDgmseMMBg@...278...>
From: Wayne Davison <wayne@...2099...>
Date: Tue, 15 Dec 2015 14:15:26 -0800
Message-ID: <CAHSx_SuB8wu8_RWcfTfDhFQhrek89-Wu-pBo1FXbBNfHxRUTYg@...278...>
Content-Type: multipart/alternative; boundary=089e013cba0e99aecd0526f721a6
Subject: Re: [Openvpn-devel] [PATCH] Improve stdin prompting section,
 fixing CR prompting.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e013cba0e99aecd0526f721a6
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 15, 2015 at 12:51 PM, Selva Nair <selva.nair@...277...> wrote:

> This could be a small ~2 line patch -- easier to review and test.
>

I'll post a 3-part patch as a reply to this email. They are: (1) the "if"
removal that fixes the bug, (2) the prompt buffer moves, and (3) the
reindentation.  If you end up wanting to consider the CR-from-a-file
feature, that patch would be unchanged from the last one I posted.

..wayne..

--089e013cba0e99aecd0526f721a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 15, 2015 at 12:51 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_qu=
ote">This could be a small ~2 line patch -- easier to review and test.</div=
></blockquote></div><br>I&#39;ll post a 3-part patch as a reply to this ema=
il. They are: (1) the &quot;if&quot; removal that fixes the bug, (2) the pr=
ompt buffer moves, and (3) the reindentation.=C2=A0 If you end up wanting t=
o consider the CR-from-a-file feature, that patch would be unchanged from t=
he last one I posted.<br><br clear=3D"all"><div><div class=3D"gmail_signatu=
re">..wayne..</div></div>
</div></div>

--089e013cba0e99aecd0526f721a6--

