MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
 <CAGyAFMVjqC4mdjy83v+UqgLBnv3yLGwRT5Hg_PAB+_PwEMoDZw@...278...>
 <CAA1Abx+u=ZRaVVfwSfrSJOJYhFdRbX8q-amMt8LV+jL+du+2dw@...278...>
In-Reply-To: <CAA1Abx+u=ZRaVVfwSfrSJOJYhFdRbX8q-amMt8LV+jL+du+2dw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Sep 2019 20:54:28 +0300
Message-ID: <CAGyAFMVQy9U09nXkr1Q66qpHrBNoX99b_dF93kd+0w9w4sqC5Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000964af30592ffc3af"
Subject: Re: [Openvpn-devel] [PATCH 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000964af30592ffc3af
Content-Type: text/plain; charset="UTF-8"

Hi Steffan,

Out of curiosity: does the (signed) driver from wintun.net not work? Of so,
> why?
>

It does. It is just not usable for openvpn yet because:

1)  Wintun is distributed as msm module, which is supposed to be integrated
into MSI installer.
Our MSI installer doesn't support wintun yet.

2) One can install wireguard client, which installs wintun, however it
still won't work
for openvpn out of the box. Wireguard creates tun adapter on demand, and
openvpn
expects it to already exist. So if you try to use openvpn with wintun after
installing wireguard
you'll get error "no tun adapters found" (or something). This is not a
problem, since
we have "tapctl" tool which can create/list/delete tun/tap adapters. It
does not work with
wintun, though, since it has hardcoded "tap0901" hardware id. I plan to
make it customizable
so one could create wintun adapter by running something like "tapctl.exe
create --name openvpn-wintun --hwid wintun".
We could consider creating tun adapter on demand, but this increases
connection time by a few seconds.

-- 
-Lev

--000000000000964af30592ffc3af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Steffan,</div><div><br></div><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><=
div dir=3D"auto"></div><div dir=3D"auto">Out of curiosity: does the (signed=
) driver from <a href=3D"http://wintun.net" target=3D"_blank">wintun.net</a=
> not work? Of so, why?</div></div></blockquote><div><br></div><div>It does=
. It is just not usable for openvpn yet because:</div><div><br></div><div>1=
)=C2=A0 Wintun is distributed as msm module, which is supposed to be integr=
ated into MSI installer.=C2=A0</div><div>Our MSI installer doesn&#39;t supp=
ort wintun yet.</div><div><br></div><div>2) One can install wireguard clien=
t, which installs wintun, however it still won&#39;t work</div><div>for ope=
nvpn out of the box. Wireguard creates tun adapter on demand, and openvpn</=
div><div>expects it to already exist. So if you try to use openvpn with win=
tun after installing wireguard=C2=A0</div><div>you&#39;ll get error &quot;n=
o tun adapters found&quot; (or something). This is not a problem, since</di=
v><div>we have &quot;tapctl&quot; tool which can create/list/delete tun/tap=
 adapters. It does not work with=C2=A0</div><div>wintun, though, since it h=
as hardcoded &quot;tap0901&quot; hardware id. I plan to make it customizabl=
e</div><div>so one could create wintun adapter by running something like &q=
uot;tapctl.exe create --name openvpn-wintun --hwid wintun&quot;.</div><div>=
We could consider creating tun adapter on demand, but this increases connec=
tion time by a few seconds.</div><div>=C2=A0</div></div>-- <br><div dir=3D"=
ltr" class=3D"gmail_signature">-Lev</div></div>

--000000000000964af30592ffc3af--

