From: Kristof Provost <kp@...1376...>
Date: Mon, 08 May 2023 18:15:52 +0200
Message-ID: <20D50979-90A2-45C2-9C10-FDD8E0CDC803@...1376...>
In-Reply-To: <202305081155.348BtYlh004143@...2054...>
References: <20230414094227.9153-1-kprovost@...2661...>
 <202305081155.348BtYlh004143@...2054...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] DCO: support key rotation
 notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 8 May 2023, at 13:55, Gert Doering wrote:
> I have stared a bit at the code, and it all looks sane (though kp@ and
> Antonio are the experts here, anyway :-) ).  I have not tested things
> beyond "passes client/server tests, with and without DCO" - my kernel
> does not have the new code bits yet (and for a real tests, one would
> have to modify it to send OVPN_NOTIF_ROTATE_KEY after like 1000 packets
> or so...).
>
> There were a few indentations that uncrustify did not like, so fixed
> those one the fly (only whitespace).
>
> Your patch has been applied to the master and release/2.6 branch
> (this is somewhere between "bugfix" and "long-term compatibility",
> and less of a "new feature").
>
> commit ec71489bfc7c1d798f5f6de8e9fc187b9127072c (master)
> commit c468af2cd90c9f682519eff38a21fac8a3feb148 (release/2.6)
> Author: Kristof Provost
> Date:   Fri Apr 14 11:42:27 2023 +0200
>
>      DCO: support key rotation notifications
>
>      Signed-off-by: Kristof Provost <kprovost@...2661...>
>      Acked-by: Antonio Quartulli <antonio@...515...>
>      Message-Id: <20230414094227.9153-1-kprovost@...2661...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg26590.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
Thanks!

I=E2=80=99ve also landed the (FreeBSD) kernel side of that: https://cgit.fr=
eebsd.org/src/commit/?id=3Df7ee28e755820375d5f441e19c1f1376a200e834


Best regards,
Kristof

