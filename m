MIME-Version: 1.0
References: <20190724152934.9884-1-arne@...1227...>
 <201908161931.x7GJVqP9044592@...2054...>
In-Reply-To: <201908161931.x7GJVqP9044592@...2054...>
From: Rosen Penev <rosenp@...277...>
Date: Fri, 16 Aug 2019 12:42:46 -0700
Message-ID: <CAKxU2N8dmzKb4ui85BYeoGgCyOtXNT2bOcgsC5HCCGsTNjUMYQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: openssl: Fix compilation
 without deprecated OpenSSL 1.1 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Aug 16, 2019 at 12:31 PM Gert Doering <gert@...1296...> wrote:
>
> Your patch has been applied to the master branch.
>
> Is this also suitable for release/2.4?  "You folks tell me, I do the
> cherry-picking" (if it applies) :-)
2.4 is what I did my testing on, so yes.
>
> I have removed the extra spaces in "# if" constructs, as this is not
> something we use elsewhere on nested CPP expressions (it came up in the
> discussion, but was still part of this patch).
>
> Tested lightly with openssl 1.0.2o and 1.1.1.
>
> commit 8a01147ff77e4ae2e377744b89fbe4b6841b2bb0 (master)
> Author: Rosen Penev
> Date:   Wed Jul 24 17:29:34 2019 +0200
>
>      openssl: Fix compilation without deprecated OpenSSL 1.1 APIs
>
>      Signed-off-by: Rosen Penev <rosenp@...277...>
>      Signed-off-by: Arne Schwabe <arne@...1227...>
>      Acked-by: Rosen Penev <rosenp@...277...>
>      Acked-by: Steffan Karger <steffan.karger@...1435...>
>      Message-Id: <20190724152934.9884-1-arne@...1227...>
>      URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18700.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>

