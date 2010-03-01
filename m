Date: Mon, 1 Mar 2010 17:48:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100301164816.GF9556@...1296...>
References: <1267365582-13629-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1267365582-13629-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] enhance tls-verify possibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 28, 2010 at 02:59:42PM +0100, David Sommerseth wrote:
> It should be nice to enhance tls-verify check possibilities against peer
> cert during a pending TLS connection like :
> - OCSP verification
> - check any X509 extensions of the peer certificate
> - delta CRL verification
> - ...

semi-ACK.

In general, I think this is useful.  

Most of the code is fine, but I spotted a potential issue:

> @@ -896,6 +950,12 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
>        argv_msg_prefix (D_TLS_DEBUG, &argv, "TLS: executing verify command");
>        ret = openvpn_execve (&argv, opt->es, S_SCRIPT);
>  
> +      if (opt->verify_export_cert)
> +        {
> +           delete_file(tmp_file);
> +           gc_free(&gc);
> +        }
> +
>        if (system_ok (ret))
>  	{
>  	  msg (D_HANDSHAKE, "VERIFY SCRIPT OK: depth=%d, %s",

tmp_file *could* be NULL here (unlikely, but possible).  

So maybe this should read:

> @@ -896,6 +950,12 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
>        argv_msg_prefix (D_TLS_DEBUG, &argv, "TLS: executing verify command");
>        ret = openvpn_execve (&argv, opt->es, S_SCRIPT);
>  
> +      if (opt->verify_export_cert)
> +        {
> +           if (tmp_file != NULL) delete_file(tmp_file);
> +           gc_free(&gc);
> +        }
> +
>        if (system_ok (ret))
>  	{
>  	  msg (D_HANDSHAKE, "VERIFY SCRIPT OK: depth=%d, %s",

... instead.  "delete_file()" is one of the few functions that do not
check their argument for "is not NULL", so it's passed unchanged to
unlink(), which might cause issues on some platforms.

(Don't put the tmp_file condition into the surrounding if(), as it 
would then skip the call to gc_free() as well).


With that change, and a manpage documentation of the new option, ACK.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

