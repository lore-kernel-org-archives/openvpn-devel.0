MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
 <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
 <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9AF9896@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10C9AF9896@...2294...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 20 Nov 2019 15:02:13 +0200
Message-ID: <CAGyAFMWEc0c_GRiphD+=zikh2BkMckxD4rjZXrmQfmLUejAkgA@...278...>
Content-Type: multipart/alternative; boundary="000000000000d299590597c6cac5"
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintun
 device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Selva Nair <selva.nair@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d299590597c6cac5
Content-Type: text/plain; charset="UTF-8"

Hi,


> We have more options here:
>

Can we combine B and C?

1) During installation, we create one adapter, as we do now.

2) On connection we enumerate adapters and pick the first one which is not
connected.

3) If we could not find free adapter (another VPN connection is already
running), we create one on demand.

-- 
-Lev

--000000000000d299590597c6cac5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>=C2=A0</div><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div lang=3D"SL"><p class=
=3D"MsoNormal"><span lang=3D"EN-GB">We have more options here:</span></p></=
div></blockquote><div><br></div><div>Can we combine B and C?</div><div><br>=
</div><div>1) During installation, we create one adapter, as we do now.</di=
v><div><br></div><div>2) On connection we enumerate adapters and pick the f=
irst one which is not connected.</div><div><br></div><div>3) If we could no=
t find free adapter (another VPN connection is already running), we create =
one on demand.</div></div><div><br></div>-- <br><div dir=3D"ltr">-Lev</div>=
</div>

--000000000000d299590597c6cac5--

