MIME-Version: 1.0
References: <20260414055721.16857-1-gert@...1296...>
 <202604141631.63EGV6ea032386@...2054...>
In-Reply-To: <202604141631.63EGV6ea032386@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 14 Apr 2026 12:43:58 -0400
Message-ID: <CAKuzo_hEqNHtmhqtUJPXpcuqjAc6vYQXsMB7k0BgrkA_xBu2Sw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Log when writing
 username/password to TLS buffer fails
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

> I have not tested it - I guess one needs a GUI with "long password"
support to trigger it :-)

Not really.. long passwords work via the console even in pre-2.6 ! A
password longer than about 1700 bytes will trigger it.


Selva

On Tue, Apr 14, 2026 at 12:31=E2=80=AFPM Gert Doering <gert@...1296...> wro=
te:
>
> Thanks, this makes sense - if we fail, we want to tell the user what
> happened (even if we then continue to run in silly circles).
>
> I have not tested it - I guess one needs a GUI with "long password"
> support to trigger it :-) - but since the code path is clear enough
> and the patch only adds msg() calls, I guess a compile test is fine.
>
> Your patch has been applied to the master and release/2.7 branch
> (I put this into "documentation improvement").
>
> commit fd1fd077ea7781be8be6e05f2a2b657619c7e437 (master)
> commit 784ba7a2019539db028cd98beaa42e8921394cdf (release/2.7)
> Author: Selva Nair
> Date:   Tue Apr 14 07:57:14 2026 +0200
>
>      Log when writing username/password to TLS buffer fails
>
>      Signed-off-by: Selva Nair <selva.nair@...277...>
>      Acked-by: Arne Schwabe <arne-openvpn@...1227...>
>      Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1600
>      Message-Id: <20260414055721.16857-1-gert@...1296...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg36604.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>

