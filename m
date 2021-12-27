MIME-Version: 1.0
References: <20211227111504.31173-1-gert@...1296...>
 <20211227201616.13315-1-gert@...1296...>
In-Reply-To: <20211227201616.13315-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 27 Dec 2021 15:34:31 -0500
Message-ID: <CAKuzo_id3DH6xv1U3gkbjDyAYonGztby2LvNLK9odoAx0xcdow@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] fix Changes.rst errors in 2.5.3 and
 2.5.5 announcement
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Acked-By:  Selva Nair <selva.nair@...277...>

On Mon, Dec 27, 2021 at 3:17 PM Gert Doering <gert@...1296...> wrote:
>
> - 2.5.3 had a typo in the CVE ID (CVE-2121-3606 should be -2021-)
> - 2.5.5 had windows paths with backslashes, which need to be doubled
>
> (CVE ID typo also reported by "@attritionorg" in Github PR 165)
>
> v2: SSL -> ssl, and .cfg -> .cnf
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  Changes.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index b6f98d51..4e4f2018 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -18,8 +18,8 @@ New features
>  - Windows build: use CFG and Spectre mitigations on MSVC builds
>
>  - bring back OpenSSL config loading to Windows builds.
> -  OpenSSL config is loaded from %installdir%\SSL\openssl.cfg
> -  (typically: c:\program files\openvpn\SSL\openssl.cfg) if it exists.
> +  OpenSSL config is loaded from %installdir%\\ssl\\openssl.cnf
> +  (typically: c:\\program files\\openvpn\\ssl\\openssl.cnf) if it exists.
>
>    This is important for some hardware tokens which need special
>    OpenSSL config for correct operation.  Trac #1296
> @@ -102,7 +102,7 @@ Overview of changes in 2.5.3
>  ============================
>  Bugfixes
>  --------
> -- CVE-2121-3606
> +- CVE-2021-3606
>    see https://community.openvpn.net/openvpn/wiki/SecurityAnnouncements
>
>    OpenVPN windows builds could possibly load OpenSSL Config files from

--
Selva

