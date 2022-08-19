From: Heiko Hund <heiko@...2662...>
Date: Fri, 19 Aug 2022 13:41:14 +0200
Message-ID: <9658970.MHjcdcH5BU@...2664...>
In-Reply-To: <20220819095132.94873-1-arne@...1227...>
References: <20210125125628.30364-11-arne@...1227...>
 <20220819095132.94873-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v4] Implement --client-crresponse script
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

On Freitag, 19. August 2022 11:51:32 CEST Arne Schwabe wrote:
> +verify_crresponse_script(struct tls_multi *multi, const char *cr_response)
> +{
[...]
> +        if (!status_close(so))
> +        {
> +            msg(D_TLS_ERRORS, "TLS CR Response Error: could not write cr"
> +                "responsed to file: %s",
> +                tmp_file);
> +            tls_deauthenticate(multi);
> +            goto done;
> +        }
> +    }
> +    else
> +    {
> +        msg(D_TLS_ERRORS, "TLS Auth Error: could not write "
> +            "username/password to cr response temp file");

The message is still wrong. Which proves my point about unifying it.




