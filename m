From: Heiko Hund <heiko@...2662...>
Date: Mon, 15 Aug 2022 17:14:39 +0200
Message-ID: <3399057.xBRZb38MpD@...2664...>
In-Reply-To: <20210518122635.2235658-1-arne@...1227...>
References: <20210125125628.30364-11-arne@...1227...>
 <20210518122635.2235658-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Implement --client-crresponse script
 options and plugin interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Dienstag, 18. Mai 2021 14:26:35 CEST Arne Schwabe wrote:
> This is allows scripts and pluginsto parse/react to a CR_RESPONSE message

This commit message needs a makeover, I think.

> -  If ``method`` is set to :code:`via-env`, OpenVPN will call ``script``
> +  If ``method`` is set to :code:`via-env`, OpenVPN will call ``cmd``

These drive-by fixes Antonio spotted make sense and are not intrusive enough 
that I care.

> +verify_crresponse_script(struct tls_multi *multi, const char *cr_response)
[...]
> +    const char *tmp_file = platform_create_temp_file(session->opt->tmp_dir,
> "cr", &gc); 
> +    if (tmp_file)
> +    {
> +        struct status_output *so = status_open(tmp_file, 0, -1, NULL,
> +                                               STATUS_OUTPUT_WRITE);
> +        status_printf(so, "%s", cr_response);
> +        if (!status_close(so))
> +        {
> +            msg(D_TLS_ERRORS, "TLS CR Response Error: could not write cr"
> +                              "responsed to file: %s",
> +                tmp_file);
> +            tls_deauthenticate(multi);
> +            goto done;
> +        }
> +    }
> +    else
> +    {
> +        msg(D_TLS_ERRORS, "TLS Auth Error: could not create write "
> +                          "username/password to temp file");
> +    }

This else branch should be the same as the "if (!status_close(so))" one above 
I think, as you don't want to call the script without a valid tempfile. 
Besides that the error message is copy/paste wrong anyway. So, maybe introduce 
a bool and do the error handling in one place, might help future copy/pastes 
as well.




