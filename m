MIME-Version: 1.0
In-Reply-To: <1514542738-20402-1-git-send-email-steffan.karger@...1435...>
References: <CAKuzo_jJx0U0hEnuv=BFGm_d6ME4JP44mDCCoBPwzCBdRs+dVA@...278...>
 <1514542738-20402-1-git-send-email-steffan.karger@...1435...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 2 Jan 2018 14:19:51 -0500
Message-ID: <CAKuzo_hHXfVBAp48kjsWy5ZUT22LyfMe2rCiz8evHyJrtYw0VQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Don't throw fatal errors from
 verify_cert_export_cert()
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Dec 29, 2017 at 5:18 AM, Steffan Karger
<steffan.karger@...1435...> wrote:
> As with create_temp_file(), this function is called on client connects and
> should not cause fatal errors when I/O (possibly temporarily) fails.
>
> The callers of this function are already fixed in the commit that does the
> same for create_temp_file().
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: Use M_NONFATAL (instead of M_WARN/M_ERRNO), as suggested by Selva.
>
>  src/openvpn/ssl_verify.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index ebb1da2..0ba9f41 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -549,7 +549,7 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
>      if (!tmp_dir
>          || !(peercert_filename = create_temp_file(tmp_dir, "pcf", gc)))
>      {
> -        msg (M_WARN, "Failed to create peer cert file");
> +        msg(M_NONFATAL, "Failed to create peer cert file");
>          return NULL;
>      }
>
> @@ -557,13 +557,15 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
>      peercert_file = fopen(peercert_filename, "w+");
>      if (!peercert_file)
>      {
> -        msg(M_ERR, "Failed to open temporary file : %s", peercert_filename);
> +        msg(M_NONFATAL|M_ERRNO, "Failed to open temporary file: %s",
> +            peercert_filename);
>          return NULL;
>      }
>
>      if (SUCCESS != x509_write_pem(peercert_file, peercert))

The openssl version of x509_write_pem() called here could fail with
M_ERR --- is that already fixed in one of the pending patches? If not,
why not make that one too non-fatal?

>      {
> -        msg(M_ERR, "Error writing PEM file containing certificate");
> +        msg(M_NONFATAL, "Error writing PEM file containing certificate");

Yeah, not including M_ERRNO looks like the right thing to do here.

> +        peercert_filename = NULL;

This could potentially lead to a stale tempfile left behind. Could be
fixed by unlinking here? Successfully exported cert file does get unlinked
after the verify script returns.

Sorry, earlier I only made a hasty remark about the error flag and did not do
a proper review...

>      }
>
>      fclose(peercert_file);
> --

Best wishes for 2018!

Selva

